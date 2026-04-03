import 'package:admain_center_managment_app/core/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../config/theme/app_theme.dart';
import '../../../../../core/helper/helper.dart';
import '../../../../../sync_engine/domain/entities/student_entity.dart';

class StudentProfileScreen extends StatelessWidget {
  final StudentEntity student;
  const StudentProfileScreen({super.key, required this.student});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Scholar Pro',
          style: GoogleFonts.manrope(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppTheme.primary,
          ),
        ),
        actions: [
          IconButton(icon: const Icon(Icons.settings), onPressed: () {}),
          const SizedBox(width: 8),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Hero Profile Header
            Stack(
              alignment: AlignmentGeometry.topRight,
              clipBehavior: Clip.none,
              children: [
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: AppTheme.surfaceContainerLowest,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Column(
                    children: [
                      const SizedBox(height: 50),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: AppTheme.surfaceContainerHigh,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Text(
                              '#2024-8842',
                              style: GoogleFonts.inter(
                                fontSize: 14,
                                color: AppTheme.onSurfaceVariant,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: AppTheme.primary,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Text(
                              'منتظم مالياً',
                              style: GoogleFonts.inter(
                                fontSize: 12,
                                color: AppTheme.onPrimary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
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
                ),
                Positioned(
                  top: -65,
                  right: -65,
                  child: Container(
                    height: 130,
                    width: 130,
                    decoration: BoxDecoration(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                Positioned(
                  top: 24,
                  right: 24,
                  child: Text(
                    'أحمد محمد عبد الرحمن',
                    style: GoogleFonts.manrope(
                      fontSize: 24,
                      fontWeight: FontWeight.w800,
                      color: AppTheme.onSurface,
                    ),
                  ),
                ),
              ],
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
                          (element) => element.entityId == student.studyLevelId,
                        )
                        .arabicName,
                  ),
                ),
                student.divisionEnum != null
                    ? const SizedBox(width: 12)
                    : SizedBox(),
                student.divisionEnum != null
                    ? Expanded(
                        child: _buildBentoCard(
                          icon: Icons.science,
                          iconColor: AppTheme.tertiary,
                          title: 'الشعبة',
                          value: student.divisionEnum!.description,
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
            student.phone != null
                ? Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: _buildContactRow(
                      context: context,

                      icon: Icons.smartphone,
                      title: 'هاتف الطالب',
                      value: student.phone!,
                      hasCallAction: true,
                    ),
                  )
                : SizedBox(),
            student.homePhone != null
                ? Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: _buildContactRow(
                      context: context,

                      icon: Icons.home,
                      title: 'هاتف البيت',
                      value: student.homePhone!,
                      hasCallAction: true,
                    ),
                  )
                : SizedBox(),
            student.parentPhone != null
                ? Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: _buildContactRow(
                      context: context,

                      icon: Icons.family_restroom,
                      title: 'هاتف ولي الأمر',
                      value: student.parentPhone!,
                      hasCallAction: true,
                    ),
                  )
                : SizedBox(),
            student.email != null
                ? Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: _buildContactRow(
                      context: context,
                      icon: Icons.mail,
                      title: 'البريد الإلكتروني',
                      value: student.email!,
                      hasCallAction: false,
                    ),
                  )
                : SizedBox(),
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
                          'اشتراك شهري',
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
                        Text(
                          'مهندس مدني',
                          style: GoogleFonts.manrope(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            // Notes
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
                    'أحمد طالب مجتهد ويشارك بفعالية في الحصص العملية. يحتاج فقط إلى التركيز أكثر على حل المسائل الحسابية في الكيمياء العضوية. ملتزم جداً بمواعيد الحضور والانصراف.',
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
        ),
      ),
    );
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
    required String value,
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
              Text(
                value,
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.bold,
                  color: AppTheme.onSurface,
                ),
              ),
            ],
          ),
          if (hasCallAction)
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
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
                        Icons.call,
                        size: 16,
                        color: AppTheme.primary,
                      ),
                    ),
                  ),
                  SizedBox(width: 12),
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
                ],
              ),
            ),
        ],
      ),
    );
  }
}
