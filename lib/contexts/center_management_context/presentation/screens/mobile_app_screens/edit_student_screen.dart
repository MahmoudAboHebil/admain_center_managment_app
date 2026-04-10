import 'package:admain_center_managment_app/contexts/center_management_context/presentation/screens/mobile_app_screens/students_list_screen.dart';
import 'package:admain_center_managment_app/contexts/center_management_context/presentation/widgets/custom_app_bar.dart';
import 'package:admain_center_managment_app/contexts/center_management_context/presentation/widgets/payment_option_card.dart';
import 'package:admain_center_managment_app/core/enums/languages.dart';
import 'package:admain_center_managment_app/sync_engine/domain/entities/student_entity.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../config/theme/app_theme.dart';
import '../../../../../config/theme/colors.dart';
import '../../../../../core/constants/constants.dart';
import '../../../../../core/enums/division_enum.dart';
import '../../../../../core/enums/gender_enum.dart';
import '../../../../../core/enums/payment_type_enum.dart';
import '../../../../../core/providers/language_provider.dart';
import '../../../../../generated/l10n.dart';
import '../../../../../injection_container.dart';
import '../../../domain/entities/study_level_entity.dart';
import '../../../domain/repository/student_repository.dart';
import '../../widgets/build_custom_container.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/gender_switch.dart';
import '../../widgets/label_and_input.dart';
import '../../widgets/section_header.dart';
import '../../widgets/text_phone_widget.dart';

class EditStudentScreen extends ConsumerStatefulWidget {
  final StudentEntity studentEntity;
  const EditStudentScreen({super.key, required this.studentEntity});

  @override
  ConsumerState<EditStudentScreen> createState() => _EditStudentScreenState();
}

