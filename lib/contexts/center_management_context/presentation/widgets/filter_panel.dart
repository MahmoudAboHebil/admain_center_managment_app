import 'package:admain_center_managment_app/contexts/center_management_context/domain/entities/study_level_entity.dart';
import 'package:admain_center_managment_app/core/constants/constants.dart';
import 'package:admain_center_managment_app/core/enums/division_enum.dart';
import 'package:admain_center_managment_app/core/enums/payment_type_enum.dart';
import 'package:admain_center_managment_app/core/enums/student_status_enum.dart';
import 'package:flutter/material.dart';

import '../../../../config/theme/colors.dart';

class FilterParams {
  final PaymentTypeEnum? selectedPaymentType;
  final StudyLevelEntity selectedStudyLevel;
  final DivisionEnum selectedDivision;
  final StudentStatus? selectedStudentStates;
  const FilterParams({
    required this.selectedPaymentType,
    required this.selectedStudentStates,
    required this.selectedDivision,
    required this.selectedStudyLevel,
  });

  @override
  String toString() {
    return 'FilterParams{selectedPaymentType: $selectedPaymentType, selectedStudyLevel: $selectedStudyLevel, selectedDivision: $selectedDivision, selectedStudentStates: $selectedStudentStates}';
  }
}

class FilterPanel extends StatefulWidget {
  final Function(FilterParams) onChange;
  const FilterPanel({required this.onChange, super.key});

  @override
  State<FilterPanel> createState() => _FilterPanelState();
}

class _FilterPanelState extends State<FilterPanel> {
  bool isLoading = false;
  bool isOpenStudy = false;
  bool isOpenDivision = false;
  PaymentTypeEnum? selectedPaymentType;
  StudyLevelEntity selectedStudyLevel = studyLevelsWithAll.first;
  DivisionEnum selectedDivision = DivisionEnum.all;
  StudentStatus? selectedStudentStates;

  void selectStudy(StudyLevelEntity item) {
    setState(() {
      selectedStudyLevel = item;
      isOpenStudy = false;
    });
  }

  void selectDivision(DivisionEnum item) {
    setState(() {
      selectedDivision = item;
      isOpenDivision = false;
    });
  }

  void toggleMenuStudy() {
    setState(() {
      isOpenStudy = !isOpenStudy;
    });
  }

