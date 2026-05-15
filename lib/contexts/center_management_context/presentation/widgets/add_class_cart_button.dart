import 'package:admain_center_managment_app/contexts/center_management_context/presentation/widgets/pressable_button.dart';
import 'package:flutter/material.dart';

import '../../../../config/theme/app_theme.dart';
import '../screens/mobile_app_screens/classes_screens/create_class_screen.dart';

class AddClassCartButton extends StatelessWidget {
  const AddClassCartButton({super.key});

  @override
  Widget build(BuildContext context) {
    return PressableButton(
      child: Container(
        padding: const EdgeInsets.all(32),
        decoration: BoxDecoration(
          color: AppTheme.surfaceContainerLow.withOpacity(0.3),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: AppTheme.outlineVariant.withOpacity(0.3),
            width: 2,
            // Note: Flutter doesn't natively support dashed borders without a custom painter or external package.
            // Using a solid line here. If you need dashed borders, consider using the 'dotted_border' package.
          ),
        ),
        child: Column(
          children: [
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x0A000000),
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Icon(
                Icons.library_add,
                color: AppTheme.primary.withOpacity(0.4),
                size: 32,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'هل ترغب في تنظيم فصل جديد؟',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Manrope',
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: AppTheme.onSurface,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'قم بإضافة فصولك الدراسية وتعيين المعلمين والطلاب بسهولة',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 14,
                color: AppTheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 24),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CreateClassScreen()),
                );
              },
              style: TextButton.styleFrom(
                backgroundColor: AppTheme.primary.withOpacity(0.1),
                foregroundColor: AppTheme.primary,
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 12,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                  side: BorderSide(color: AppTheme.primary.withOpacity(0.2)),
                ),
              ),
              child: const Text(
                'إضافة فصل الآن',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
