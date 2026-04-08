import 'package:admain_center_managment_app/config/theme/colors.dart';
import 'package:admain_center_managment_app/contexts/center_management_context/presentation/screens/mobile_app_screens/student_profile_screen.dart';
import 'package:admain_center_managment_app/sync_engine/domain/entities/student_entity.dart';
import 'package:flutter/material.dart';

class SearchStudentCard extends StatelessWidget {
  final StudentEntity studentEntity;
  final String name;
  final String level;
  final String id;

  const SearchStudentCard({
    super.key,
    required this.name,
    required this.level,
    required this.id,
    required this.studentEntity,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.push(
          context,
          PageRouteBuilder(
            transitionDuration: Duration(milliseconds: 300),
            reverseTransitionDuration: Duration(milliseconds: 300),

            pageBuilder: (context, animation, secondaryAnimation) {
              return StudentProfileScreen(student: studentEntity);
            },

            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
                  final slide = Tween<Offset>(
                    begin: Offset(1, 0),
                    end: Offset.zero,
                  ).animate(animation);

                  final fade = Tween<double>(
                    begin: 0.0,
                    end: 1.0,
                  ).animate(animation);

                  return FadeTransition(
                    opacity: fade,
                    child: SlideTransition(position: slide, child: child),
                  );
                },
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              alignment: Alignment.center,
              height: 33,
              width: 33,
              decoration: BoxDecoration(
                color: AppColors.surfaceContainerHigh,
                borderRadius: BorderRadius.circular(100),
              ),
              child: Text(name[0], style: TextStyle(color: AppColors.primary)),
            ),
            SizedBox(width: 6),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2F323A),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 1),
                Text(
                  level,
                  style: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF495F8B), // primary
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
