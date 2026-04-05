import 'package:admain_center_managment_app/core/constants/constants.dart';
import 'package:admain_center_managment_app/core/enums/payment_type_enum.dart';
import 'package:admain_center_managment_app/core/enums/student_status_enum.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../config/theme/app_theme.dart';
import '../../../../../config/theme/colors.dart';
import '../../../../../sync_engine/domain/entities/student_entity.dart';
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        label: 'ملف الطالب',
        leadingWidget: MaterialButton(
          onPressed: () async {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    EditStudentScreen(studentEntity: widget.student),
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
            child: const Icon(Icons.edit, size: 20, color: AppTheme.primary),
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
                                  fontSize: 22,
                                  fontWeight: FontWeight.w800,
                                  color: AppTheme.onSurface,
                                ),
                                maxLines: 2,
                              ),
                            ),
                            SizedBox(width: 12),
                            Padding(
                              padding: const EdgeInsets.only(top: 5.0),
                              child: _buildStates(widget.student.studentStatus),
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
                                  const Icon(
                                    Icons.calendar_today,
                                    color: AppTheme.primary,
                                    size: 20,
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    'نسبة الحضور',
                                    style: GoogleFonts.manrope(
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
                                  fontSize: 18,
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
                    title: 'الصف',
                    value: studyLevels
                        .firstWhere(
                          (element) =>
                              element.entityId == widget.student.studyLevelId,
                        )
                        .arabicName,
                  ),
                ),
                widget.student.divisionEnum != null
                    ? const SizedBox(width: 12)
                    : SizedBox(),
                widget.student.divisionEnum != null
                    ? Expanded(
                        child: _buildBentoCard(
                          icon: Icons.science,
                          iconColor: AppTheme.tertiary,
                          title: 'الشعبة',
                          value: widget.student.divisionEnum!.description,
                        ),
                      )
                    : SizedBox(),
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
                    child: const Icon(
                      Icons.groups,
                      color: AppTheme.onSecondaryContainer,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'مواعيد الحصص',
                        style: GoogleFonts.inter(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: AppTheme.onSurfaceVariant,
                        ),
                      ),
                      Text(
                        'مجموعة A - السبت والأربعاء',
                        style: GoogleFonts.manrope(
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
            _buildSectionHeader('معلومات التواصل', AppTheme.primary),
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: _buildContactRow(
                context: context,

                icon: Icons.smartphone,
                title: 'هاتف الطالب',
                value: widget.student.phone,
                hasCallAction: true,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: _buildContactRow(
                context: context,

                icon: Icons.home,
                title: 'هاتف البيت',
                value: widget.student.homePhone,
                hasCallAction: true,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: _buildContactRow(
                context: context,

                icon: Icons.family_restroom,
                title: 'هاتف ولي الأمر',
                value: widget.student.parentPhone,
                hasCallAction: true,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: _buildContactRow(
                context: context,
                icon: Icons.mail,
                title: 'البريد الإلكتروني',
                value: widget.student.email,
                hasCallAction: false,
              ),
            ),
            const SizedBox(height: 24),
            // Admin Details
            _buildSectionHeader('تفاصيل إدارية', AppTheme.tertiary),
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
                          'نظام الدفع',
                          style: GoogleFonts.inter(
                            fontSize: 12,
                            color: AppTheme.onSurfaceVariant,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          widget.student.paymentTypeEnum?.description ??
                              PaymentTypeEnum.byMonth.description,
                          style: GoogleFonts.manrope(
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
                          'وظيفة ولي الأمر',
                          style: GoogleFonts.inter(
                            fontSize: 12,
                            color: AppTheme.onSurfaceVariant,
                          ),
                        ),
                        const SizedBox(height: 4),
                        widget.student.parentJob != null
                            ? Text(
                                widget.student.parentJob!,
                                style: GoogleFonts.inter(
                                  fontWeight: FontWeight.bold,
                                  color: AppTheme.onSurface,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              )
                            : Text(
                                "لا يوجد",
                                style: GoogleFonts.inter(
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
                        const Icon(Icons.edit_note, color: AppTheme.primary),
                        const SizedBox(width: 8),
                        Text(
                          'ملاحظات المعلم',
                          style: GoogleFonts.manrope(
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
                        fontSize: 14,
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
                          await Future.delayed(Duration(milliseconds: 400));
                        } finally {
                          if (mounted) {
                            setState(() => isLoading = false);
                          }
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 50),
                        backgroundColor: AppColors.error.withOpacity(1),
                      ),
                      icon: Stack(
                        alignment: Alignment.center,
                        clipBehavior: Clip.none,
                        children: [
                          Opacity(
                            opacity: isLoading ? 0 : 1,
                            child: Text(
                              'حذف الطالب',
                              style: TextStyle(fontSize: 14),
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
                          ? const Icon(Icons.delete_outline, size: 16)
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
                          MaterialPageRoute(
                            builder: (context) => EditStudentScreen(
                              studentEntity: widget.student,
                            ),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 50),
                        backgroundColor: AppColors.primaryDim,
                      ),
                      icon: Text(
                        "تعديل الطالب",
                        style: TextStyle(fontSize: 14),
                      ),
                      label: const Icon(Icons.edit, size: 16),
                    ),
                  ),
                ),
              ],
            ),
          ],
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
          StudentStatus.active.description,
          style: GoogleFonts.inter(
            fontSize: 12,
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
          StudentStatus.inactive.description,
          style: GoogleFonts.inter(
            fontSize: 12,
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
          StudentStatus.latePayment.description,
          style: GoogleFonts.inter(
            fontSize: 12,
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
          Icon(icon, color: iconColor, size: 24),
          const SizedBox(height: 8),
          Text(
            title,
            style: GoogleFonts.inter(
              fontSize: 12,
              color: AppTheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: GoogleFonts.manrope(
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
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: AppTheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }

  Widget _buildContactRow({
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
        children: [
          Icon(icon, color: AppTheme.onSurfaceVariant),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: GoogleFonts.inter(
                  fontSize: 10,
                  color: AppTheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 2),
              value != null
                  ? Text(
                      value,
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.bold,
                        color: AppTheme.onSurface,
                      ),
                    )
                  : Text(
                      "لا يوجد",
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.bold,
                        color: AppTheme.error,
                      ),
                    ),
            ],
          ),
          if (hasCallAction)
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  if (value != null)
                    MaterialButton(
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
                        child: const Icon(
                          Icons.phone,
                          size: 16,
                          color: AppTheme.primary,
                        ),
                      ),
                    ),
                  SizedBox(width: 12),

                  /*
                  MaterialButton(
                    onPressed: () async {
                      final result = await Helper.showPhoneDialog(
                        context,
                        value,
                        title,
                      );
                      print('fffffffffffffffff');
                      print(result);
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
                        color: AppTheme.primaryFixedDim.withOpacity(0.8),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.edit,
                        size: 16,
                        color: AppTheme.primary,
                      ),
                    ),
                  ),


                   */
                ],
              ),
            ),
          if (!hasCallAction)
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  if (value != null)
                    MaterialButton(
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
                        child: const Icon(
                          Icons.email,
                          size: 16,
                          color: AppTheme.primary,
                        ),
                      ),
                    ),
                  SizedBox(width: 12),
                  /*
                  MaterialButton(
                    onPressed: () async {
                      await Helper.showEmailDialog(context, value, title);
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
                        color: AppTheme.primaryFixedDim.withOpacity(0.8),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.edit,
                        size: 16,
                        color: AppTheme.primary,
                      ),
                    ),
                  ),
                  */
                ],
              ),
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
                hintText: 'اضاف ملاحظة جديده',
                hintStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
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
              child: const Icon(Icons.add, color: AppColors.onSurfaceVariant),
            ),
            const SizedBox(height: 12),
            Text(
              'إضافة ملاحظة جديده',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.onSurfaceVariant,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
