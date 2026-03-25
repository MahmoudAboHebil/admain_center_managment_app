import 'package:flutter/material.dart';

import '../../../../config/theme/colors.dart';
import '../../../../config/theme/typography.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/side_menu.dart';

class EditStudentScreen extends StatefulWidget {
  const EditStudentScreen({super.key});

  @override
  State<EditStudentScreen> createState() => _EditStudentScreenState();
}

class _EditStudentScreenState extends State<EditStudentScreen> {
  String _selectedGender = 'ذكر';
  String _paymentSystem = 'monthly';

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final bool isDesktop = width > 900;

    return Scaffold(
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (isDesktop) const SideMenu(selectedIndex: 1),
          Expanded(
            child: Column(
              children: [
                Container(
                  height: 80,
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  decoration: BoxDecoration(
                    color: AppColors.surface.withOpacity(0.8),
                    border: Border(
                      bottom: BorderSide(
                        color: AppColors.outlineVariant.withOpacity(0.1),
                      ),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'الطلاب',
                        style: AppTypography.textTheme.titleLarge?.copyWith(
                          color: AppColors.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 250,
                            child: TextField(
                              decoration: InputDecoration(
                                hintText: 'البحث بالاسم...',
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
                ),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(32),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'تحديث المعلومات الأكاديمية والشخصية للطالب "أحمد محمد علي"',
                                  style: AppTypography.textTheme.bodyMedium
                                      ?.copyWith(
                                        color: AppColors.onSurfaceVariant,
                                      ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'تعديل بيانات الطالب',
                                  style: AppTypography.textTheme.headlineLarge,
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                CustomButton(
                                  label: 'إلغاء',
                                  type: ButtonType.tertiary,
                                  onPressed: () => Navigator.of(context).pop(),
                                ),
                                const SizedBox(width: 12),
                                CustomButton(
                                  label: 'حفظ التغييرات',
                                  icon: Icons.save,
                                  onPressed: () => Navigator.of(context).pop(),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 32),
                        LayoutBuilder(
                          builder: (context, constraints) {
                            final bool isLargeGrid = constraints.maxWidth > 900;
                            return Column(
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      flex: isLargeGrid ? 8 : 1,
                                      child: _buildBasicInfoSection(),
                                    ),
                                    if (isLargeGrid) const SizedBox(width: 24),
                                    if (isLargeGrid)
                                      Expanded(
                                        flex: 4,
                                        child: _buildAcademicSection(),
                                      ),
                                  ],
                                ),
                                if (!isLargeGrid) ...[
                                  const SizedBox(height: 24),
                                  _buildAcademicSection(),
                                ],
                                const SizedBox(height: 24),
                                _buildContactSection(),
                                const SizedBox(height: 24),
                                _buildPaymentAndNotesSection(),
                              ],
                            );
                          },
                        ),
                      ],
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

  Widget _buildSectionHeader(
    String title,
    IconData icon, {
    Color iconColor = AppColors.primary,
    Color bgColor = AppColors.primaryContainer,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24.0),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: bgColor.withOpacity(0.2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: iconColor, size: 20),
          ),
          const SizedBox(width: 12),
          Text(
            title,
            style: AppTypography.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBasicInfoSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionHeader('البيانات الأساسية', Icons.person_outline),
            Row(
              children: [
                Expanded(
                  child: const CustomTextField(
                    label: 'اسم الطالب الكامل',
                    initialValue: 'أحمد محمد علي',
                  ),
                ),
                const SizedBox(width: 24),
                // ReadOnly ID field
                Expanded(
                  child: const CustomTextField(
                    label: 'كود الطالب (للقراءة فقط)',
                    initialValue: 'SP-2024-0892',
                    readOnly: true,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0, right: 4.0),
                        child: Text(
                          'الجنس',
                          style: AppTypography.textTheme.labelMedium?.copyWith(
                            color: AppColors.onSurfaceVariant,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: AppColors.surfaceContainerLow,
                          border: Border.all(
                            color: AppColors.outlineVariant.withOpacity(0.1),
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            _buildGenderOption('ذكر'),
                            const SizedBox(width: 4),
                            _buildGenderOption('أنثى'),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 24),
                Expanded(
                  child: const CustomTextField(
                    label: 'تاريخ الميلاد',
                    initialValue: '2008-05-14',
                    suffixIcon: Icon(Icons.calendar_today_outlined, size: 18),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const CustomTextField(
              label: 'الشعبة الدراسية',
              initialValue: 'علمي علوم',
              suffixIcon: Icon(Icons.expand_more, size: 20),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGenderOption(String label) {
    bool isSelected = _selectedGender == label;
    return InkWell(
      onTap: () => setState(() => _selectedGender = label),
      borderRadius: BorderRadius.circular(6),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.surfaceContainerLowest
              : Colors.transparent,
          borderRadius: BorderRadius.circular(6),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: AppColors.onSurface.withOpacity(0.05),
                    blurRadius: 2,
                    offset: const Offset(0, 1),
                  ),
                ]
              : [],
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? AppColors.primary : AppColors.onSurfaceVariant,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }

  Widget _buildAcademicSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionHeader(
              'المسار الأكاديمي',
              Icons.school_outlined,
              iconColor: AppColors.tertiary,
              bgColor: AppColors.tertiary,
            ),
            const CustomTextField(
              label: 'الصف الدراسي',
              initialValue: 'الثالث الثانوي',
              suffixIcon: Icon(Icons.expand_more, size: 20),
            ),
            const SizedBox(height: 20),
            const CustomTextField(
              label: 'المجموعة الدراسية',
              initialValue: 'مجموعة (ب) - الأحد/الأربعاء',
              suffixIcon: Icon(Icons.expand_more, size: 20),
            ),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.tertiary.withOpacity(0.05),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: AppColors.tertiary.withOpacity(0.1)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'تنبيه النظام',
                    style: TextStyle(
                      color: AppColors.tertiary,
                      fontWeight: FontWeight.bold,
                      fontSize: 11,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'تغيير المجموعة قد يؤثر على سجل الحضور والانصراف المرتبط بالطالب للفترة الحالية.',
                    style: TextStyle(
                      color: AppColors.onSurfaceVariant,
                      fontSize: 11,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContactSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionHeader('بيانات التواصل', Icons.contact_phone_outlined),
            Row(
              children: [
                Expanded(
                  child: const CustomTextField(
                    label: 'هاتف الطالب',
                    initialValue: '01012345678',
                    suffixIcon: Icon(Icons.smartphone, size: 18),
                    keyboardType: TextInputType.phone,
                  ),
                ),
                const SizedBox(width: 24),
                Expanded(
                  child: const CustomTextField(
                    label: 'هاتف ولي الأمر',
                    initialValue: '01298765432',
                    suffixIcon: Icon(Icons.call, size: 18),
                    keyboardType: TextInputType.phone,
                  ),
                ),
                const SizedBox(width: 24),
                Expanded(
                  child: const CustomTextField(
                    label: 'البريد الإلكتروني',
                    initialValue: 'ahmed.m@example.com',
                    suffixIcon: Icon(Icons.mail_outline, size: 18),
                    keyboardType: TextInputType.emailAddress,
                    textDirection: TextDirection.ltr,
                  ),
                ),
                const SizedBox(width: 24),
                Expanded(
                  child: const CustomTextField(
                    label: 'وظيفة ولي الأمر',
                    initialValue: 'مهندس اتصالات',
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentAndNotesSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionHeader(
              'نظام الدفع والملاحظات',
              Icons.payments_outlined,
              iconColor: AppColors.secondary,
              bgColor: AppColors.surfaceContainerLow,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 4,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0, right: 4.0),
                        child: Text(
                          'نظام الدفع المعتمد',
                          style: AppTypography.textTheme.labelMedium?.copyWith(
                            color: AppColors.onSurfaceVariant,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      _buildPaymentOption('monthly', 'اشتراك شهري'),
                      const SizedBox(height: 12),
                      _buildPaymentOption('per_lesson', 'بالحصة (دفع فردي)'),
                      const SizedBox(height: 16),
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: AppColors.surface,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: AppColors.outlineVariant.withOpacity(0.3),
                            style: BorderStyle.solid,
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'رصيد الطالب الحالي',
                                  style: TextStyle(
                                    color: AppColors.onSurfaceVariant,
                                    fontSize: 11,
                                  ),
                                ),
                                Text(
                                  '450 ج.م',
                                  style: TextStyle(
                                    color: AppColors.primary,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 11,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(4),
                              child: LinearProgressIndicator(
                                value: 0.75,
                                backgroundColor: AppColors.surfaceContainer,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  AppColors.primary,
                                ),
                                minHeight: 6,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 32),
                Expanded(
                  flex: 8,
                  child: const CustomTextField(
                    label: 'ملاحظات إضافية',
                    placeholder:
                        'أضف أي ملاحظات تتعلق بمستوى الطالب، ظروف خاصة، أو تنبيهات للإدارة...',
                    maxLines: 6,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentOption(String value, String label) {
    bool isSelected = _paymentSystem == value;
    return InkWell(
      onTap: () => setState(() => _paymentSystem = value),
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.surfaceContainerLow
              : AppColors.surfaceContainerLowest,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected
                ? AppColors.primary.withOpacity(0.2)
                : AppColors.outlineVariant.withOpacity(0.1),
          ),
        ),
        child: Row(
          children: [
            Radio<String>(
              value: value,
              groupValue: _paymentSystem,
              onChanged: (val) => setState(() => _paymentSystem = val!),
              activeColor: AppColors.primary,
            ),
            Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}
