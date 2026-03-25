import 'package:flutter/material.dart';

import '../../../../config/theme/colors.dart';
import '../../../../config/theme/typography.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/side_menu.dart';

class AddStudentScreen extends StatefulWidget {
  const AddStudentScreen({super.key});

  @override
  State<AddStudentScreen> createState() => _AddStudentScreenState();
}

class _AddStudentScreenState extends State<AddStudentScreen> {
  String _selectedGender = 'ذكر';

  @override
  Widget build(BuildContext context) {
    // Determine screen width to show/hide sidebar for responsive behavior (assuming desktop/tablet first)
    final double width = MediaQuery.of(context).size.width;
    final bool isDesktop = width > 900;

    return Scaffold(
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Sidebar (256 width)
          if (isDesktop) const SideMenu(selectedIndex: 1), // Students selected
          // Main Content
          Expanded(
            child: Column(
              children: [
                // Top App Bar Area
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
                      Row(
                        children: [
                          if (!isDesktop)
                            IconButton(
                              icon: const Icon(Icons.menu),
                              onPressed: () {
                                // Add drawer logic if needed
                              },
                            ),
                          Text(
                            'الطلاب',
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

                // Scrollable Form
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(32),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Page Header
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'إضافة طالب جديد',
                                  style: AppTypography.textTheme.headlineLarge,
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  'قم بتعبئة البيانات الأكاديمية والشخصية لتسجيل طالب جديد في النظام.',
                                  style: AppTypography.textTheme.bodyLarge
                                      ?.copyWith(
                                        color: AppColors.onSurfaceVariant,
                                        fontWeight: FontWeight.w500,
                                      ),
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
                                  label: 'إضافة طالب',
                                  icon: Icons.person_add,
                                  onPressed: () => Navigator.of(context).pop(),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 32),

                        // Form Grid
                        LayoutBuilder(
                          builder: (context, constraints) {
                            final bool isLargeGrid = constraints.maxWidth > 800;
                            return Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Left Column (Sections 1, 2, 3)
                                Expanded(
                                  flex: isLargeGrid ? 8 : 1,
                                  child: Column(
                                    children: [
                                      _buildBasicInfoSection(),
                                      const SizedBox(height: 24),
                                      _buildAcademicSection(),
                                      const SizedBox(height: 24),
                                      _buildNotesSection(),
                                    ],
                                  ),
                                ),
                                if (isLargeGrid) const SizedBox(width: 24),
                                // Right Column (Contact & Payment)
                                if (isLargeGrid)
                                  Expanded(
                                    flex: 4,
                                    child: Column(
                                      children: [
                                        _buildContactSection(),
                                        const SizedBox(height: 24),
                                        _buildPaymentSection(),
                                      ],
                                    ),
                                  ),
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
    Color iconColor = AppColors.primaryFixedDim,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24.0),
      child: Row(
        children: [
          Icon(icon, color: iconColor, size: 24),
          const SizedBox(width: 8),
          Text(
            title,
            style: AppTypography.textTheme.titleMedium?.copyWith(
              color: AppColors.primary,
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
                    placeholder: 'مثال: أحمد محمد علي',
                  ),
                ),
                const SizedBox(width: 24),
                Expanded(
                  child: const CustomTextField(
                    label: 'الرقم التعريفي (Student ID)',
                    placeholder: 'STU-2024-001',
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: const CustomTextField(
                    label: 'تاريخ الميلاد',
                    suffixIcon: Icon(Icons.calendar_today_outlined, size: 18),
                  ),
                ),
                const SizedBox(width: 24),
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
                          color: AppColors.surfaceContainerHigh,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            Expanded(child: _buildGenderOption('ذكر')),
                            const SizedBox(width: 8),
                            Expanded(child: _buildGenderOption('أنثى')),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGenderOption(String label) {
    bool isSelected = _selectedGender == label;
    return InkWell(
      onTap: () {
        setState(() {
          _selectedGender = label;
        });
      },
      borderRadius: BorderRadius.circular(6),
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(vertical: 8),
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
            color: isSelected ? AppColors.primary : AppColors.onSurface,
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
            _buildSectionHeader('المسار الأكاديمي', Icons.school_outlined),
            Row(
              children: [
                Expanded(
                  child: const CustomTextField(
                    label: 'السنة الدراسية',
                    initialValue: 'الصف الثالث الثانوي',
                  ),
                ),
                const SizedBox(width: 24),
                Expanded(
                  child: const CustomTextField(
                    label: 'التخصص الدراسي',
                    initialValue: 'علمي علوم',
                  ),
                ),
                const SizedBox(width: 24),
                Expanded(
                  child: const CustomTextField(
                    label: 'المجموعة',
                    initialValue: 'مجموعة السبت A',
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNotesSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionHeader('ملاحظات إضافية', Icons.edit_note_outlined),
            const CustomTextField(
              label: '',
              placeholder:
                  'أضف أي ملاحظات خاصة عن الحالة الصحية أو السلوك أو المستوى الدراسي للطالب...',
              maxLines: 4,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContactSection() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surfaceContainer,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.outlineVariant.withOpacity(0.15)),
      ),
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.contact_phone_outlined,
                color: AppColors.secondary,
                size: 24,
              ),
              const SizedBox(width: 8),
              Text(
                'معلومات التواصل',
                style: AppTypography.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          const CustomTextField(
            label: 'رقم هاتف الطالب',
            placeholder: '01xxxxxxxxx',
            keyboardType: TextInputType.phone,
          ),
          const SizedBox(height: 16),
          const CustomTextField(
            label: 'رقم هاتف ولي الأمر',
            placeholder: '01xxxxxxxxx',
            keyboardType: TextInputType.phone,
          ),
          const SizedBox(height: 16),
          const CustomTextField(
            label: 'البريد الإلكتروني',
            placeholder: 'student@example.com',
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(height: 16),
          const CustomTextField(
            label: 'وظيفة ولي الأمر',
            placeholder: 'مثال: مهندس برمجيات',
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentSection() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.primaryContainer.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.primaryContainer.withOpacity(0.3)),
      ),
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.payments_outlined,
                color: AppColors.primary,
                size: 24,
              ),
              const SizedBox(width: 8),
              Text(
                'نظام الدفع',
                style: AppTypography.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColors.onPrimaryContainer,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          // Monthly Sub (Selected)
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.surfaceContainerLowest,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: AppColors.primary, width: 2),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(Icons.calendar_month, color: AppColors.primary),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'اشتراك شهري',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          'يتم الدفع بداية كل شهر',
                          style: TextStyle(
                            color: AppColors.onSurfaceVariant,
                            fontSize: 10,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const Icon(Icons.check_circle, color: AppColors.primary),
              ],
            ),
          ),
          const SizedBox(height: 12),
          // Per Lesson
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.surfaceContainerLowest.withOpacity(0.5),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.transparent, width: 2),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.confirmation_number_outlined,
                  color: AppColors.onSurfaceVariant,
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'بالحصة (Per Lesson)',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      'يتم الدفع عند كل حضور',
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
          const SizedBox(height: 24),
          const Divider(color: Color(0x33B0C7F9)), // primaryContainer/20
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.tertiaryContainer.withOpacity(0.3),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(
                  Icons.info_outline,
                  color: AppColors.tertiary,
                  size: 16,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'تنبيه: نظام الدفع الشهري يمنح الطالب وصولاً كاملاً للمنصة التعليمية والمواد المسجلة.',
                    style: TextStyle(
                      color: AppColors.onTertiaryContainer,
                      fontSize: 11,
                      height: 1.5,
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
