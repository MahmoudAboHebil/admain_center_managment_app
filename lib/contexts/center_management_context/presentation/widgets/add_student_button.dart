import 'package:flutter/material.dart';

import '../../../../config/theme/colors.dart';
import '../screens/mobile_app_screens/add_student_screen.dart';

class AddStudentButton extends StatelessWidget {
  const AddStudentButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {
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
      icon: const Icon(Icons.person_add),
      label: const Text('إضافة طالب'),
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.onPrimary,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }
}
