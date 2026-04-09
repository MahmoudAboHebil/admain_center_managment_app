import 'package:admain_center_managment_app/contexts/center_management_context/presentation/screens/mobile_app_screens/students_list_screen.dart';
import 'package:admain_center_managment_app/core/constants/constants.dart';
import 'package:admain_center_managment_app/core/enums/payment_type_enum.dart';
import 'package:admain_center_managment_app/core/enums/student_status_enum.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../config/theme/app_theme.dart';
import '../../../../../config/theme/colors.dart';
import '../../../../../core/enums/division_enum.dart';
import '../../../../../generated/l10n.dart';
import '../../../../../injection_container.dart';
import '../../../../../sync_engine/domain/entities/student_entity.dart';
import '../../../domain/entities/study_level_entity.dart';
import '../../../domain/repository/student_repository.dart';
import '../../widgets/custom_app_bar.dart';
import 'edit_student_screen.dart';

class StudentProfileScreen extends StatefulWidget {
  final StudentEntity student;
  const StudentProfileScreen({super.key, required this.student});

  @override
  State<StudentProfileScreen> createState() => _StudentProfileScreenState();
}

class _StudentProfileScreenState extends State<StudentProfileScreen> {
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
                    Positioned(
                      top: -90,
                      right: -90,
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
                                child: _buildStates(
                                  widget.student.studentStatus,
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
                    child: _buildBentoCard(
                      icon: Icons.layers,
                      iconColor: AppTheme.tertiary,
                      title: S.of(context).className,
                      value: level.order == 0
                          ? S.of(context).notAdded
                          : level.arabicName,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildBentoCard(
                      icon: Icons.science,
                      iconColor: AppTheme.tertiary,
                      title: S.of(context).division,
                      value:
                          (widget.student.divisionEnum == null ||
                              widget.student.divisionEnum ==
                                  DivisionEnum.Division)
                          ? S.of(context).notAdded
                          : widget.student.divisionEnum!.arabic,
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
              _buildSectionHeader(S.of(context).contactInfo, AppTheme.primary),
              const SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: _buildContactRow(
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
                child: _buildContactRow(
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
                child: _buildContactRow(
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
                child: _buildContactRow(
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
              _buildSectionHeader(
                S.of(context).administrativeDetails,
                AppTheme.tertiary,
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
                          Text(
                            widget.student.paymentTypeEnum?.arabic ??
                                PaymentTypeEnum.byMonth.arabic,
                            style: GoogleFonts.manrope(
                              fontSize: 13.sp,
                              fontWeight: FontWeight.bold,
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
                                      message:
                                      S.of(context).tryAgainLater,
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
                                S.of(context).deleteStudent,
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
                  SizedBox(width: 12),
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
                          style: TextStyle(fontSize: 13.sp),
                        ),
                        label: Icon(Icons.edit, size: 17.sp),
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

  // Widget _buildTeacherNote(List<String>? notes){
  Widget _buildStates(StudentStatus status) {
    if (status == StudentStatus.active) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        decoration: BoxDecoration(
          color: AppTheme.primary,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Text(
          StudentStatus.active.arabic,
          style: GoogleFonts.inter(
            fontSize: 11.sp,
            color: AppTheme.onPrimary,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
    } else if (status == StudentStatus.inactive) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        decoration: BoxDecoration(
          color: Color(0xFFF3F3FA),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Text(
          StudentStatus.inactive.arabic,
          style: GoogleFonts.inter(
            fontSize: 11.sp,
            color: const Color(0xFF5C5F68),
            fontWeight: FontWeight.bold,
          ),
        ),
      );
    } else {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        decoration: BoxDecoration(
          color: Colors.red.shade100,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Text(
          StudentStatus.latePayment.arabic,
          style: GoogleFonts.inter(
            fontSize: 11.sp,
            color: Colors.red.shade800,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
    }
  }

  Widget _buildBentoCard({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String value,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: iconColor, size: 24.sp),
          const SizedBox(height: 8),
          Text(
            title,
            style: GoogleFonts.inter(
              fontSize: 11.sp,
              color: AppTheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: GoogleFonts.manrope(
              fontSize: 13.sp,
              fontWeight: FontWeight.bold,
              color: AppTheme.onSurface,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title, Color barColor) {
    return Row(
      children: [
        Container(
          width: 6,
          height: 16,
          decoration: BoxDecoration(
            color: barColor,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        const SizedBox(width: 8),
        Text(
          title,
          style: GoogleFonts.manrope(
            fontSize: 13.sp,
            fontWeight: FontWeight.bold,
            color: AppTheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }

  Widget _buildContactRow({
    required double screenWidth,
    required BuildContext context,
    required IconData icon,
    required String title,
    required String? value,
    required bool hasCallAction,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTheme.outlineVariant.withOpacity(0.15)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(icon, color: AppTheme.onSurfaceVariant, size: 24.sp),
          const SizedBox(width: 12),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: GoogleFonts.inter(
                  fontSize: 11.sp,
                  color: AppTheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 2),
              value != null
                  ? Container(
                      width: screenWidth * 0.55,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Text(
                          value,
                          style: GoogleFonts.inter(
                            fontSize: 13.sp,
                            fontWeight: FontWeight.bold,
                            color: AppTheme.onSurface,
                          ),
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
                    ),
            ],
          ),
          Spacer(),
          if (hasCallAction)
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                if (value != null)
                  MaterialButton(
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,

                    onPressed: () {},
                    elevation: 0,
                    hoverElevation: 0,
                    disabledElevation: 0,
                    highlightElevation: 0,
                    focusElevation: 0,
                    padding: EdgeInsets.zero,
                    shape: CircleBorder(),
                    minWidth: 32,
                    child: Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        color: AppTheme.primary.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.phone,
                        size: 16.sp,
                        color: AppTheme.primary,
                      ),
                    ),
                  ),
              ],
            ),
          if (!hasCallAction)
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                if (value != null)
                  MaterialButton(
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,

                    onPressed: () {},
                    elevation: 0,
                    hoverElevation: 0,
                    disabledElevation: 0,
                    highlightElevation: 0,
                    focusElevation: 0,
                    padding: EdgeInsets.zero,
                    shape: CircleBorder(),
                    minWidth: 32,
                    child: Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        color: AppTheme.primary.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.email,
                        size: 16.sp,
                        color: AppTheme.primary,
                      ),
                    ),
                  ),
              ],
            ),
        ],
      ),
    );
  }
}

class TeacherNote extends StatefulWidget {
  final String? initialValue;
  const TeacherNote({super.key, this.initialValue});

  @override
  State<TeacherNote> createState() => _TeacherNoteState();
}

class _TeacherNoteState extends State<TeacherNote> {
  late final TextEditingController _controller;
  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialValue);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppTheme.surfaceContainer,
        borderRadius: BorderRadius.circular(16),
        border: const Border(
          right: BorderSide(color: AppTheme.primary, width: 4),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              keyboardType: TextInputType.multiline,
              maxLines: null,
              scrollPhysics: NeverScrollableScrollPhysics(),
              decoration: InputDecoration(
                enabled: false,
                hintText: S.of(context).addNewStudent,
                hintStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13.sp,
                  color: AppTheme.onSurfaceVariant,
                ),
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                focusedErrorBorder: InputBorder.none,
                filled: false,
                fillColor: Colors.transparent,
              ),
              style: GoogleFonts.inter(
                fontSize: 14,
                color: AppTheme.onSurfaceVariant,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AddNote extends StatelessWidget {
  const AddNote({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        height: 120,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: AppColors.surfaceContainerLow.withOpacity(0.5),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: AppColors.outlineVariant.withOpacity(0.3),
            style: BorderStyle.solid,
          ), // In Flutter dashed border requires custom paint, using solid for now.
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: const BoxDecoration(
                color: AppColors.surfaceContainerLowest,
                shape: BoxShape.circle,
                boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
              ),
              child: Icon(
                Icons.add,
                color: AppColors.onSurfaceVariant,
                size: 24.sp,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              S.of(context).addNewStudent,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.onSurfaceVariant,
                fontWeight: FontWeight.bold,
                fontSize: 11.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
