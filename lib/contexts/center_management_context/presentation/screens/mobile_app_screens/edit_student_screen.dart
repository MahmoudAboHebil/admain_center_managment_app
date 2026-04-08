import 'package:admain_center_managment_app/contexts/center_management_context/presentation/screens/mobile_app_screens/students_list_screen.dart';
import 'package:admain_center_managment_app/contexts/center_management_context/presentation/widgets/custom_app_bar.dart';
import 'package:admain_center_managment_app/sync_engine/domain/entities/student_entity.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../config/theme/app_theme.dart';
import '../../../../../config/theme/colors.dart';
import '../../../../../core/constants/constants.dart';
import '../../../../../core/enums/division_enum.dart';
import '../../../../../core/enums/gender_enum.dart';
import '../../../../../core/enums/payment_type_enum.dart';
import '../../../../../core/helper/helper.dart';
import '../../../../../injection_container.dart';
import '../../../domain/entities/study_level_entity.dart';
import '../../../domain/repository/student_repository.dart';

class EditStudentScreen extends StatefulWidget {
  final StudentEntity studentEntity;
  const EditStudentScreen({super.key, required this.studentEntity});

  @override
  State<EditStudentScreen> createState() => _EditStudentScreenState();
}

class _EditStudentScreenState extends State<EditStudentScreen> {
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
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppTheme.surface,
        appBar: CustomAppBar(label: 'تعديل طالب'),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 24.0),
          child: Column(
            children: [
              // Section: Basic Data
              _buildSectionHeader('البيانات الأساسية', AppTheme.primary),
              _buildContainer([
                _buildLabelAndInput(
                  label: 'الاسم بالكامل',
                  child: CustomTextFiled(
                    initialValue: studentName,
                    hint: 'مثال: محمد أحمد علي',
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "اسم الطالب مطلوب";
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
                _buildLabelAndInput(
                  label: 'النوع',
                  child: _buildGenderSwitch(),
                ),
                const SizedBox(height: 16),
              ]),
              const SizedBox(height: 32),

              // Section: Contact Info
              _buildSectionHeader('معلومات التواصل', AppTheme.tertiary),
              _buildContainer([
                _buildLabelAndInput(
                  label: 'رقم هاتف الطالب',
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
                    title: 'رقم هاتف الطالب',
                    hint: '01XXXXXXXXX',
                    keyboardType: TextInputType.phone,
                  ),
                ),
                const SizedBox(height: 16),
                _buildLabelAndInput(
                  label: 'رقم هاتف ولي الأمر',
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
                    title: "رقم هاتف ولي الأمر",
                    hint: '01XXXXXXXXX',
                    keyboardType: TextInputType.phone,
                  ),
                ),
                const SizedBox(height: 16),
                _buildLabelAndInput(
                  label: 'رقم هاتف البيت',
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
                    title: 'رقم هاتف البيت',
                    hint: '01XXXXXXXXX',
                    keyboardType: TextInputType.phone,
                  ),
                ),
                const SizedBox(height: 16),
                _buildLabelAndInput(
                  label: 'البريد الإلكتروني',
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
                        return "البريد الإلكتروني غير صحيح";
                      }

                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 16),
                _buildLabelAndInput(
                  label: 'وظيفة ولي الأمر',
                  child: CustomTextFiled(
                    hint: 'المهنة',
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
              ]),
              const SizedBox(height: 32),

              // Section: Academic Path
              _buildSectionHeader('المسار الأكاديمي', const Color(0xFFA2B9EA)),
              _buildContainer([
                _buildLabelAndInput(
                  label: 'الصف الدراسية',
                  child: StudyLevelDropDown(),
                ),
                const SizedBox(height: 16),
                _buildLabelAndInput(label: 'الشعبة', child: DivisionDropDown()),
                const SizedBox(height: 16),
                _buildLabelAndInput(
                  label: 'المجموعة',
                  child: CustomTextFiled(hint: 'اسم أو كود المجموعة'),
                ),
              ]),
              const SizedBox(height: 32),

              // Section: Payment System
              _buildSectionHeader('نظام الدفع', const Color(0xFF575F72)),
              Row(
                children: [
                  _buildPaymentOption(
                    isSelected: _paymentMethod == 0,
                    label: 'اشتراك شهري',
                    icon: Icons.payments,
                    onTap: () => setState(() => _paymentMethod = 0),
                  ),
                  const SizedBox(width: 16),
                  _buildPaymentOption(
                    isSelected: _paymentMethod == 1,
                    label: 'بالحصة',
                    icon: Icons.receipt_long,
                    onTap: () => setState(() => _paymentMethod = 1),
                  ),
                ],
              ),
              const SizedBox(height: 32),

              // Section: Additional Notes
              _buildSectionHeader('ملاحظات إضافية', AppTheme.outline),
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
                hint: 'أي تفاصيل أخرى تخص الطالب...',
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
                            title: "بيانات غير مكتملة",
                            message: "اسم الطالب مطلوب",
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
                            title: "بيانات غير صحيحة",
                            message: "البريد الإلكتروني غير صحيح",
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
                                title: "حدث خطأ",
                                message:
                                    "تعذر إتمام العملية، يرجى المحاولة لاحقًا",
                                contentType: ContentType.failure,
                              ),
                              backgroundColor: Colors.transparent,
                              elevation: 0,
                            ),
                          );
                        },
                        ifRight: (response) {
                          if (response == null) {
                            Navigator.pushReplacement(
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
                            );

                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: AwesomeSnackbarContent(
                                  inMaterialBanner: true,
                                  title: "تم بنجاح",
                                  message: "تم تعديل الطالب",
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
                                  title: "حدث خطأ",
                                  message:
                                      "تعذر إتمام العملية، يرجى المحاولة لاحقًا",
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
                          title: "حدث خطأ",
                          message: "تعذر إتمام العملية، يرجى المحاولة لاحقًا",
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
                  minimumSize: const Size(double.infinity, 56),
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
                            'حفظ',
                            style: GoogleFonts.inter(
                              fontSize: 18,
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
                  minimumSize: const Size(double.infinity, 56),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  'إلغاء',
                  style: GoogleFonts.inter(
                    fontSize: 16,
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

  Widget _buildSectionHeader(String title, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        children: [
          Container(
            width: 4,
            height: 24,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          const SizedBox(width: 8),
          Text(
            title,
            style: GoogleFonts.inter(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppTheme.onSurface,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContainer(List<Widget> children) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: children,
      ),
    );
  }

  Widget _buildLabelAndInput({required String label, required Widget child}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 4.0, bottom: 6.0),
          child: Text(
            label,
            style: GoogleFonts.inter(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: AppTheme.onSurfaceVariant,
            ),
          ),
        ),
        child,
      ],
    );
  }

  Widget DivisionDropDown() {
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
                      selectedDivision.description,
                      style: GoogleFonts.inter(
                        color: AppTheme.onSurface,
                        fontWeight: FontWeight.bold,
                      ),
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
                                      item.description,
                                      style: TextStyle(
                                        color: AppColors.onSurface.withOpacity(
                                          0.7,
                                        ),
                                        fontSize: 13,
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

  Widget _buildGenderSwitch() {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: AppTheme.surfaceContainerHigh,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () => setState(() => _isMale = true),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: _isMale
                    ? BoxDecoration(
                        color: AppTheme.surfaceContainerLowest,
                        borderRadius: BorderRadius.circular(6),
                        boxShadow: const [
                          BoxShadow(color: Colors.black12, blurRadius: 4),
                        ],
                      )
                    : null,
                child: Center(
                  child: Text(
                    'ذكر',
                    style: GoogleFonts.inter(
                      fontWeight: _isMale ? FontWeight.bold : FontWeight.w500,
                      color: _isMale
                          ? AppTheme.primary
                          : AppTheme.onSurfaceVariant,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () => setState(() => _isMale = false),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: !_isMale
                    ? BoxDecoration(
                        color: AppTheme.surfaceContainerLowest,
                        borderRadius: BorderRadius.circular(6),
                        boxShadow: const [
                          BoxShadow(color: Colors.black12, blurRadius: 4),
                        ],
                      )
                    : null,
                child: Center(
                  child: Text(
                    'أنثى',
                    style: GoogleFonts.inter(
                      fontWeight: !_isMale ? FontWeight.bold : FontWeight.w500,
                      color: !_isMale
                          ? AppTheme.primary
                          : AppTheme.onSurfaceVariant,
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

  Widget _buildPaymentOption({
    required bool isSelected,
    required String label,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: isSelected
                ? AppTheme.surfaceContainerLowest
                : AppTheme.surfaceContainerLow,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isSelected
                  ? AppTheme.primaryContainer
                  : Colors.transparent,
              width: 2,
            ),
            boxShadow: isSelected
                ? const [BoxShadow(color: Colors.black12, blurRadius: 4)]
                : [],
          ),
          child: Stack(
            alignment: Alignment.center,
            clipBehavior: Clip.none,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    icon,
                    color: isSelected
                        ? AppTheme.primary
                        : AppTheme.onSurfaceVariant,
                    size: 28,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    label,
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: isSelected
                          ? FontWeight.bold
                          : FontWeight.w500,
                      color: isSelected
                          ? AppTheme.onSurface
                          : AppTheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
              Positioned(
                top: -8,
                right: -8, // Top Right
                child: isSelected
                    ? Container(
                        width: 16,
                        height: 16,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: AppTheme.primary, width: 2),
                        ),
                        child: Center(
                          child: Container(
                            width: 8,
                            height: 8,
                            decoration: const BoxDecoration(
                              color: AppTheme.primary,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                      )
                    : Container(
                        width: 16,
                        height: 16,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: AppTheme.outlineVariant,
                            width: 2,
                          ),
                        ),
                      ),
              ),
            ],
          ),
        ),
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
                      selectedStudyLevel.arabicName,
                      style: GoogleFonts.inter(
                        color: AppTheme.onSurface,
                        fontWeight: FontWeight.bold,
                      ),
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
}

class TextPhoneWidget extends StatefulWidget {
  const TextPhoneWidget({
    super.key,
    required this.initialValue,
    required this.title,
    this.hint,
    this.keyboardType,
    this.prefixIcon,
    required this.onChange,
  });

  final String? initialValue;
  final String title;
  final String? hint;
  final Function(ParsedPhone?) onChange;

  final TextInputType? keyboardType;
  final IconData? prefixIcon;

  @override
  State<TextPhoneWidget> createState() => _TextPhoneWidgetState();
}

class _TextPhoneWidgetState extends State<TextPhoneWidget> {
  final int maxLines = 1;
  final Color fillColor = AppTheme.surfaceContainerLowest;
  late TextEditingController phoneController;
  late String countryCode;

  @override
  void initState() {
    super.initState();
    if (widget.initialValue != null && widget.initialValue!.isNotEmpty) {
      final parsed = Helper.parsePhone(widget.initialValue!);
      phoneController = TextEditingController(text: parsed.phone);
      countryCode = parsed.countryCode;
    } else {
      countryCode = "+20";
      phoneController = TextEditingController();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CountryCodePicker(
          initialSelection: countryCode,
          onChanged: (code) async {
            setState(() {
              countryCode = code.dialCode!;
            });
            await widget.onChange(
              ParsedPhone(
                countryCode: countryCode,
                phone: phoneController.text,
              ),
            );
          },
        ),
        Expanded(
          child: TextField(
            onChanged: (val) async {
              await widget.onChange(
                ParsedPhone(countryCode: countryCode, phone: val),
              );
            },
            keyboardType: widget.keyboardType,
            maxLines: maxLines,
            controller: phoneController,
            decoration: InputDecoration(
              hintText: widget.hint,
              filled: true,
              fillColor: fillColor,
              contentPadding: const EdgeInsets.all(16),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: AppTheme.primary, width: 2),
              ),
            ),
            style: GoogleFonts.inter(color: AppTheme.onSurface),
          ),
        ),
      ],
    );
  }
}

class CustomTextFiled extends StatefulWidget {
  final Function(String)? onChange;
  final Function(String?)? validator;
  final String? hint;
  final TextInputType? keyboardType;
  final IconData? prefixIcon;
  final String? initialValue;
  final int maxLines;
  final Color fillColor;

  const CustomTextFiled({
    super.key,
    this.onChange,
    this.validator,
    this.hint,
    this.keyboardType,
    this.prefixIcon,
    this.initialValue,
    this.fillColor = AppTheme.surfaceContainerLowest,
    this.maxLines = 1,
  });

  @override
  State<CustomTextFiled> createState() => _CustomTextFiledState();
}

class _CustomTextFiledState extends State<CustomTextFiled> {
  late final TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController(text: widget.initialValue);
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: widget.keyboardType,
      maxLines: widget.maxLines,
      validator: (value) {
        return widget.validator != null ? widget.validator!(value) : null;
      },
      autovalidateMode: AutovalidateMode.onUserInteraction,
      onChanged: widget.onChange,
      decoration: InputDecoration(
        hintText: widget.hint,
        // Because of RTL, setting prefixIcon might be on the right.
        // We put the icon where we want based on design.
        prefixIcon: widget.prefixIcon != null
            ? Icon(widget.prefixIcon, color: AppTheme.outlineVariant)
            : null,
        filled: true,
        fillColor: widget.fillColor,
        contentPadding: const EdgeInsets.all(16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppTheme.primary, width: 2),
        ),
      ),
      style: GoogleFonts.inter(color: AppTheme.onSurface),
    );
  }
}
