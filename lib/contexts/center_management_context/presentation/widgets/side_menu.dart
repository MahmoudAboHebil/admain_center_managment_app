import 'package:flutter/material.dart';

import '../../../../config/theme/colors.dart';
import '../../../../config/theme/typography.dart';
import '../screens/archive_screen.dart';
import '../screens/students_directory_screen.dart';

class SideMenu extends StatelessWidget {
  final int selectedIndex;

  const SideMenu({super.key, required this.selectedIndex});

  void _navigateToNext(BuildContext context, int index) {
    if (index == selectedIndex) return;

    Widget nextScreen;
    switch (index) {
      case 1:
        nextScreen = const StudentsDirectoryScreen();
        break;
      case 6:
        nextScreen = const ArchiveScreen();
        break;
      default:
        // By default, just go back to StudentsDirectoryScreen representing the dashboard, as we only implemented specific screens
        nextScreen = const StudentsDirectoryScreen();
        break;
    }

    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => nextScreen,
        transitionDuration: Duration.zero,
      ),
    );
  }

  Widget _buildNavItem(
    BuildContext context, {
    required int index,
    required IconData icon,
    required String label,
    VoidCallback? onTap,
  }) {
    final bool isSelected = selectedIndex == index;

    return Padding(
      padding: const EdgeInsets.only(bottom: 4.0),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap ?? () {},
          borderRadius: BorderRadius.circular(8),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: isSelected
                  ? AppColors.surfaceContainerLowest
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(8),
              boxShadow: isSelected
                  ? [
                      BoxShadow(
                        color: AppColors.onSurface.withOpacity(0.05),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ]
                  : null,
            ),
            child: Row(
              children: [
                Icon(
                  icon,
                  color: isSelected
                      ? AppColors.primary
                      : AppColors.onSurfaceVariant,
                  size: 24,
                ),
                const SizedBox(width: 12),
                Text(
                  label,
                  style: TextStyle(
                    color: isSelected
                        ? AppColors.primary
                        : AppColors.onSurfaceVariant,
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 256, // 64 rem = 256px
      height: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLow,
        border: const Border(
          left: BorderSide(
            color: Color(0x26AFB1BC), // outlineVariant/15%
          ),
        ),
      ),
      padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 8,
            ).copyWith(bottom: 40),
            child: Text(
              'سكولاستيك أتيليه',
              style: AppTypography.textTheme.titleLarge?.copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                _buildNavItem(
                  context,
                  index: 0,
                  icon: Icons.dashboard_outlined,
                  label: 'لوحة التحكم',
                  onTap: () => _navigateToNext(context, 0),
                ),
                _buildNavItem(
                  context,
                  index: 1,
                  icon: Icons.group_outlined,
                  label: 'الطلاب',
                  onTap: () => _navigateToNext(context, 1),
                ),
                _buildNavItem(
                  context,
                  index: 2,
                  icon: Icons.school_outlined,
                  label: 'الفصول',
                  onTap: () => _navigateToNext(context, 2),
                ),
                _buildNavItem(
                  context,
                  index: 3,
                  icon: Icons.how_to_reg_outlined,
                  label: 'الحضور',
                  onTap: () => _navigateToNext(context, 3),
                ),
                _buildNavItem(
                  context,
                  index: 4,
                  icon: Icons.payments_outlined,
                  label: 'المدفوعات',
                  onTap: () => _navigateToNext(context, 4),
                ),
                _buildNavItem(
                  context,
                  index: 5,
                  icon: Icons.calendar_today_outlined,
                  label: 'الجدول',
                  onTap: () => _navigateToNext(context, 5),
                ),
                _buildNavItem(
                  context,
                  index: 6,
                  icon: Icons.auto_delete_outlined,
                  label: 'الأرشيف',
                  onTap: () => _navigateToNext(context, 6),
                ),
              ],
            ),
          ),
          // User profile section
          Container(
            padding: const EdgeInsets.all(16),
            margin: const EdgeInsets.only(bottom: 16),
            decoration: BoxDecoration(
              color: AppColors.surfaceContainerLowest.withOpacity(0.5),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: AppColors.outlineVariant.withOpacity(0.1),
              ),
            ),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: AppColors.primaryContainer,
                  radius: 20,
                  child: Text(
                    'ع',
                    style: TextStyle(
                      color: AppColors.onPrimaryContainer,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'السيد علي',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      'مدير النظام',
                      style: TextStyle(
                        color: AppColors.onSurfaceVariant,
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          _buildNavItem(
            context,
            index: 98,
            icon: Icons.settings_outlined,
            label: 'الإعدادات',
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 4.0),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {},
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  child: const Row(
                    children: [
                      Icon(Icons.logout, color: AppColors.error, size: 24),
                      SizedBox(width: 12),
                      Text(
                        'تسجيل الخروج',
                        style: TextStyle(
                          color: AppColors.error,
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                        ),
                      ),
                    ],
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
