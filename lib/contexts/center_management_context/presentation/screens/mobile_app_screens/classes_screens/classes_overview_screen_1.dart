import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../config/theme/app_text_style.dart';
import '../../../../../../config/theme/app_theme.dart';
import '../../../../../../generated/l10n.dart';
import '../../../bloc/selection_cubit/selection_cubit.dart';
import '../../../widgets/overview_screen_appBar.dart';
import '../student_screens/students_overview_screen.dart';

class ClassesOverviewScreen1 extends ConsumerStatefulWidget {
  const ClassesOverviewScreen1({super.key});

  @override
  ConsumerState<ClassesOverviewScreen1> createState() =>
      _ClassesOverviewScreenState();
}

class _ClassesOverviewScreenState
    extends ConsumerState<ClassesOverviewScreen1> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppTheme.surface,
        resizeToAvoidBottomInset: false,
        appBar: OverviewScreenAppBar(label: S.of(context).classes),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Section Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'نظرة عامة',
                        style: TextStyle(
                          fontFamily: AppTextStyles.bodyFont,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: AppTheme.onSurfaceVariant,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'إدارة الفصول',
                        style: TextStyle(
                          fontFamily: AppTextStyles.headlineFont,
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.onSurface,
                        ),
                      ),
                    ],
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.primary,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.all(12),
                      minimumSize: Size.zero,
                      elevation: 4,
                      shadowColor: AppTheme.primary.withOpacity(0.3),
                    ),
                    child: const Icon(Icons.add, size: 24),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Class Cards List
              _buildClassCard(
                title: 'اللغة العربية - المستوى المتقدم',
                teacher: 'أ. أحمد المنصور',
                studentsCount: '24 طالب',
                lastUpdate: 'منذ ساعتين',
                icon: Icons.school,
                iconColor: AppTheme.primary,
                iconBgColor: AppTheme.primaryContainer.withOpacity(0.4),
                progress: 0.85,
                progressColor: AppTheme.primary,
              ),
              const SizedBox(height: 24),
              _buildClassCard(
                title: 'الرياضيات والفيزياء',
                teacher: 'د. سارة خالد',
                studentsCount: '18 طالب',
                lastUpdate: 'أمس',
                icon: Icons.functions,
                iconColor: AppTheme.tertiary,
                iconBgColor: AppTheme.tertiaryContainer.withOpacity(0.4),
                progress: 0.60,
                progressColor: AppTheme.tertiary,
              ),
              const SizedBox(height: 24),
              _buildClassCard(
                title: 'التاريخ الإسلامي',
                teacher: 'أ. مريم يوسف',
                studentsCount: '32 طالب',
                lastUpdate: 'منذ 3 أيام',
                icon: Icons.history_edu,
                iconColor: AppTheme.onSecondaryContainer,
                iconBgColor: AppTheme.secondaryContainer.withOpacity(0.6),
                progress: 0.40,
                progressColor: AppTheme.secondary,
              ),
              const SizedBox(height: 32),

              // Empty State Suggestion
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: AppTheme.outlineVariant.withOpacity(0.3),
                    width: 2,
                    strokeAlign: BorderSide.strokeAlignInside,
                  ),
                ),
                child: Column(
                  children: [
                    Icon(
                      Icons.add_to_photos_outlined,
                      size: 40,
                      color: AppTheme.outlineVariant.withOpacity(0.6),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'هل ترغب في تنظيم فصل جديد؟',
                      style: TextStyle(
                        fontFamily: AppTextStyles.headlineFont,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.onSurfaceVariant,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'قم بإضافة فصولك الدراسية وتعيين المعلمين والطلاب بسهولة',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: AppTextStyles.bodyFont,
                        fontSize: 14,
                        color: AppTheme.onSurfaceVariant.withOpacity(0.7),
                      ),
                    ),
                    const SizedBox(height: 16),
                    OutlinedButton(
                      onPressed: () {},
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppTheme.primary,
                        side: BorderSide(
                          color: AppTheme.primary.withOpacity(0.2),
                          width: 2,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 8,
                        ),
                      ),
                      child: Text(
                        'إضافة فصل الآن',
                        style: TextStyle(
                          fontFamily: AppTextStyles.bodyFont,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 100),
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          onTap: (index) async {
            context.read<SelectionCubit>().clearSelection();
            if (index == 0) {
              /* Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ClassesOverviewScreen(),
                            ),
                          );*/
            } else if (index == 1) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => StudentsOverviewScreen(),
                ),
              );
            } else if (index == 2) {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => ClassesOverviewScreen(),
              //   ),
              // );
            }
          },
          currentIndex: 1, // "الطلاب" active
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.dashboard_outlined, size: 24.sp),
              activeIcon: Icon(Icons.dashboard, size: 24.sp),
              label: S.of(context).dashboard,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.group_outlined, size: 24.sp),
              activeIcon: Icon(Icons.group, size: 24.sp),
              label: S.of(context).theStudents,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.class_outlined, size: 24.sp),
              activeIcon: Icon(Icons.class_, size: 24.sp),
              label: S.of(context).classes,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildClassCard({
    required String title,
    required String teacher,
    required String studentsCount,
    required String lastUpdate,
    required IconData icon,
    required Color iconColor,
    required Color iconBgColor,
    required double progress,
    required Color progressColor,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.surfaceContainer,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: iconBgColor,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(icon, color: iconColor),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: AppTheme.surfaceContainerLowest,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 2,
                            offset: const Offset(0, 1),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.group,
                            size: 14,
                            color: AppTheme.tertiary,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            studentsCount,
                            style: TextStyle(
                              fontFamily: AppTextStyles.bodyFont,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: AppTheme.onSurface,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Text(
                  title,
                  style: TextStyle(
                    fontFamily: AppTextStyles.headlineFont,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.onSurface,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(
                      Icons.person,
                      size: 18,
                      color: AppTheme.onSurfaceVariant,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      teacher,
                      style: TextStyle(
                        fontFamily: AppTextStyles.bodyFont,
                        fontSize: 14,
                        color: AppTheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Stack(
                  children: [
                    Container(
                      height: 6,
                      decoration: BoxDecoration(
                        color: AppTheme.surfaceContainerHighest,
                        borderRadius: BorderRadius.circular(3),
                      ),
                    ),
                    FractionallySizedBox(
                      widthFactor: progress,
                      child: Container(
                        height: 6,
                        decoration: BoxDecoration(
                          color: progressColor,
                          borderRadius: BorderRadius.circular(3),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            decoration: BoxDecoration(
              color: AppTheme.surfaceContainerHigh,
              borderRadius: const BorderRadius.vertical(
                bottom: Radius.circular(16),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'آخر تحديث: $lastUpdate',
                  style: TextStyle(
                    fontFamily: AppTextStyles.bodyFont,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: AppTheme.onSurfaceVariant,
                  ),
                ),
                const Icon(
                  Icons.chevron_left,
                  color: AppTheme.primary,
                  size: 20,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNav() {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.surfaceContainerLowest,
        boxShadow: [
          BoxShadow(
            color: AppTheme.onSurface.withOpacity(0.06),
            blurRadius: 32,
            offset: const Offset(0, -4),
          ),
        ],
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        border: Border(
          top: BorderSide(color: AppTheme.outlineVariant.withOpacity(0.15)),
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem('dashboard', 'الرئيسية', false),
              _buildNavItem('calendar_month', 'الجدول', false),
              _buildNavItem('how_to_reg', 'الحضور', false),
              _buildNavItem('school', 'الفصول', true),
              _buildNavItem('payments', 'المدفوعات', false),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(String iconName, String label, bool isActive) {
    IconData getIcon(String name) {
      switch (name) {
        case 'dashboard':
          return Icons.dashboard_outlined;
        case 'calendar_month':
          return Icons.calendar_month_outlined;
        case 'how_to_reg':
          return Icons.how_to_reg_outlined;
        case 'school':
          return Icons.school;
        case 'payments':
          return Icons.payments_outlined;
        default:
          return Icons.circle;
      }
    }

    return Container(
      padding: isActive
          ? const EdgeInsets.symmetric(horizontal: 16, vertical: 8)
          : const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      decoration: BoxDecoration(
        color: isActive ? AppTheme.secondaryFixed : Colors.transparent,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            getIcon(iconName),
            color: isActive ? AppTheme.primary : AppTheme.onSurfaceVariant,
            size: 24,
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontFamily: AppTextStyles.bodyFont,
              fontSize: 10,
              fontWeight: isActive ? FontWeight.bold : FontWeight.w500,
              color: isActive ? AppTheme.primary : AppTheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}
