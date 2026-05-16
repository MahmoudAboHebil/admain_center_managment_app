import 'package:admain_center_managment_app/contexts/center_management_context/domain/entities/study_level_entity.dart';
import 'package:admain_center_managment_app/contexts/center_management_context/presentation/widgets/class_card.dart';
import 'package:admain_center_managment_app/contexts/center_management_context/presentation/widgets/error_widgets/app_error_widget.dart';
import 'package:admain_center_managment_app/core/enums/languages.dart';
import 'package:admain_center_managment_app/core/isar_local_database/isar/collections/class_collection.dart';
import 'package:admain_center_managment_app/sync_engine/data/models/class_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';

import '../../../../config/theme/app_theme.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/enums/division_enum.dart';
import '../../../../core/isar_local_database/isar/isar_service.dart';
import '../../../../core/providers/language_provider.dart';
import 'add_class_cart_button.dart';
import 'loading_widgets/student_grid_skeleton.dart';

class ClassesGrid extends ConsumerStatefulWidget {
  const ClassesGrid({super.key});

  @override
  ConsumerState<ClassesGrid> createState() => _StudentsGridState();
}

class _StudentsGridState extends ConsumerState<ClassesGrid> {
  late Stream<List<ClassCollection>> classStream;
  @override
  void initState() {
    super.initState();
    classStream = IsarService.isar.classCollections
        .filter()
        .isDeletedEqualTo(false)
        .sortByCreatedAtDesc()
        .watch(fireImmediately: true)
        .asBroadcastStream();
  }

  @override
  Widget build(BuildContext context) {
    final language = ref.watch(languageProvider).value;
    return StreamBuilder<List<ClassCollection>>(
      stream: classStream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          //todo: edite here
          return const StudentGridSkeleton();
        }

        if (snapshot.hasError) {
          return const AppErrorWidget();
        }

        final data = snapshot.data ?? [];

        if (data.isEmpty) {
          return _buildGrid([]);
        }

        return _buildGrid(
          _mapCollections(data, (language == Language.ar) ? true : false),
        );
      },
    );
  }

  /// ----------------------------
  /// 🔹 UI Builders
  /// ----------------------------

  Widget _buildGrid(List<Widget> children) {
    return LayoutBuilder(
      builder: (context, constraints) {
        int crossAxisCount = 1;

        if (constraints.maxWidth >= 1400) {
          crossAxisCount = 5;
        } else if (constraints.maxWidth >= 1200) {
          crossAxisCount = 4;
        } else if (constraints.maxWidth >= 900) {
          crossAxisCount = 3;
        } else if (constraints.maxWidth >= 600) {
          crossAxisCount = 2;
        } else {
          crossAxisCount = 1;
        }

        return GridView.builder(
          itemCount: children.length + 1, // + Add button
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: 24,
            mainAxisSpacing: 12,
            childAspectRatio: 1.6,
            mainAxisExtent: 290,
          ),
          itemBuilder: (context, index) {
            if (index == children.length) {
              return AddClassCartButton();
            }
            return children[index];
          },
        );
      },
    );
  }

  List<Widget> _mapCollections(List<ClassCollection> list, bool isArabic) {
    List<Widget> myWidgetsList = [];

    for (var item in list.indexed) {
      var e = item.$2;
      StudyLevelEntity? level;
      for (var item in studyLevels) {
        if (item.entityId == e.studyLevelId) {
          level = item;
        }
      }

      final division = DivisionEnum.getDivisionFromString(e.divisionEnum);

      final div = (division == DivisionEnum.Division) ? null : division;
      final lev = (level == null || level.order == 0) ? null : level;

      final levelString = isArabic ? lev?.arabicName : lev?.englishName;
      final divString = isArabic ? div?.arabic : div?.english;
      Widget myWidget = ClassCard(
        title: e.name,
        studentsCount: 'X طالب',
        icon: Icons.school,
        iconColor: AppTheme.primary,
        iconBgColor: AppTheme.secondaryContainer.withOpacity(0.3),
        studyLevel: (div == null)
            ? levelString ?? ''
            : '${levelString ?? ''}${(levelString == null || divString == null) ? "" : " • "}${divString}'
                      .trim() +
                  " • " +
                  ((e.semester == 0)
                      ? 'الفصل الدراسى الاول'
                      : 'الفصل الدراسى الثانى'),
        location: e.room,
        entity: ClassModel.fromCollection(e).toEntity(),
      );
      myWidgetsList.add(myWidget);
    }
    return myWidgetsList;
  }
}
