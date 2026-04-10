import 'package:admain_center_managment_app/contexts/center_management_context/presentation/screens/mobile_app_screens/students_list_screen.dart';
import 'package:admain_center_managment_app/core/enums/languages.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../config/theme/app_theme.dart';
import '../../../../../config/theme/colors.dart';
import '../../../../../core/constants/constants.dart';
import '../../../../../core/enums/division_enum.dart';
import '../../../../../core/enums/payment_type_enum.dart';
import '../../../../../core/enums/student_status_enum.dart';
import '../../../../../core/providers/language_provider.dart';
import '../../../../../generated/l10n.dart';
import '../../../../../injection_container.dart';
import '../../../../../sync_engine/domain/entities/student_entity.dart';
import '../../../domain/entities/filter_params.dart';
import '../../../domain/entities/study_level_entity.dart';
import '../../../domain/repository/student_repository.dart';
import '../../widgets/build_section_title.dart';
import '../../widgets/custom_user_status_card.dart';
import '../../widgets/payment_toggle.dart';
import '../../widgets/students_filter_app_bar.dart';

class StudentFilterScreen extends ConsumerStatefulWidget {
  final FilterParams? initialParams;
  const StudentFilterScreen({super.key, this.initialParams});

  @override
  ConsumerState<StudentFilterScreen> createState() =>
      _StudentFilterScreenState();
}

class _StudentFilterScreenState extends ConsumerState<StudentFilterScreen> {
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
    final language = ref.watch(languageProvider).value;

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
                  BuildSectionTitle(title: S.of(context).studyClass),

                  const SizedBox(height: 8),
                  StudyLevelDropDown(language == Language.ar),
                ],
              ),
              const SizedBox(height: 24),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BuildSectionTitle(title: S.of(context).division),

                  const SizedBox(height: 8),
                  DivisionDropDown(language == Language.ar),
                ],
              ),
              const SizedBox(height: 24),

              Row(
                children: [
                  Expanded(
                    child: CustomUserStatusCard(
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
                    child: CustomUserStatusCard(
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
                    child: CustomUserStatusCard(
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
              BuildSectionTitle(title: S.of(context).paymentType),
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
                      child: PaymentToggle(
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
                      child: PaymentToggle(
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
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: AwesomeSnackbarContent(
                      inMaterialBanner: true,
                      title: S.of(context).wrongHappened,
                      message: S.of(context).tryAgainLater,
                      contentType: ContentType.failure,
                    ),
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                  ),
                );
              } finally {
                if (mounted) {
                  setState(() => isLoading = false);
                }
              }
            },
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 10),
              minimumSize: const Size(double.infinity, 50),
            ),
            icon: Stack(
              alignment: Alignment.center,
              clipBehavior: Clip.none,
              children: [
                Opacity(
                  opacity: isLoading ? 0 : 1,
                  child: Text(
                    S.of(context).applyFilters,
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                    ),
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
                ? Icon(Icons.filter_alt, size: 17.sp)
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
          throw failure;
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
      rethrow;
    }
  }

  Widget StudyLevelDropDown(bool isArabic) {
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
                      isArabic
                          ? selectedStudyLevel.arabicName
                          : selectedStudyLevel.englishName,
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
                                  isArabic ? item.arabicName : item.englishName,
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

  Widget DivisionDropDown(bool isArabic) {
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
                      isArabic
                          ? selectedDivision.arabic
                          : selectedDivision.english,
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
                                      isArabic ? item.arabic : item.english,
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
}
