import 'package:admain_center_managment_app/contexts/center_management_context/presentation/screens/mobile_app_screens/students_list_screen.dart';
import 'package:admain_center_managment_app/core/constants/constants.dart';
import 'package:admain_center_managment_app/core/enums/languages.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../config/theme/app_theme.dart';
import '../../../../../config/theme/colors.dart';
import '../../../../../core/enums/division_enum.dart';
import '../../../../../core/providers/language_provider.dart';
import '../../../../../generated/l10n.dart';
import '../../../../../injection_container.dart';
import '../../../../../sync_engine/domain/entities/student_entity.dart';
import '../../../domain/entities/study_level_entity.dart';
import '../../../domain/repository/student_repository.dart';
import '../../widgets/bento_card.dart';
import '../../widgets/contact_row_card.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/section_header.dart';
import '../../widgets/user_state_card.dart';
import 'edit_student_screen.dart';

class StudentProfileScreen extends ConsumerStatefulWidget {
  final StudentEntity student;
  const StudentProfileScreen({super.key, required this.student});

  @override
  ConsumerState<StudentProfileScreen> createState() =>
      _StudentProfileScreenState();
}

class _StudentProfileScreenState extends ConsumerState<StudentProfileScreen> {
  bool isLoading = false;
  late final StudyLevelEntity level;
  @override
  void initState() {
    super.initState();
    level = studyLevels.firstWhere(
      (e) => e.entityId == widget.student.studyLevelId,
    );
  }