class _EditStudentScreenState extends ConsumerState<EditStudentScreen> {
  final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
  late String? studentPhone;
  late String? studentName;
  late String? parentPhone;
  late String? homePhone;
  late String? email;
  late String? parentJob;
  late String? studentNotes;
  late bool _isMale;
  late int _paymentMethod; // 0 for monthly, 1 for per session
  bool isLoading = false;
  bool isOpenStudy = false;
  bool isOpenDivision = false;
  late StudyLevelEntity selectedStudyLevel;
  late DivisionEnum selectedDivision;
  @override
  void initState() {
    super.initState();
    studentName = widget.studentEntity.name;
    studentPhone = widget.studentEntity.phone;
    parentPhone = widget.studentEntity.parentPhone;
    parentPhone = widget.studentEntity.parentPhone;
    homePhone = widget.studentEntity.homePhone;
    email = widget.studentEntity.email;
    parentJob = widget.studentEntity.parentJob;
    studentNotes = widget.studentEntity.notes;
    _isMale = widget.studentEntity.gender == Gender.male;
    _paymentMethod =
        widget.studentEntity.paymentTypeEnum == PaymentTypeEnum.byMonth ? 0 : 1;

    selectedStudyLevel =
        studyLevels.firstWhere(
          (element) => element.entityId == widget.studentEntity.studyLevelId,
        ) ??
        studyLevels.firstWhere((element) => element.order == 0);
    selectedDivision =
        widget.studentEntity.divisionEnum ?? DivisionEnum.Division;
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
        backgroundColor: AppTheme.surface,
        appBar: CustomAppBar(label: S.of(context).editStudent),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 24.0),
          child: Column(
            children: [
              // Section: Basic Data
              SectionHeader(
                title: S.of(context).primaryInfo,
                color: AppTheme.primary,
              ),
              BuildCustomContainer(
                children: [
                  LabelAndInput(
                    label: S.of(context).fullName,
                    child: CustomTextFiled(
                      initialValue: studentName,
                      hint: S.of(context).nameExample,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return S.of(context).nameRequired;
                        }

                        return null;
                      },
                      onChange: (value) {
                        setState(() {
                          if (value.isEmpty || value.trim().isEmpty) {
                            studentName = null;
                          } else {
                            studentName = value;
                          }
                        });
                        print(studentName);
                      },
                    ),
                  ),
                  const SizedBox(height: 16),
                  LabelAndInput(
                    label: S.of(context).type,
                    child: GenderSwitch(
                      onTapMale: () => setState(() => _isMale = true),
                      onTapFemail: () => setState(() => _isMale = false),
                      isMale: _isMale,
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
              const SizedBox(height: 32),

              // Section: Contact Info
              SectionHeader(
                title: S.of(context).contactInfo,
                color: AppTheme.tertiary,
              ),
              BuildCustomContainer(
                children: [
                  LabelAndInput(
                    label: S.of(context).studentPhone,
                    child: TextPhoneWidget(
                      initialValue: studentPhone,
                      onChange: (value) {
                        setState(() {
                          if (value == null || value.phone.trim().isEmpty) {
                            studentPhone = null;
                          } else {
                            studentPhone = value.toString();
                          }
                        });
                        print(studentPhone);
                      },
                      title: S.of(context).studentPhone,
                      hint: '01XXXXXXXXX',
                      keyboardType: TextInputType.phone,
                    ),
                  ),
                  const SizedBox(height: 16),
                  LabelAndInput(
                    label: S.of(context).parentPhone,
                    child: TextPhoneWidget(
                      initialValue: parentPhone,
                      onChange: (value) {
                        setState(() {
                          if (value == null || value.phone.trim().isEmpty) {
                            parentPhone = null;
                          } else {
                            parentPhone = value.toString();
                          }
                        });
                        print(parentPhone);
                      },
                      title: S.of(context).parentPhone,
                      hint: '01XXXXXXXXX',
                      keyboardType: TextInputType.phone,
                    ),
                  ),
                  const SizedBox(height: 16),
                  LabelAndInput(
                    label: S.of(context).homePhone,
                    child: TextPhoneWidget(
                      initialValue: homePhone,
                      onChange: (value) {
                        setState(() {
                          if (value == null || value.phone.trim().isEmpty) {
                            homePhone = null;
                          } else {
                            homePhone = value.toString();
                          }
                        });
                        print(homePhone);
                      },
                      title: S.of(context).homePhone,
                      hint: '01XXXXXXXXX',
                      keyboardType: TextInputType.phone,
                    ),
                  ),
                  const SizedBox(height: 16),
                  LabelAndInput(
                    label: S.of(context).email,
                    child: CustomTextFiled(
                      initialValue: email,
                      onChange: (value) {
                        setState(() {
                          if (value.isEmpty) {
                            email = null;
                          } else {
                            email = value;
                          }
                        });
                        print(email);
                      },
                      hint: 'example@mail.com',
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        // Regex for email validation
                        if (value == null || value.isEmpty) {
                          return null;
                        }
                        if (!emailRegex.hasMatch(value)) {
                          return S.of(context).emailNotValid;
                        }

                        return null;
                      },
                    ),
                  ),
                  const SizedBox(height: 16),
                  LabelAndInput(
                    label: S.of(context).parentJob,
                    child: CustomTextFiled(
                      hint: S.of(context).job,
                      initialValue: parentJob,
                      onChange: (value) {
                        setState(() {
                          if (value.isEmpty || value.trim().isEmpty) {
                            parentJob = null;
                          } else {
                            parentJob = value;
                          }
                        });
                        print(parentJob);
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),

              // Section: Academic Path
              SectionHeader(
                title: S.of(context).acadamicPath,
                color: const Color(0xFFA2B9EA),
              ),
              BuildCustomContainer(
                children: [
                  LabelAndInput(
                    label: S.of(context).studyClass,
                    child: StudyLevelDropDown(language == Language.ar),
                  ),
                  const SizedBox(height: 16),
                  LabelAndInput(
                    label: S.of(context).division,
                    child: DivisionDropDown(language == Language.ar),
                  ),
                  const SizedBox(height: 16),
                  LabelAndInput(
                    label: S.of(context).group,
                    child: CustomTextFiled(hint: 'اسم أو كود المجموعة'),
                  ),
                ],
              ),
              const SizedBox(height: 32),

              // Section: Payment System
              SectionHeader(
                title: S.of(context).paymentType,
                color: const Color(0xFF575F72),
              ),
              Row(
                children: [
                  Expanded(
                    child: PaymentOptionCard(
                      isSelected: _paymentMethod == 0,
                      label: S.of(context).byMonth,
                      icon: Icons.payments,
                      onTap: () => setState(() => _paymentMethod = 0),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: PaymentOptionCard(
                      isSelected: _paymentMethod == 1,
                      label: S.of(context).byClass,
                      icon: Icons.receipt_long,
                      onTap: () => setState(() => _paymentMethod = 1),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),

              // Section: Additional Notes
              SectionHeader(
                title: S.of(context).additionalNotes,
                color: AppTheme.outline,
              ),
              CustomTextFiled(
                initialValue: studentNotes,
                onChange: (value) {
                  setState(() {
                    if (value.trim().isEmpty) {
                      studentNotes = null;
                    } else {
                      studentNotes = value;
                    }
                  });
                  print(studentNotes);
                },
                hint: S.of(context).anyStudentDetails,
                maxLines: 4,
                fillColor: AppTheme.surfaceContainerLow,
              ),
              const SizedBox(height: 48),

              // Action Buttons
              ElevatedButton(
                onPressed: () async {
                  if (isLoading) return;
                  setState(() {
                    isLoading = true;
                  });
                  try {
                    if (studentName == null || studentName!.trim().isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: AwesomeSnackbarContent(
                            inMaterialBanner: true,
                            title: S.of(context).unCompleteDetails,
                            message: S.of(context).nameRequired,
                            contentType: ContentType.failure,
                          ),
                          backgroundColor: Colors.transparent,
                          elevation: 0,
                        ),
                      );
                      print('invalide name');
                    } else if (email != null &&
                        (email!.trim().isEmpty ||
                            !emailRegex.hasMatch(email!))) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: AwesomeSnackbarContent(
                            inMaterialBanner: true,
                            title: S.of(context).informationNotCorrect,
                            message: S.of(context).emailNotValid,
                            contentType: ContentType.failure,
                          ),
                          backgroundColor: Colors.transparent,
                          elevation: 0,
                        ),
                      );
                    } else {
                      final newEntity = StudentEntity(
                        entityId: widget.studentEntity.entityId,
                        centerId: widget.studentEntity.centerId,
                        byUser: currentUserId,
                        byDevice: widget.studentEntity.byDevice,
                        isDeleted: widget.studentEntity.isDeleted,
                        version: widget.studentEntity.version,
                        createdAt: widget.studentEntity.createdAt,
                        studentCode: widget.studentEntity.studentCode,
                        studentStatus: widget.studentEntity.studentStatus,
                        address: widget.studentEntity.address,
                        birthDate: widget.studentEntity.birthDate,
                        bookingDeposit: widget.studentEntity.bookingDeposit,
                        schoolName: widget.studentEntity.schoolName,
                        studentClasses: widget.studentEntity.studentClasses,
                        updatedAt: DateTime.now().toUtc(),
                        name: studentName!,
                        studyLevelId: selectedStudyLevel.entityId,
                        gender: _isMale ? Gender.male : Gender.female,
                        homePhone: homePhone,
                        phone: studentPhone,
                        paymentTypeEnum: _paymentMethod == 0
                            ? PaymentTypeEnum.byMonth
                            : PaymentTypeEnum.byClass,
                        parentPhone: parentPhone,
                        parentJob: parentJob,
                        notes: studentNotes,
                        divisionEnum: selectedDivision,
                        email: email,
                      );

                      final addResult = await sl<StudentRepository>()
                          .updateStudent(newEntity);
                      addResult.fold(
                        ifLeft: (e) {
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
                        },
                        ifRight: (response) {
                          if (response == null) {
                            Navigator.pushAndRemoveUntil(
                              context,
                              PageRouteBuilder(
                                transitionDuration: Duration(milliseconds: 300),
                                reverseTransitionDuration: Duration(
                                  milliseconds: 300,
                                ),

                                pageBuilder:
                                    (context, animation, secondaryAnimation) {
                                      return StudentsListScreen();
                                    },

                                transitionsBuilder:
                                    (
                                      context,
                                      animation,
                                      secondaryAnimation,
                                      child,
                                    ) {
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

                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: AwesomeSnackbarContent(
                                  inMaterialBanner: true,
                                  title: S.of(context).success,
                                  message: S.of(context).studentEdited,
                                  contentType: ContentType.success,
                                ),
                                backgroundColor: Colors.transparent,
                                elevation: 0,
                              ),
                            );
                          } else {
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
                          }
                        },
                      );
                    }
                    await Future.delayed(Duration(milliseconds: 250));
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
                  backgroundColor: AppTheme.primary,
                  foregroundColor: AppTheme.onPrimary,
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 4,
                  shadowColor: AppTheme.primary.withOpacity(0.4),
                ),
                child: Stack(
                  alignment: Alignment.center,
                  clipBehavior: Clip.none,
                  children: [
                    Opacity(
                      opacity: isLoading ? 0 : 1,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            S.of(context).save,
                            style: GoogleFonts.inter(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
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
              const SizedBox(height: 12),
              TextButton(
                onPressed: () => Navigator.pop(context),
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  foregroundColor: AppTheme.onSurfaceVariant,
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  S.of(context).cancel,
                  style: GoogleFonts.inter(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  Widget DivisionDropDown(bool isArabic) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
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
                      style: GoogleFonts.inter(
                        fontSize: 13.sp,

                        color: AppTheme.onSurface,
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
                      bottomLeft: Radius.circular(8),
                      bottomRight: Radius.circular(8),
                    ),
                  ),
                  child: SizedBox(
                    height: isOpenDivision ? 150 : 0,
                    child: ListView(
                      primary: false,
                      shrinkWrap: true,
                      children: DivisionEnum.values
                          .where((element) => element != DivisionEnum.all)
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
                borderRadius: BorderRadius.circular(8),
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
                      style: GoogleFonts.inter(
                        fontSize: 13.sp,

                        color: AppTheme.onSurface,
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
                      bottomLeft: Radius.circular(8),
                      bottomRight: Radius.circular(8),
                    ),
                  ),
                  child: SizedBox(
                    height: isOpenStudy ? 150 : 0,
                    child: ListView(
                      primary: false,
                      shrinkWrap: true,
                      children: studyLevels.map((item) {
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
}