  void toggleMenuDivision() {
    setState(() {
      isOpenDivision = !isOpenDivision;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.outlineVariant.withOpacity(0.2)),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.surfaceContainerLowest,
              border: Border(
                bottom: BorderSide(
                  color: AppColors.outlineVariant.withOpacity(0.1),
                ),
              ),
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(12),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Row(
                  children: [
                    Icon(Icons.filter_alt, color: AppColors.primary, size: 20),
                    SizedBox(width: 8),
                    Text(
                      'خيارات التصفية',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                TextButton(
                  onPressed: () {
                    setState(() {
                      selectedPaymentType = null;
                      selectedStudyLevel = studyLevelsWithAll.first;
                      selectedDivision = DivisionEnum.all;
                      selectedStudentStates = null;
                    });
                  },
                  child: const Text(
                    'إعادة تعيين',
                    style: TextStyle(
                      color: AppColors.onSurfaceVariant,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(24),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    Text(
                      "المرحلة الدراسية",
                      style: const TextStyle(
                        color: AppColors.onSurfaceVariant,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    StudyLevelDropDown(),
                  ],
                ),
                const SizedBox(width: 24),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "الشعبة",
                      style: const TextStyle(
                        color: AppColors.onSurfaceVariant,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    DivisionDropDown(),
                  ],
                ),
                const SizedBox(width: 24),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'نظام الدفع',
                        style: TextStyle(
                          color: AppColors.onSurfaceVariant,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          selectedPaymentType == PaymentTypeEnum.byMonth
                              ? ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      selectedPaymentType = null;
                                    });
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.primary
                                        .withOpacity(0.05),
                                    foregroundColor: AppColors.primary,
                                    elevation: 0,
                                    minimumSize: Size(0, 0),

                                    padding: EdgeInsets.zero,
                                    fixedSize: Size(95, 35),
                                    shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                        color: AppColors.primary,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  child: const Text(
                                    'اشتراك شهري',
                                    style: TextStyle(fontSize: 11),
                                  ),
                                )
                              : OutlinedButton(
                                  onPressed: () {
                                    setState(() {
                                      selectedPaymentType =
                                          PaymentTypeEnum.byMonth;
                                    });
                                  },
                                  style: ElevatedButton.styleFrom(
                                    foregroundColor: AppColors.onSurface,
                                    side: BorderSide(
                                      color: AppColors.outlineVariant
                                          .withOpacity(0.2),
                                    ),
                                    minimumSize: Size(0, 0),
                                    padding: EdgeInsets.zero,
                                    fixedSize: Size(95, 35),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  child: const Text(
                                    'اشتراك شهري',
                                    style: TextStyle(fontSize: 11),
                                  ),
                                ),
                          const SizedBox(width: 8),
                          selectedPaymentType == PaymentTypeEnum.byClass
                              ? ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      selectedPaymentType = null;
                                    });
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.primary
                                        .withOpacity(0.05),
                                    foregroundColor: AppColors.primary,
                                    elevation: 0,
                                    minimumSize: Size(0, 0),
                                    padding: EdgeInsets.zero,
                                    fixedSize: Size(95, 35),
                                    shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                        color: AppColors.primary,
                                      ),

                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  child: const Text(
                                    'بالحصة',
                                    style: TextStyle(fontSize: 11),
                                  ),
                                )
                              : OutlinedButton(
                                  onPressed: () {
                                    setState(() {
                                      selectedPaymentType =
                                          PaymentTypeEnum.byClass;
                                    });
                                  },
                                  style: ElevatedButton.styleFrom(
                                    foregroundColor: AppColors.onSurface,
                                    side: BorderSide(
                                      color: AppColors.outlineVariant
                                          .withOpacity(0.2),
                                    ),
                                    minimumSize: Size(0, 0),
                                    padding: EdgeInsets.zero,
                                    fixedSize: Size(95, 35),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  child: const Text(
                                    'بالحصة',
                                    style: TextStyle(fontSize: 11),
                                  ),
                                ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 24),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'حالة الطالب',
                        style: TextStyle(
                          color: AppColors.onSurfaceVariant,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 8,
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                if (selectedStudentStates ==
                                    StudentStatus.active) {
                                  selectedStudentStates = null;
                                } else {
                                  selectedStudentStates = StudentStatus.active;
                                }
                              });
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 6,
                              ),
                              decoration:
                                  selectedStudentStates == StudentStatus.active
                                  ? BoxDecoration(
                                      color: AppColors.primary.withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(16),
                                      border: Border.all(
                                        color: AppColors.primary,
                                      ),
                                    )
                                  : BoxDecoration(
                                      color: AppColors.surfaceContainerLow,
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                              child: Text(
                                'نشط',

                                style:
                                    selectedStudentStates ==
                                        StudentStatus.active
                                    ? TextStyle(
                                        color: AppColors.primary,
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                      )
                                    : TextStyle(
                                        color: AppColors.onSurfaceVariant,
                                        fontSize: 10,
                                      ),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                if (selectedStudentStates ==
                                    StudentStatus.inactive) {
                                  selectedStudentStates = null;
                                } else {
                                  selectedStudentStates =
                                      StudentStatus.inactive;
                                }
                              });
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 6,
                              ),
                              decoration:
                                  selectedStudentStates ==
                                      StudentStatus.inactive
                                  ? BoxDecoration(
                                      color: AppColors.primary.withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(16),
                                      border: Border.all(
                                        color: AppColors.primary,
                                      ),
                                    )
                                  : BoxDecoration(
                                      color: AppColors.surfaceContainerLow,
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                              child: Text(
                                'غير نشط',
                                style:
                                    selectedStudentStates ==
                                        StudentStatus.inactive
                                    ? TextStyle(
                                        color: AppColors.primary,
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                      )
                                    : TextStyle(
                                        color: AppColors.onSurfaceVariant,
                                        fontSize: 10,
                                      ),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                if (selectedStudentStates ==
                                    StudentStatus.latePayment) {
                                  selectedStudentStates = null;
                                } else {
                                  selectedStudentStates =
                                      StudentStatus.latePayment;
                                }
                              });
                            },

                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 6,
                              ),
                              decoration:
                                  selectedStudentStates ==
                                      StudentStatus.latePayment
                                  ? BoxDecoration(
                                      color: AppColors.primary.withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(16),
                                      border: Border.all(
                                        color: AppColors.primary,
                                      ),
                                    )
                                  : BoxDecoration(
                                      color: AppColors.surfaceContainerLow,
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                              child: Text(
                                'متاخر فى الدفع',
                                style:
                                    selectedStudentStates ==
                                        StudentStatus.latePayment
                                    ? TextStyle(
                                        color: AppColors.primary,
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                      )
                                    : TextStyle(
                                        color: AppColors.onSurfaceVariant,
                                        fontSize: 10,
                                      ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            decoration: BoxDecoration(
              color: AppColors.surfaceContainerLow,
              border: Border(
                top: BorderSide(
                  color: AppColors.outlineVariant.withOpacity(0.1),
                ),
              ),
              borderRadius: const BorderRadius.vertical(
                bottom: Radius.circular(12),
              ),
            ),
            alignment: Alignment.centerLeft, // Since it's RTL
            child: ElevatedButton(
              onPressed: () async {
                if (isLoading) return;
                setState(() {
                  isLoading = true;
                });
                try {
                  final data = FilterParams(
                    selectedPaymentType: selectedPaymentType,
                    selectedStudentStates: selectedStudentStates,
                    selectedDivision: selectedDivision,
                    selectedStudyLevel: selectedStudyLevel,
                  );
                  if (!mounted) return;

                  await widget.onChange(data);
                  await Future.delayed(Duration(milliseconds: 400));
                } finally {
                  if (mounted) {
                    setState(() => isLoading = false);
                  }
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: AppColors.onPrimary,
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 16,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Stack(
                alignment: Alignment.center,
                clipBehavior: Clip.none,
                children: [
                  Opacity(
                    opacity: isLoading ? 0 : 1,
                    child: Text(
                      'تطبيق التصفية',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  isLoading
                      ? SizedBox(
                          height: 16,
                          width: 16,
                          child: CircularProgressIndicator(
                            strokeWidth: 2.5,
                            color: AppColors.onPrimary,
                          ),
                        )
                      : SizedBox(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget StudyLevelDropDown() {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: isOpenStudy ? AppColors.surfaceContainerLow : null,
        border: Border.all(
          color: !isOpenStudy
              ? Colors.transparent
              : AppColors.outlineVariant.withOpacity(0.2),
          width: 1.2,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onTap: toggleMenuStudy,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              width: 260,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              decoration: BoxDecoration(
                color: AppColors.surfaceContainerLow,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: isOpenStudy
                      ? Colors.transparent
                      : AppColors.outlineVariant.withOpacity(0.2),
                  width: 1.2,
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      selectedStudyLevel.arabicName,
                      style: TextStyle(fontSize: 14, color: AppColors.primary),
                    ),
                  ),
                  AnimatedRotation(
                    turns: isOpenStudy ? 0.5 : 0,
                    duration: const Duration(milliseconds: 300),
                    child: const Icon(Icons.keyboard_arrow_down_rounded),
                  ),
                ],
              ),
            ),
          ),
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 250),
              opacity: isOpenStudy ? 1 : 0,
              child: IgnorePointer(
                ignoring: !isOpenStudy,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  width: 260,
                  padding: const EdgeInsets.symmetric(vertical: 0),
                  decoration: BoxDecoration(
                    color: AppColors.surfaceContainerLow,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(12),
                      bottomRight: Radius.circular(12),
                    ),
                  ),
                  child: SizedBox(
                    height: isOpenStudy ? 150 : 0,
                    child: ListView(
                      primary: false,
                      shrinkWrap: true,
                      children: studyLevelsWithAll.map((item) {
                        return TextButton(
                          style: ButtonStyle(
                            shape: WidgetStatePropertyAll(
                              RoundedRectangleBorder(),
                            ),
                          ),
                          onPressed: () {
                            selectStudy(item);
                          },
                          child: Column(
                            children: [
                              Container(
                                width: double.infinity,
                                height: 1,
                                color: AppColors.outlineVariant.withOpacity(
                                  0.2,
                                ),
                              ),
                              Container(
                                width: double.infinity,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 12,
                                ),

                                child: Text(
                                  item.arabicName,
                                  style: TextStyle(
                                    color: AppColors.onSurface.withOpacity(0.7),
                                    fontSize: 13,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget DivisionDropDown() {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: isOpenDivision ? AppColors.surfaceContainerLow : null,
        border: Border.all(
          color: !isOpenDivision
              ? Colors.transparent
              : AppColors.outlineVariant.withOpacity(0.2),
          width: 1.2,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onTap: toggleMenuDivision,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              width: 260,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              decoration: BoxDecoration(
                color: AppColors.surfaceContainerLow,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: isOpenDivision
                      ? Colors.transparent
                      : AppColors.outlineVariant.withOpacity(0.2),
                  width: 1.2,
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      selectedDivision.description,
                      style: TextStyle(fontSize: 14, color: AppColors.primary),
                    ),
                  ),
                  AnimatedRotation(
                    turns: isOpenDivision ? 0.5 : 0,
                    duration: const Duration(milliseconds: 300),
                    child: const Icon(Icons.keyboard_arrow_down_rounded),
                  ),
                ],
              ),
            ),
          ),
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 250),
              opacity: isOpenDivision ? 1 : 0,
              child: IgnorePointer(
                ignoring: !isOpenDivision,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  width: 260,
                  padding: const EdgeInsets.symmetric(vertical: 0),
                  decoration: BoxDecoration(
                    color: AppColors.surfaceContainerLow,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(12),
                      bottomRight: Radius.circular(12),
                    ),
                  ),
                  child: SizedBox(
                    height: isOpenDivision ? 150 : 0,
                    child: ListView(
                      primary: false,
                      shrinkWrap: true,
                      children: DivisionEnum.values.map((item) {
                        return TextButton(
                          style: ButtonStyle(
                            shape: WidgetStatePropertyAll(
                              RoundedRectangleBorder(),
                            ),
                          ),
                          onPressed: () {
                            selectDivision(item);
                          },
                          child: Column(
                            children: [
                              Container(
                                width: double.infinity,
                                height: 1,
                                color: AppColors.outlineVariant.withOpacity(
                                  0.2,
                                ),
                              ),
                              Container(
                                width: double.infinity,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 12,
                                ),

                                child: Text(
                                  item.description,
                                  style: TextStyle(
                                    color: AppColors.onSurface.withOpacity(0.7),
                                    fontSize: 13,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
