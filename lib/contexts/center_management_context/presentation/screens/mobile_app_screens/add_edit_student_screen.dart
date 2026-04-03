import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../config/theme/app_theme.dart';


class AddEditStudentScreen extends StatefulWidget {
  const AddEditStudentScreen({super.key});

  @override
  State<AddEditStudentScreen> createState() => _AddEditStudentScreenState();
}

class _AddEditStudentScreenState extends State<AddEditStudentScreen> {
  int _paymentMethod = 0; // 0 for full, 1 for installments

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'إضافة / تعديل طالب',
          style: GoogleFonts.manrope(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppTheme.primary,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_forward),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            width: 32,
            height: 32,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: AppTheme.secondaryContainer,
              image: DecorationImage(
                image: NetworkImage(
                    'https://lh3.googleusercontent.com/aida-public/AB6AXuAE9mnBICm0TAh0DeEmEEchIjP9jI6chpucbPTXZ61DoKoXnTkFqbMGMADD75sNp98hR0Hx4O4IwbA1LcO1xFoXbwQQETRa1NvQfKNHR1lpWrpu0lod2FzO-QwrcpCvBJga0fJOCmxlDxYSAsTzwe_Jrpoown9IyZgclvOLlH8GQSoqlsYNhFsC_Lk2F1VkAKw_xCJ6oRvnS4i-sZa9srXuMt2yHjcsACUYuC79jciWX30iw0Y2vZbEfm1AZa6NYgtLuQTXZqMjuvgL'),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Profile Image Uploader
            Center(
              child: Column(
                children: [
                  Stack(
                    children: [
                      Container(
                        width: 96,
                        height: 96,
                        decoration: BoxDecoration(
                          color: AppTheme.surfaceContainerHigh,
                          shape: BoxShape.circle,
                          border: Border.all(color: AppTheme.surfaceContainerLowest, width: 4),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 8,
                            ),
                          ],
                        ),
                        child: const Icon(Icons.person, size: 48, color: AppTheme.outline),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0, // In RTL, this positions it on the bottom right visually
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: const BoxDecoration(
                            color: AppTheme.primary,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.edit, size: 16, color: AppTheme.onPrimary),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'تحميل صورة الطالب',
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: AppTheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            // Form Sections
            _buildFormSection(
              icon: Icons.badge,
              title: 'المعلومات الأساسية',
              children: [
                _buildTextField(label: 'اسم الطالب بالكامل', hint: 'أدخل الاسم الرباعي'),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(child: _buildTextField(label: 'رقم الهوية', hint: '123456789', keyboardType: TextInputType.number)),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('الجنس', style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w600, color: AppTheme.onSurfaceVariant)),
                          const SizedBox(height: 6),
                          DropdownButtonFormField<String>(
                            decoration: const InputDecoration(contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14)),
                            value: 'ذكر',
                            items: const [
                              DropdownMenuItem(value: 'ذكر', child: Text('ذكر')),
                              DropdownMenuItem(value: 'أنثى', child: Text('أنثى')),
                            ],
                            onChanged: (_) {},
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                _buildTextField(label: 'تاريخ الميلاد', hint: 'DD/MM/YYYY', icon: Icons.calendar_today),
              ],
            ),
            const SizedBox(height: 24),
            _buildFormSection(
              icon: Icons.school,
              title: 'التفاصيل الأكاديمية',
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('المستوى الدراسي', style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w600, color: AppTheme.onSurfaceVariant)),
                          const SizedBox(height: 6),
                          DropdownButtonFormField<String>(
                            decoration: const InputDecoration(contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14)),
                            value: 'المرحلة الثانوية',
                            items: const [
                              DropdownMenuItem(value: 'المرحلة الابتدائية', child: Text('المرحلة الابتدائية')),
                              DropdownMenuItem(value: 'المرحلة المتوسطة', child: Text('المرحلة المتوسطة')),
                              DropdownMenuItem(value: 'المرحلة الثانوية', child: Text('المرحلة الثانوية')),
                            ],
                            onChanged: (_) {},
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(child: _buildTextField(label: 'الصف / القسم', hint: 'مثال: أ-1')),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 24),
            _buildFormSection(
              icon: Icons.contact_phone,
              title: 'بيانات التواصل',
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('رقم هاتف ولي الأمر', style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w600, color: AppTheme.onSurfaceVariant)),
                    const SizedBox(height: 6),
                    TextField(
                      decoration: InputDecoration(
                        hintText: '50 000 0000',
                        prefixIcon: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text('+966', style: GoogleFonts.inter(color: AppTheme.outline)),
                              const SizedBox(width: 8),
                              Container(width: 1, height: 24, color: AppTheme.outlineVariant.withOpacity(0.3)),
                            ],
                          ),
                        ),
                      ),
                      keyboardType: TextInputType.phone,
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                _buildTextField(label: 'البريد الإلكتروني', hint: 'example@mail.com', keyboardType: TextInputType.emailAddress),
              ],
            ),
            const SizedBox(height: 24),
            _buildFormSection(
              icon: Icons.payments,
              title: 'نظام الدفع',
              children: [
                _buildRadioTile(
                  value: 0,
                  groupValue: _paymentMethod,
                  title: 'دفع كامل المصاريف',
                  subtitle: 'خصم 5% عند السداد المبكر',
                  onChanged: (val) => setState(() => _paymentMethod = val!),
                ),
                const SizedBox(height: 12),
                _buildRadioTile(
                  value: 1,
                  groupValue: _paymentMethod,
                  title: 'نظام الأقساط الشهرية',
                  subtitle: '4 دفعات متساوية خلال الفصل',
                  onChanged: (val) => setState(() => _paymentMethod = val!),
                ),
              ],
            ),
            const SizedBox(height: 32),
            // Actions
            ElevatedButton.icon(
              onPressed: () => Navigator.pop(context),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 56),
                shadowColor: AppTheme.primary.withOpacity(0.4),
                elevation: 4,
              ),
              icon: const Text('حفظ البيانات'),
              label: const Icon(Icons.save),
            ),
            const SizedBox(height: 12),
            TextButton(
              onPressed: () => Navigator.pop(context),
              style: TextButton.styleFrom(
                backgroundColor: AppTheme.surfaceContainerHighest,
                foregroundColor: AppTheme.onSurface,
                minimumSize: const Size(double.infinity, 56),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: Text(
                'إلغاء التعديلات',
                style: GoogleFonts.inter(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),
            const SizedBox(height: 48), // Padding bottom
          ],
        ),
      ),
    );
  }

  Widget _buildFormSection({required IconData icon, required String title, required List<Widget> children}) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppTheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: AppTheme.primary, size: 20),
              const SizedBox(width: 8),
              Text(
                title,
                style: GoogleFonts.manrope(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.primary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ...children,
        ],
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required String hint,
    TextInputType? keyboardType,
    IconData? icon,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: AppTheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: 6),
        TextField(
          keyboardType: keyboardType,
          decoration: InputDecoration(
            hintText: hint,
            suffixIcon: icon != null ? Icon(icon, color: AppTheme.outlineVariant) : null, // suffix because RTL
          ),
        ),
      ],
    );
  }

  Widget _buildRadioTile({
    required int value,
    required int groupValue,
    required String title,
    required String subtitle,
    required ValueChanged<int?> onChanged,
  }) {
    final isSelected = value == groupValue;
    return GestureDetector(
      onTap: () => onChanged(value),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppTheme.surfaceContainerLowest,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppTheme.outlineVariant.withOpacity(0.2)),
        ),
        child: Row(
          children: [
            Radio<int>(
              value: value,
              groupValue: groupValue,
              onChanged: onChanged,
              activeColor: AppTheme.primary,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.onSurface,
                  ),
                ),
                Text(
                  subtitle,
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    color: AppTheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
