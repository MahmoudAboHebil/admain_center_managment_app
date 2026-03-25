import 'package:flutter/material.dart';

import '../../../../config/theme/colors.dart';
import '../../../../config/theme/typography.dart';
import '../widgets/custom_button.dart';
import '../widgets/side_menu.dart';

class ArchiveScreen extends StatelessWidget {
  const ArchiveScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final bool isDesktop = width > 900;

    return Scaffold(
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (isDesktop) const SideMenu(selectedIndex: 6), // 6: Archive
          Expanded(
            child: Column(
              children: [
                _buildTopAppBar(isDesktop),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(32),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildPageHeader(),
                        const SizedBox(height: 40),
                        _buildStatsRow(),
                        const SizedBox(height: 40),
                        _buildArchiveTable(),
                        const SizedBox(height: 32),
                        _buildCautionNotice(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.onPrimary,
        child: const Icon(Icons.cloud_download),
      ),
    );
  }

  Widget _buildTopAppBar(bool isDesktop) {
    return Container(
      height: 80,
      padding: const EdgeInsets.symmetric(horizontal: 32),
      decoration: BoxDecoration(
        color: AppColors.surface.withOpacity(0.8),
        border: Border(
          bottom: BorderSide(color: AppColors.outlineVariant.withOpacity(0.1)),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              if (!isDesktop) ...[
                const Icon(Icons.menu),
                const SizedBox(width: 16),
              ],
              Text(
                'أرشيف الطلاب المحذوفين',
                style: AppTypography.textTheme.titleLarge?.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Row(
            children: [
              SizedBox(
                width: 250,
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'البحث في الأرشيف...',
                    prefixIcon: const Icon(
                      Icons.search,
                      size: 20,
                      color: AppColors.onSurfaceVariant,
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 0,
                      horizontal: 16,
                    ),
                    fillColor: AppColors.surfaceContainerHigh,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Container(
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.surfaceContainerLow,
                ),
                child: IconButton(
                  icon: const Icon(
                    Icons.notifications_outlined,
                    color: AppColors.onSurfaceVariant,
                  ),
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPageHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    'الرئيسية',
                    style: AppTypography.textTheme.bodyMedium?.copyWith(
                      color: AppColors.onSurfaceVariant,
                    ),
                  ),
                  const Icon(
                    Icons.chevron_left,
                    size: 16,
                    color: AppColors.onSurfaceVariant,
                  ),
                  Text(
                    'أرشيف الطلاب المحذوفين',
                    style: AppTypography.textTheme.bodyMedium?.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                'إدارة الأرشيف',
                style: AppTypography.textTheme.displaySmall?.copyWith(
                  color: AppColors.onSurface,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'إدارة سجلات الطلاب الذين تم حذفهم مؤخراً. يمكنك استعادة أي طالب إلى قاعدة البيانات النشطة خلال 30 يوماً من تاريخ الحذف.',
                style: TextStyle(
                  color: AppColors.onSurfaceVariant,
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 24),
        Row(
          children: [
            CustomButton(
              label: 'تصفية النتائج',
              type: ButtonType.secondary,
              icon: Icons.filter_list,
              onPressed: () {},
            ),
            const SizedBox(width: 12),
            ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.delete_forever),
              label: const Text(
                'حذف الكل نهائياً',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.error,
                foregroundColor: AppColors.onError,
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildStatsRow() {
    return Row(
      children: [
        Expanded(
          child: _buildStatCard('إجمالي المحذوفين', '124', AppColors.primary),
        ),
        const SizedBox(width: 24),
        Expanded(
          child: _buildStatCard('محذوف هذا الأسبوع', '12', AppColors.tertiary),
        ),
        const SizedBox(width: 24),
        Expanded(
          child: _buildStatCard(
            'تم استعادتهم مؤخراً',
            '45',
            AppColors.onSurface,
          ),
        ),
        const SizedBox(width: 24),
        Expanded(
          child: Container(
            height: 110,
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: AppColors.error.withOpacity(0.05),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.error.withOpacity(0.2)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'سجلات تنتهي صلاحيتها',
                  style: TextStyle(
                    color: AppColors.error,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  '8',
                  style: AppTypography.textTheme.headlineLarge?.copyWith(
                    color: AppColors.error,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStatCard(String label, String value, Color valueColor) {
    return Container(
      height: 110,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.outlineVariant.withOpacity(0.15)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            label,
            style: const TextStyle(
              color: AppColors.onSurfaceVariant,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: AppTypography.textTheme.headlineLarge?.copyWith(
              color: valueColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildArchiveTable() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.outlineVariant.withOpacity(0.15)),
      ),
      child: Column(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              headingRowColor: MaterialStateProperty.all(
                AppColors.surfaceContainerLow,
              ),
              dataRowMaxHeight: 80,
              dataRowMinHeight: 80,
              dividerThickness: 0.5,
              columns: const [
                DataColumn(
                  label: Text(
                    'اسم الطالب',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColors.onSurfaceVariant,
                    ),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'الفصل الدراسي',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColors.onSurfaceVariant,
                    ),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'تاريخ الحذف',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColors.onSurfaceVariant,
                    ),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'سبب الحذف',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColors.onSurfaceVariant,
                    ),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'الإجراءات',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColors.onSurfaceVariant,
                    ),
                  ),
                ),
              ],
              rows: [
                _buildTableRow(
                  initials: 'أ م',
                  name: 'أحمد محمود الياسين',
                  id: '1098234',
                  grade: 'الصف الأول الثانوي',
                  date: '14 أكتوبر 2023',
                  remaining: 'باقي 12 يوماً',
                  reason: 'نقل إلى مدرسة أخرى (خارج المحافظة)',
                  isUrgent: true,
                ),
                _buildTableRow(
                  initials: 'س ع',
                  name: 'سارة علي غانم',
                  id: '1129845',
                  grade: 'الصف الثالث الإعدادي',
                  date: '08 أكتوبر 2023',
                  remaining: 'باقي 6 أيام',
                  reason: 'تخرج مبكر / ظروف عائلية',
                  isUrgent: true,
                  avatarColor: AppColors.tertiaryContainer,
                  textColor: AppColors.tertiary,
                ),
                _buildTableRow(
                  initials: 'ي ب',
                  name: 'ياسين بدر القحطاني',
                  id: '1055672',
                  grade: 'الصف الثاني الثانوي',
                  date: '29 سبتمبر 2023',
                  remaining: 'أرشفة نهائية قريباً',
                  reason: 'سقوط قيد تلقائي (عدم حضور)',
                  isUrgent: false,
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            decoration: BoxDecoration(
              color: AppColors.surfaceContainerLow,
              border: Border(
                top: BorderSide(
                  color: AppColors.outlineVariant.withOpacity(0.15),
                ),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'عرض سجلات 1 إلى 3 من أصل 124 سجلاً محذوفاً',
                  style: TextStyle(
                    color: AppColors.onSurfaceVariant,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.chevron_right, size: 20),
                      onPressed: null,
                    ),
                    Container(
                      width: 32,
                      height: 32,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: const Text(
                        '1',
                        style: TextStyle(
                          color: AppColors.onPrimary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(width: 4),
                    Container(
                      width: 32,
                      height: 32,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: const Text(
                        '2',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(width: 4),
                    Container(
                      width: 32,
                      height: 32,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: const Text(
                        '3',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(width: 4),
                    IconButton(
                      icon: const Icon(Icons.chevron_left, size: 20),
                      onPressed: () {},
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  DataRow _buildTableRow({
    required String initials,
    required String name,
    required String id,
    required String grade,
    required String date,
    required String remaining,
    required String reason,
    required bool isUrgent,
    Color avatarColor = AppColors.primaryContainer,
    Color textColor = AppColors.primary,
  }) {
    return DataRow(
      cells: [
        DataCell(
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: avatarColor.withOpacity(0.5),
                  shape: BoxShape.circle,
                ),
                child: Text(
                  initials,
                  style: TextStyle(
                    color: textColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'رقم الهوية: $id',
                    style: const TextStyle(
                      color: AppColors.onSurfaceVariant,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        DataCell(
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              color: AppColors.secondaryContainer,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Text(
              grade,
              style: const TextStyle(
                color: AppColors.onSecondaryContainer,
                fontSize: 11,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        DataCell(
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                date,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                ),
              ),
              Text(
                remaining,
                style: TextStyle(
                  color: isUrgent
                      ? AppColors.error
                      : AppColors.onSurfaceVariant,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        DataCell(
          SizedBox(
            width: 150,
            child: Text(
              reason,
              style: const TextStyle(
                color: AppColors.onSurfaceVariant,
                fontSize: 12,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        DataCell(
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.settings_backup_restore, size: 16),
                label: const Text('استعادة', style: TextStyle(fontSize: 12)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: AppColors.onPrimary,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 0,
                  ),
                  minimumSize: const Size(0, 32),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              IconButton(
                icon: const Icon(
                  Icons.delete_outline,
                  color: AppColors.onSurfaceVariant,
                ),
                onPressed: () {},
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCautionNotice() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.error.withOpacity(0.05),
        border: Border.all(color: AppColors.error.withOpacity(0.15)),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.report_problem_outlined,
            color: AppColors.error,
            size: 24,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'سياسة الاحتفاظ بالبيانات',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                ),
                const SizedBox(height: 8),
                Text(
                  'يتم الاحتفاظ ببيانات الطلاب المحذوفين لمدة 30 يوماً فقط من تاريخ الحذف. بعد هذه المدة، سيتم مسح جميع السجلات والملفات الأكاديمية والدرجات المرتبطة بالطالب نهائياً ولا يمكن استعادتها بعد ذلك بأي وسيلة.',
                  style: TextStyle(
                    color: AppColors.onSurfaceVariant,
                    fontSize: 12,
                    height: 1.5,
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
