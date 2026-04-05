import 'package:flutter/material.dart';

import '../../../../config/theme/colors.dart';
import '../screens/mobile_app_screens/add_student_screen.dart';

class AddStudentCartButton extends StatelessWidget {
  const AddStudentCartButton({super.key, required this.isDesktop});
  final bool isDesktop;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => const AddStudentScreen()),
        );
      },
      child: Container(
        height: 140,

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
            const Text(
              'إضافة طالب جديد',
              style: TextStyle(
                color: AppColors.onSurfaceVariant,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
