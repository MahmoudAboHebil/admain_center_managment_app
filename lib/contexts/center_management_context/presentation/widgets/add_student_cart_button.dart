import 'package:admain_center_managment_app/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../config/theme/colors.dart';
import '../screens/mobile_app_screens/student_screens/add_student_screen.dart';

class AddStudentCartButton extends StatelessWidget {
  const AddStudentCartButton({super.key, required this.isDesktop});
  final bool isDesktop;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          PageRouteBuilder(
            transitionDuration: Duration(milliseconds: 300),
            reverseTransitionDuration: Duration(milliseconds: 300),

            pageBuilder: (context, animation, secondaryAnimation) {
              return AddStudentScreen();
            },

            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
                  final slide = Tween<Offset>(
                    begin: Offset(0, 1),
                    end: Offset.zero,
                  ).animate(animation);

                  final fade = Tween<double>(
                    begin: 0,
                    end: 1,
                  ).animate(animation);

                  return FadeTransition(
                    opacity: fade,
                    child: SlideTransition(position: slide, child: child),
                  );
                },
          ),
        );
      },
      child: Container(
        height: 100,

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
              child: Icon(
                Icons.add,
                color: AppColors.onSurfaceVariant,
                size: 24.sp,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              S.of(context).addNewStudent,
              style: TextStyle(
                color: AppColors.onSurfaceVariant,
                fontWeight: FontWeight.bold,
                fontSize: 12.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
