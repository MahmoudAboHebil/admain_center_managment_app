import 'package:admain_center_managment_app/config/theme/colors.dart';
import 'package:admain_center_managment_app/contexts/center_management_context/domain/entities/study_level_entity.dart';
import 'package:admain_center_managment_app/contexts/center_management_context/presentation/widgets/loading/student_grid_skeleton.dart';
import 'package:admain_center_managment_app/contexts/center_management_context/presentation/widgets/student_card.dart';
import 'package:admain_center_managment_app/sync_engine/data/models/student_model.dart';
import 'package:flutter/material.dart';
import 'package:isar/isar.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/enums/division_enum.dart';
import '../../../../core/enums/payment_type_enum.dart';
import '../../../../core/enums/student_status_enum.dart';
import '../../../../core/isar_local_database/isar/collections/student_collection.dart';
import '../../../../core/isar_local_database/isar/isar_service.dart';
import '../../../../sync_engine/domain/entities/student_entity.dart';
import 'add_student_cart_button.dart';

class StudentsGrid extends StatefulWidget {
  const StudentsGrid({super.key, this.filterDataList, required this.isLoading});

  final List<StudentEntity>? filterDataList;
  final bool isLoading;

  @override
  State<StudentsGrid> createState() => _StudentsGridState();
}

class _StudentsGridState extends State<StudentsGrid> {
  late Stream<List<StudentCollection>> studentStream;
  @override
  void initState() {
    super.initState();
    studentStream = IsarService.isar.studentCollections
        .filter()
        .isDeletedEqualTo(false)
        .sortByCreatedAtDesc()
        .watch(fireImmediately: true)
        .asBroadcastStream();
  }

  @override
  Widget build(BuildContext context) {
    /// todo: you need handle this
    if (widget.isLoading) {
      return const StudentGridSkeleton();
    }

    // Case 1: Filtered data
    if (widget.filterDataList != null) {
      return _buildGrid(_mapStudents(widget.filterDataList!));
    }

    // Case 2: Stream data
    return StreamBuilder<List<StudentCollection>>(
      stream: studentStream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const StudentGridSkeleton();
        }

        if (snapshot.hasError) {
          ///todo:you need handle this
          return const Center(child: Text("Something went wrong"));
        }

        final data = snapshot.data ?? [];

        if (data.isEmpty) {
          return _buildGrid([]);
        }

        return _buildGrid(_mapCollections(data));
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
            mainAxisSpacing: 24,
            childAspectRatio: 1.6,
            mainAxisExtent: 140,
          ),
          itemBuilder: (context, index) {
            if (index == children.length) {
              return AddStudentCartButton(
                isDesktop: constraints.maxWidth >= 1024,
              );
            }
            return children[index];
          },
        );
      },
    );
  }

  /// ----------------------------
  /// 🔹 Mapping (Optimized)
  /// ----------------------------

  List<Widget> _mapStudents(List<StudentEntity> list) {
    List<Widget> myWidgetsList = [];
    for (var item in list.indexed) {
      var e = item.$2;
      StudyLevelEntity? level;
      for (var item in studyLevels) {
        if (item.entityId == e.studyLevelId) {
          level = item;
        }
      }
      final division = e.divisionEnum;

      var widget = _buildStudentCard(
        student: e,
        sideColor: item.$1 % 2 == 0 ? AppColors.primary : AppColors.secondary,
        level: division == null
            ? level?.arabicName ?? ''
            : '${level?.arabicName ?? ''} • ${division.description}',
        status: e.studentStatus.description,
        isStatusGreen: e.studentStatus == StudentStatus.active,
        subStatus:
            e.paymentTypeEnum?.description ??
            PaymentTypeEnum.byMonth.description,
        isStatusRed: e.studentStatus == StudentStatus.latePayment,
      );
      myWidgetsList.add(widget);
    }
    return myWidgetsList;
  }

  List<Widget> _mapCollections(List<StudentCollection> list) {
    List<Widget> myWidgetsList = [];
    for (var item in list.indexed) {
      var e = item.$2;
      StudyLevelEntity? level;
      for (var item in studyLevels) {
        if (item.entityId == e.studyLevelId) {
          level = item;
        }
      }

      final division = e.divisionEnum == null
          ? null
          : DivisionEnum.getDivisionFromString(e.divisionEnum!);

      final payment = e.paymentTypeEnum == null
          ? PaymentTypeEnum.byMonth
          : PaymentTypeEnum.getPaymentFromString(e.paymentTypeEnum!);

      final statusEnum = StudentStatus.getStudentStatusEnumFromString(
        e.studentStatus,
      );
      final div = (division == null || division == DivisionEnum.Division)
          ? null
          : division;
      final lev = (level == null || level.order == 0) ? null : level;
      Widget myWidget = _buildStudentCard(
        student: StudentModel.fromCollection(e).toEntity(),
        sideColor: item.$1 % 2 == 0 ? AppColors.primary : AppColors.secondary,
        level: (div == null)
            ? lev?.arabicName ?? ''
            : '${lev?.arabicName ?? ''} • ${div.description}',
        status: statusEnum.description,
        isStatusGreen: e.studentStatus == StudentStatus.active.name,
        subStatus: payment.description,
        isStatusRed: e.studentStatus == StudentStatus.latePayment.name,
      );
      myWidgetsList.add(myWidget);
    }
    return myWidgetsList;
  }

  /// ----------------------------
  /// 🔹 Reusable Card
  /// ----------------------------

  Widget _buildStudentCard({
    required StudentEntity student,
    required String level,
    required Color sideColor,
    required String status,
    required bool isStatusGreen,
    required bool isStatusRed,
    required String subStatus,
  }) {
    return StudentCard(
      student: student,
      sideColor: sideColor,
      level: level,
      status: status,
      isStatusGreen: isStatusGreen,
      subStatus: subStatus,
      isStatusRed: isStatusRed,
    );
  }
}
