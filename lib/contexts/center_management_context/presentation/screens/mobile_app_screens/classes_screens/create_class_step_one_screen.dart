import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../../config/theme/app_theme.dart';
import '../../../../../../core/constants/constants.dart';
import '../../../../../../core/enums/division_enum.dart';
import '../../../../../../core/enums/languages.dart';
import '../../../../../../core/providers/language_provider.dart';
import '../../../../domain/entities/study_level_entity.dart';

class CreateClassStepOneScreen extends ConsumerStatefulWidget {
  const CreateClassStepOneScreen({super.key});

  @override
  ConsumerState<CreateClassStepOneScreen> createState() =>
      _CreateClassStepOneScreenState();
}

class _CreateClassStepOneScreenState
    extends ConsumerState<CreateClassStepOneScreen> {
  int selectedSemester = 0;
  bool isOpenStudy = false;
  bool isOpenDivision = false;
  late StudyLevelEntity selectedStudyLevel;
  late DivisionEnum selectedDivision;
  @override
  void initState() {
    super.initState();
    selectedStudyLevel = studyLevels.firstWhere(
      (element) => element.order == 0,
    );
    selectedDivision = DivisionEnum.Division;
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

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'المرحلة الاولى',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: AppTheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 4),
              const Text(
                'إنشاء فصل جديد',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                  color: AppTheme.primary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          const Text(
            'أضف المعلومات الأساسية لتعريف الفصل الدراسي الجديد.',
            style: TextStyle(fontSize: 14, color: AppTheme.onSurfaceVariant),
          ),
          const SizedBox(height: 32),

          // Class Name
          _buildLabel('اسم الفصل'),
          const SizedBox(height: 8),
          _buildTextField(hint: 'مثال: رياضيات متقدمة - المجموعة أ'),
          const SizedBox(height: 24),

          // Level Grid
          _buildLabel('الصف الدراسى'),
          const SizedBox(height: 8),
          StudyLevelDropDown(language == Language.ar),
          const SizedBox(height: 24),
          // Department Segmented Control
          _buildLabel('الفصل الدراسى'),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: AppTheme.surfaceContainer,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedSemester = 0;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        color: selectedSemester == 0
                            ? AppTheme.surfaceContainerLowest
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: selectedSemester == 0
                            ? [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.05),
                                  blurRadius: 4,
                                  offset: const Offset(0, 2),
                                ),
                              ]
                            : [],
                      ),
                      child: Center(
                        child: Text(
                          'الاول',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: selectedSemester == 0
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
                    onTap: () {
                      setState(() {
                        selectedSemester = 1;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        color: selectedSemester == 1
                            ? AppTheme.surfaceContainerLowest
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: selectedSemester == 1
                            ? [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.05),
                                  blurRadius: 4,
                                  offset: const Offset(0, 2),
                                ),
                              ]
                            : [],
                      ),
                      child: Center(
                        child: Text(
                          'الثانى',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: selectedSemester == 1
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
          ),
          const SizedBox(height: 24),
          _buildLabel('الشعبه'),
          const SizedBox(height: 8),
          DivisionDropDown(language == Language.ar),
          // Room Number
          const SizedBox(height: 24),
          _buildLabel('رقم القاعة'),
          const SizedBox(height: 8),
          _buildTextField(hint: 'مثال: 104', icon: Icons.meeting_room_outlined),
          const SizedBox(height: 32),

          // Visual Asset Card
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: AppTheme.primaryContainer.withOpacity(0.2),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'الهوية الأساسية',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: AppTheme.primary,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'تأكد من دقة البيانات الأساسية قبل الانتقال لجدولة المواعيد.',
                        style: TextStyle(
                          fontSize: 12,
                          color: AppTheme.onPrimaryContainer.withOpacity(0.8),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                Container(
                  width: 64,
                  height: 64,
                  decoration: const BoxDecoration(
                    color: AppTheme.primary,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.badge_outlined,
                    color: Colors.white,
                    size: 32,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 100), // Space for FAB
        ],
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: Text(
        text,
        style: const TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 14,
          color: AppTheme.onSurface,
        ),
      ),
    );
  }

  Widget _buildTextField({required String hint, IconData? icon}) {
    return TextField(
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(color: AppTheme.outline.withOpacity(0.6)),
        prefixIcon: icon != null ? Icon(icon, color: AppTheme.outline) : null,
        filled: true,
        fillColor: AppTheme.surfaceContainerHigh,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppTheme.primary, width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
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
        color: isOpenDivision ? AppTheme.surfaceContainerLow : null,
        border: Border.all(
          color: !isOpenDivision
              ? Colors.transparent
              : AppTheme.outlineVariant.withOpacity(0.2),
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
                color: AppTheme.surfaceContainerLow,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: isOpenDivision
                      ? Colors.transparent
                      : AppTheme.outlineVariant.withOpacity(0.2),
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
                    color: AppTheme.surfaceContainerLow,
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
                                    color: AppTheme.outlineVariant.withOpacity(
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
                                        color: AppTheme.onSurface.withOpacity(
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
        color: isOpenStudy ? AppTheme.surfaceContainerLow : null,
        border: Border.all(
          color: !isOpenStudy
              ? Colors.transparent
              : AppTheme.outlineVariant.withOpacity(0.2),
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
                color: AppTheme.surfaceContainerLow,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: isOpenStudy
                      ? Colors.transparent
                      : AppTheme.outlineVariant.withOpacity(0.2),
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
                    color: AppTheme.surfaceContainerLow,
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
                                color: AppTheme.outlineVariant.withOpacity(0.2),
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
                                    color: AppTheme.onSurface.withOpacity(0.7),
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
