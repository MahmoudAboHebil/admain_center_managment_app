import 'package:admain_center_managment_app/contexts/center_management_context/domain/entities/study_level_entity.dart';
import 'package:admain_center_managment_app/contexts/center_management_context/presentation/widgets/loading/student_grid_skeleton.dart';
import 'package:admain_center_managment_app/contexts/center_management_context/presentation/widgets/student_card.dart';
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

class StudentsGrid extends StatelessWidget {
  const StudentsGrid({super.key, this.filterDataList, required this.isLoading});

  final List<StudentEntity>? filterDataList;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const StudentGridSkeleton();
    }

    // Case 1: Filtered data
    if (filterDataList != null) {
      return _buildGrid(_mapStudents(filterDataList!));
    }

    // Case 2: Stream data
    return StreamBuilder<List<StudentCollection>>(
      stream: IsarService.isar.studentCollections
          .filter()
          .isDeletedEqualTo(false)
          .sortByCreatedAtDesc()
          .watch(fireImmediately: true),
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

        if (constraints.maxWidth > 1200) {
          crossAxisCount = 4;
        } else if (constraints.maxWidth > 800) {
          crossAxisCount = 3;
        }

        return GridView.builder(
          itemCount: children.length + 1, // + Add button
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: 24,
            mainAxisSpacing: 24,
            childAspectRatio: 2.1,
          ),
          itemBuilder: (context, index) {
            if (index == children.length) {
              return const AddStudentCartButton();
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
    return list.map((e) {
      StudyLevelEntity? level;
      for (var item in studyLevels) {
        if (item.entityId == e.studyLevelId) {
          level = item;
        }
      }
      final division = e.divisionEnum;

      return _buildStudentCard(
        name: e.name,
        level: division == null
            ? level?.arabicName ?? ''
            : '${level?.arabicName ?? ''} • ${division.description}',
        id: e.studentCode,
        status: e.studentStatus.description,
        isStatusGreen: e.studentStatus == StudentStatus.active,
        subStatus:
            e.paymentTypeEnum?.description ??
            PaymentTypeEnum.byMonth.description,
        isStatusRed: e.studentStatus == StudentStatus.latePayment,
      );
    }).toList();
  }

  List<Widget> _mapCollections(List<StudentCollection> list) {
    return list.map((e) {
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

      return _buildStudentCard(
        name: e.name,
        level: division == null
            ? level?.arabicName ?? ''
            : '${level?.arabicName ?? ''} • ${division.description}',
        id: e.studentCode,
        status: statusEnum.description,
        isStatusGreen: e.studentStatus == StudentStatus.active.name,
        subStatus: payment.description,
        isStatusRed: e.studentStatus == StudentStatus.latePayment.name,
      );
    }).toList();
  }

  /// ----------------------------
  /// 🔹 Reusable Card
  /// ----------------------------

  Widget _buildStudentCard({
    required String name,
    required String level,
    required String id,
    required String status,
    required bool isStatusGreen,
    required bool isStatusRed,
    required String subStatus,
  }) {
    return StudentCard(
      name: name,
      level: level,
      id: id,
      status: status,
      isStatusGreen: isStatusGreen,
      subStatus: subStatus,
      isStatusRed: isStatusRed,
    );
  }
}
