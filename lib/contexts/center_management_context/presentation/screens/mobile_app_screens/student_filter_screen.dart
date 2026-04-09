import 'package:admain_center_managment_app/contexts/center_management_context/presentation/screens/mobile_app_screens/students_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../config/theme/app_theme.dart';
import '../../../../../config/theme/colors.dart';
import '../../../../../core/constants/constants.dart';
import '../../../../../core/enums/division_enum.dart';
import '../../../../../core/enums/payment_type_enum.dart';
import '../../../../../core/enums/student_status_enum.dart';
import '../../../../../generated/l10n.dart';
import '../../../../../injection_container.dart';
import '../../../../../sync_engine/domain/entities/student_entity.dart';
import '../../../domain/entities/study_level_entity.dart';
import '../../../domain/repository/student_repository.dart';

class StudentFilterScreen extends StatefulWidget {
  final FilterParams? initialParams;
  const StudentFilterScreen({super.key, this.initialParams});

  @override
  State<StudentFilterScreen> createState() => _StudentFilterScreenState();
}

class _StudentFilterScreenState extends State<StudentFilterScreen> {
  bool isLoading = false;
  bool isOpenStudy = false;
  bool isOpenDivision = false;
  late PaymentTypeEnum? selectedPaymentType;
  late StudyLevelEntity selectedStudyLevel;
  late DivisionEnum selectedDivision;
  late StudentStatus? selectedStudentStates;
  List<StudentEntity> filterDataList = [];
  @override
  void initState() {
    super.initState();
    selectedPaymentType = widget.initialParams?.selectedPaymentType;
    selectedStudyLevel =
        widget.initialParams?.selectedStudyLevel ?? studyLevelsWithAll.first;
    selectedDivision =
        widget.initialParams?.selectedDivision ?? DivisionEnum.all;
    selectedStudentStates = widget.initialParams?.selectedStudentStates;
  }

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
    return SafeArea(
      child: Scaffold(
        appBar: StudentsFilterAppBar(
          onClickingReset: () {
            setState(() {
              selectedPaymentType = null;
              selectedStudyLevel = studyLevelsWithAll.first;
              selectedDivision = DivisionEnum.all;
              selectedStudentStates = null;
            });
          },
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSectionTitle(S.of(context).studyClass),

                  const SizedBox(height: 8),
                  StudyLevelDropDown(),
                ],
              ),
              const SizedBox(height: 24),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSectionTitle(S.of(context).division),

                  const SizedBox(height: 8),
                  DivisionDropDown(),
                ],
              ),
              const SizedBox(height: 24),

              Row(
                children: [
                  Expanded(
                    child: _buildStatusCard(
                      icon: Icons.how_to_reg,
                      label: S.of(context).active,
                      isSelected: selectedStudentStates == StudentStatus.active,
                      onTap: () {
                        setState(() {
                          if (selectedStudentStates == StudentStatus.active) {
                            selectedStudentStates = null;
                          } else {
                            selectedStudentStates = StudentStatus.active;
                          }
                        });
                      },
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildStatusCard(
                      icon: Icons.person_off,
                      label: S.of(context).inactive,
                      isSelected:
                          selectedStudentStates == StudentStatus.inactive,
                      onTap: () {
                        setState(() {
                          if (selectedStudentStates == StudentStatus.inactive) {
                            selectedStudentStates = null;
                          } else {
                            selectedStudentStates = StudentStatus.inactive;
                          }
                        });
                      },
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildStatusCard(
                      icon: Icons.schedule,
                      label: S.of(context).latePayment,
                      isSelected:
                          selectedStudentStates == StudentStatus.latePayment,
                      onTap: () {
                        setState(() {
                          if (selectedStudentStates ==
                              StudentStatus.latePayment) {
                            selectedStudentStates = null;
                          } else {
                            selectedStudentStates = StudentStatus.latePayment;
                          }
                        });
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              // Payment System
              _buildSectionTitle(S.of(context).paymentType),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: AppTheme.surfaceContainer,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: _buildPaymentToggle(
                        label: S.of(context).byMonth,
                        isSelected:
                            selectedPaymentType == PaymentTypeEnum.byMonth,
                        onTap: () {
                          setState(() {
                            if (selectedPaymentType ==
                                PaymentTypeEnum.byMonth) {
                              selectedPaymentType = null;
                            } else {
                              selectedPaymentType = PaymentTypeEnum.byMonth;
                            }
                          });
                        },
                      ),
                    ),
                    Expanded(
                      child: _buildPaymentToggle(
                        label: S.of(context).byClass,
                        isSelected:
                            selectedPaymentType == PaymentTypeEnum.byClass,
                        onTap: () {
                          setState(() {
                            if (selectedPaymentType ==
                                PaymentTypeEnum.byClass) {
                              selectedPaymentType = null;
                            } else {
                              selectedPaymentType = PaymentTypeEnum.byClass;
                            }
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              const SizedBox(height: 80), // Padding for bottom bar
            ],
          ),
        ),
        bottomSheet: Container(
          color: AppTheme.surface.withOpacity(0.95),
          padding: const EdgeInsets.fromLTRB(24, 20, 24, 40),
          child: ElevatedButton.icon(
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
                await getFilterData(data);
                await Future.delayed(Duration(milliseconds: 400));
                Navigator.pushAndRemoveUntil(
                  context,
                  PageRouteBuilder(
                    transitionDuration: Duration(milliseconds: 300),
                    reverseTransitionDuration: Duration(milliseconds: 300),

                    pageBuilder: (context, animation, secondaryAnimation) {
                      return StudentsListScreen(
                        filterDataList: filterDataList,
                        params: data,
                      );
                    },

                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) {
                          final slide = Tween<Offset>(
                            begin: Offset(1, 0),
                            end: Offset.zero,
                          ).animate(animation);

                          final fade = Tween<double>(
                            begin: 0.0,
                            end: 1.0,
                          ).animate(animation);

                          return FadeTransition(
                            opacity: fade,
                            child: SlideTransition(
                              position: slide,
                              child: child,
                            ),
                          );
                        },
                  ),
                  (route) => false,
                );
              } finally {
                if (mounted) {
                  setState(() => isLoading = false);
                }
              }
            },
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(vertical: 10),
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              minimumSize: const Size(double.infinity, 0),
            ),
            icon: Stack(
              alignment: Alignment.center,
              clipBehavior: Clip.none,
              children: [
                Opacity(
                  opacity: isLoading ? 0 : 1,
                  child: Text(
                    S.of(context).applyFilters,
                    style: TextStyle(fontSize: 13.sp),
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
            label: !isLoading
                ? Icon(Icons.filter_alt, size: 24.sp)
                : SizedBox(),
          ),
        ),
      ),
    );
  }

  Future<void> getFilterData(FilterParams filterKeys) async {
    try {
      final dataResponse = await sl<StudentRepository>()
          .getAllItemsNotArchived();

      if (!mounted) return;

      dataResponse.fold(
        ifLeft: (failure) {
          ///todo: handle error
        },
        ifRight: (data) {
          if (data.isNotEmpty) {
            StudyLevelEntity? study =
                filterKeys.selectedStudyLevel.arabicName ==
                    studyLevelsWithAll.first.arabicName
                ? null
                : filterKeys.selectedStudyLevel;

            DivisionEnum? division =
                filterKeys.selectedDivision == DivisionEnum.all
                ? null
                : filterKeys.selectedDivision;

            final newData = data.where((e) {
              bool studyCon = study == null
                  ? true
                  : e.studyLevelId == study.entityId;
              bool divisionCon;
              if (division == null || e.divisionEnum == null) {
                divisionCon = true;
              } else {
                divisionCon = e.divisionEnum == division;
              }
              bool statesCon = filterKeys.selectedStudentStates == null
                  ? true
                  : e.studentStatus == filterKeys.selectedStudentStates;
              bool paymentCon;

              if (filterKeys.selectedPaymentType == null ||
                  e.paymentTypeEnum == null) {
                paymentCon = true;
              } else {
                paymentCon =
                    e.paymentTypeEnum == filterKeys.selectedPaymentType;
              }
              return studyCon && divisionCon && statesCon && paymentCon;
            }).toList();
            setState(() {
              filterDataList = newData;
            });
          }
        },
      );
    } catch (e) {
      /// todo: you need handle this
    }
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: GoogleFonts.manrope(fontSize: 13.sp, fontWeight: FontWeight.bold),
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
                      style: TextStyle(
                        fontSize: 13.sp,
                        color: AppColors.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  AnimatedRotation(
                    turns: isOpenStudy ? 0.5 : 0,
                    duration: const Duration(milliseconds: 300),
                    child: Icon(Icons.keyboard_arrow_down_rounded, size: 24.sp),
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
                            padding: WidgetStatePropertyAll(EdgeInsets.zero),
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
                                    fontSize: 12.sp,
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
                      selectedDivision.arabic,
                      style: TextStyle(
                        fontSize: 13.sp,
                        color: AppColors.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  AnimatedRotation(
                    turns: isOpenDivision ? 0.5 : 0,
                    duration: const Duration(milliseconds: 300),
                    child: Icon(Icons.keyboard_arrow_down_rounded, size: 24.sp),
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
                      children: DivisionEnum.values
                          .where((element) => element != DivisionEnum.Division)
                          .map((item) {
                            return TextButton(
                              style: ButtonStyle(
                                padding: WidgetStatePropertyAll(
                                  EdgeInsets.zero,
                                ),
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
                                      item.arabic,
                                      style: TextStyle(
                                        color: AppColors.onSurface.withOpacity(
                                          0.7,
                                        ),
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          })
                          .toList(),
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

  Widget _buildStatusCard({
    required IconData icon,
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: isSelected ? AppTheme.primary : AppTheme.surfaceContainerHigh,
          borderRadius: BorderRadius.circular(12),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: AppTheme.primary.withOpacity(0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ]
              : null,
        ),
        child: Column(
          children: [
            Icon(
              icon,
              color: isSelected
                  ? AppTheme.onPrimary
                  : AppTheme.onSurfaceVariant,
              size: 24.sp,
            ),
            const SizedBox(height: 8),
            Text(
              label,
              style: GoogleFonts.manrope(
                fontSize: 10.sp,
                fontWeight: FontWeight.bold,
                color: isSelected
                    ? AppTheme.onPrimary
                    : AppTheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentToggle({
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: isSelected
              ? AppTheme.surfaceContainerLowest
              : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ]
              : null,
        ),
        alignment: Alignment.center,
        child: Text(
          label,
          style: GoogleFonts.manrope(
            fontSize: 11.sp,
            fontWeight: FontWeight.bold,
            color: isSelected ? AppTheme.primary : AppTheme.onSurfaceVariant,
          ),
        ),
      ),
    );
  }
}

class StudentsFilterAppBar extends StatefulWidget
    implements PreferredSizeWidget {
  final Function onClickingReset;

  const StudentsFilterAppBar({super.key, required this.onClickingReset});

  @override
  State<StudentsFilterAppBar> createState() => _StudentsFilterAppBarState();

  @override
  Size get preferredSize => Size.fromHeight(60);
}

class _StudentsFilterAppBarState extends State<StudentsFilterAppBar> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Container(
        height: 60,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: AppColors.surface.withOpacity(0.9),
          border: Border(
            bottom: BorderSide(
              color: AppColors.outlineVariant.withOpacity(0.1),
            ),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            IconButton(
              icon: Icon(Icons.close, size: 24.sp),
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  PageRouteBuilder(
                    transitionDuration: Duration(milliseconds: 300),
                    reverseTransitionDuration: Duration(milliseconds: 300),

                    pageBuilder: (context, animation, secondaryAnimation) {
                      return StudentsListScreen();
                    },
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) {
                          final slide = Tween<Offset>(
                            begin: Offset(1, 0),
                            end: Offset.zero,
                          ).animate(animation);

                          final fade = Tween<double>(
                            begin: 0.0,
                            end: 1.0,
                          ).animate(animation);

                          return FadeTransition(
                            opacity: fade,
                            child: SlideTransition(
                              position: slide,
                              child: child,
                            ),
                          );
                        },
                  ),
                  (route) => false,
                );
              },
            ),
            Text(
              S.of(context).filterResults,
              style: TextStyle(
                fontSize: 20.sp,
                color: AppColors.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
            Spacer(),
            TextButton(
              onPressed: () async {
                await widget.onClickingReset();
              },
              child: Text(
                S.of(context).reset,
                style: GoogleFonts.manrope(
                  fontSize: 13.sp,
                  color: AppTheme.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

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