  @override
  Widget build(BuildContext context) {
    final language = ref.watch(languageProvider).value;
    final screenWidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(
          label: S.of(context).studentProfile,
          leadingWidget: MaterialButton(
            onPressed: () async {
              Navigator.push(
                context,
                PageRouteBuilder(
                  transitionDuration: Duration(milliseconds: 300),
                  reverseTransitionDuration: Duration(milliseconds: 300),

                  pageBuilder: (context, animation, secondaryAnimation) {
                    return EditStudentScreen(studentEntity: widget.student);
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
                          child: SlideTransition(position: slide, child: child),
                        );
                      },
                ),
              );
            },
            elevation: 0,
            hoverElevation: 0,
            disabledElevation: 0,
            highlightElevation: 0,
            focusElevation: 0,
            padding: EdgeInsets.zero,
            minWidth: 32,

            shape: CircleBorder(),
            child: Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: Colors.transparent,
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.edit, size: 20.sp, color: AppTheme.primary),
            ),
          ),
        ),

        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Hero Profile Header
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: AppTheme.surfaceContainerLowest,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Stack(
                  clipBehavior: Clip.none,
                  alignment: Alignment.topRight,
                  children: [
                    Positioned.directional(
                      top: -90,
                      start: -90,
                      textDirection: Directionality.of(context),
                      child: Container(
                        height: 130,
                        width: 130,
                        decoration: BoxDecoration(
                          color: Theme.of(context).scaffoldBackgroundColor,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                    Column(
                      children: [
                        Container(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Text(
                                  widget.student.name * 1,
                                  style: GoogleFonts.manrope(
                                    fontSize: 21.sp,
                                    fontWeight: FontWeight.w800,
                                    color: AppTheme.onSurface,
                                  ),
                                  maxLines: 4,
                                ),
                              ),
                              SizedBox(width: 12),
                              Padding(
                                padding: const EdgeInsets.only(top: 5.0),
                                child: UserStateCard(
                                  status: widget.student.studentStatus,
                                  isArabic: (language == Language.ar),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 24),
                        // Attendance Progress Ribbon
                        Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.calendar_today,
                                      color: AppTheme.primary,
                                      size: 20.sp,
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      S.of(context).attendanceRate,
                                      style: GoogleFonts.manrope(
                                        fontSize: 13.sp,
                                        fontWeight: FontWeight.bold,
                                        color: AppTheme.onSurfaceVariant,
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  '92%',
                                  style: GoogleFonts.manrope(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17.sp,
                                    color: AppTheme.primary,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(4),
                              child: const LinearProgressIndicator(
                                value: 0.92,
                                backgroundColor: AppTheme.tertiaryContainer,
                                color: AppTheme.tertiary,
                                minHeight: 8,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // Academic Info Bento
              Row(
                children: [
                  Expanded(
                    child: BentoCard(
                      icon: Icons.layers,
                      iconColor: AppTheme.tertiary,
                      title: S.of(context).className,
                      value: level.order == 0
                          ? S.of(context).notAdded
                          : ((language == Language.ar)
                                ? level.arabicName
                                : level.englishName),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: BentoCard(
                      icon: Icons.science,
                      iconColor: AppTheme.tertiary,
                      title: S.of(context).division,
                      value:
                          (widget.student.divisionEnum == null ||
                              widget.student.divisionEnum ==
                                  DivisionEnum.Division)
                          ? S.of(context).notAdded
                          : ((language == Language.ar)
                                ? widget.student.divisionEnum!.arabic
                                : widget.student.divisionEnum!.english),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppTheme.surfaceContainerLowest,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: AppTheme.outlineVariant.withOpacity(0.15),
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: AppTheme.secondaryContainer,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        Icons.groups,
                        size: 24.sp,

                        color: AppTheme.onSecondaryContainer,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          S.of(context).classSchedule,
                          style: GoogleFonts.inter(
                            fontSize: 11.sp,
                            fontWeight: FontWeight.w500,
                            color: AppTheme.onSurfaceVariant,
                          ),
                        ),
                        Text(
                          'مجموعة A - السبت والأربعاء',
                          style: GoogleFonts.manrope(
                            fontSize: 13.sp,
                            fontWeight: FontWeight.bold,
                            color: AppTheme.onSurface,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              // Contact Information
              SectionHeader(
                title: S.of(context).contactInfo,
                color: AppTheme.primary,
              ),
              const SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: ContactRowCard(
                  screenWidth: screenWidth,

                  context: context,

                  icon: Icons.smartphone,
                  title: S.of(context).studentPhone,
                  value: widget.student.phone,
                  hasCallAction: true,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: ContactRowCard(
                  screenWidth: screenWidth,
                  context: context,

                  icon: Icons.home,
                  title: S.of(context).homePhone,
                  value: widget.student.homePhone,
                  hasCallAction: true,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: ContactRowCard(
                  screenWidth: screenWidth,

                  context: context,

                  icon: Icons.family_restroom,
                  title: S.of(context).parentPhone,
                  value: widget.student.parentPhone,
                  hasCallAction: true,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: ContactRowCard(
                  screenWidth: screenWidth,
                  context: context,
                  icon: Icons.mail,
                  title: S.of(context).email,
                  value: widget.student.email,
                  hasCallAction: false,
                ),
              ),
              const SizedBox(height: 24),
              // Admin Details
              SectionHeader(
                title: S.of(context).administrativeDetails,
                color: AppTheme.tertiary,
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppTheme.surfaceContainerHigh,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            S.of(context).paymentType,
                            style: GoogleFonts.inter(
                              fontSize: 11.sp,
                              color: AppTheme.onSurfaceVariant,
                            ),
                          ),
                          const SizedBox(height: 4),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Text(
                              (language == Language.ar)
                                  ? widget.student.paymentTypeEnum.arabic
                                  : widget.student.paymentTypeEnum.english,
                              style: GoogleFonts.manrope(
                                fontSize: 13.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),

                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppTheme.surfaceContainerHigh,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            S.of(context).parentJob,
                            style: GoogleFonts.inter(
                              fontSize: 11.sp,
                              color: AppTheme.onSurfaceVariant,
                            ),
                          ),
                          const SizedBox(height: 4),
                          widget.student.parentJob != null
                              ? SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Text(
                                    widget.student.parentJob!,
                                    style: GoogleFonts.inter(
                                      fontSize: 13.sp,
                                      fontWeight: FontWeight.bold,
                                      color: AppTheme.onSurface,
                                    ),
                                  ),
                                )
                              : Text(
                                  S.of(context).notAdded,
                                  style: GoogleFonts.inter(
                                    fontSize: 13.sp,
                                    fontWeight: FontWeight.bold,
                                    color: AppTheme.error,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              // Notes
              if (widget.student.notes != null) ...[
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: AppTheme.surfaceContainer,
                    borderRadius: BorderRadius.circular(16),
                    border: const Border(
                      right: BorderSide(color: AppTheme.primary, width: 4),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.edit_note,
                            size: 24.sp,
                            color: AppTheme.primary,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            S.of(context).teacherNotes,
                            style: GoogleFonts.manrope(
                              fontSize: 13.sp,
                              fontWeight: FontWeight.bold,
                              color: AppTheme.primary,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        widget.student.notes!,
                        style: GoogleFonts.inter(
                          fontSize: 13.sp,
                          color: AppTheme.onSurfaceVariant,
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 40),
              ],

              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Container(
                      color: AppTheme.surface.withOpacity(0.95),
                      child: ElevatedButton.icon(
                        onPressed: () async {
                          Navigator.push(
                            context,
                            PageRouteBuilder(
                              transitionDuration: Duration(milliseconds: 300),
                              reverseTransitionDuration: Duration(
                                milliseconds: 300,
                              ),

                              pageBuilder:
                                  (context, animation, secondaryAnimation) {
                                    return EditStudentScreen(
                                      studentEntity: widget.student,
                                    );
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
                        },
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(double.infinity, 50),
                          backgroundColor: AppColors.primaryDim,
                          padding: EdgeInsets.symmetric(vertical: 10),
                        ),
                        icon: Text(
                          S.of(context).editStudent,
                          style: TextStyle(fontSize: 14.sp),
                        ),
                        label: Icon(Icons.edit, size: 17.sp),
                      ),
                    ),
                  ),

                  SizedBox(width: 12),
                  Expanded(
                    flex: 1,
                    child: Container(
                      color: AppTheme.surface.withOpacity(0.95),
                      child: ElevatedButton.icon(
                        onPressed: () async {
                          if (isLoading) return;
                          setState(() {
                            isLoading = true;
                          });
                          try {
                            final addResult = await sl<StudentRepository>()
                                .softDeleteStudent(widget.student);
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
                                  Navigator.pushReplacement(
                                    context,
                                    PageRouteBuilder(
                                      transitionDuration: Duration(
                                        milliseconds: 300,
                                      ),
                                      reverseTransitionDuration: Duration(
                                        milliseconds: 300,
                                      ),

                                      pageBuilder:
                                          (
                                            context,
                                            animation,
                                            secondaryAnimation,
                                          ) {
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
                                        title: S.of(context).success,
                                        message: S.of(context).studentDeleted,
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
                          minimumSize: const Size(double.infinity, 50),
                          backgroundColor: AppColors.error.withOpacity(1),
                          padding: EdgeInsets.symmetric(vertical: 10),
                        ),
                        icon: Stack(
                          alignment: Alignment.center,
                          clipBehavior: Clip.none,
                          children: [
                            Opacity(
                              opacity: isLoading ? 0 : 1,
                              child: Text(
                                S.of(context).delete,
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
                            ? Icon(Icons.delete_outline, size: 17.sp)
                            : SizedBox(),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
