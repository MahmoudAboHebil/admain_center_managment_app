import 'package:admain_center_managment_app/contexts/center_management_context/presentation/screens/mobile_app_screens/student_screens/student_profile_screen.dart';
import 'package:admain_center_managment_app/sync_engine/domain/entities/student_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../config/theme/app_theme.dart';

class SearchStudentCard extends StatelessWidget {
  final double width;
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
    required this.width,
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
        padding: const EdgeInsets.symmetric(vertical: 0.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              alignment: Alignment.center,
              height: 33,
              width: 33,
              decoration: BoxDecoration(
                color: AppTheme.tertiary.withOpacity(0.2),
                borderRadius: BorderRadius.circular(100),
              ),
              child: Text(
                name[0],
                style: TextStyle(color: AppTheme.primary, fontSize: 13.sp),
              ),
            ),
            SizedBox(width: 6),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: width * 0.65,
                  child: Text(
                    name,
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2F323A),
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                if (level.trim().isNotEmpty) ...[
                  const SizedBox(height: 1),
                  Text(
                    level,
                    style: TextStyle(
                      fontSize: 10.sp,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF495F8B), // primary
                    ),
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }
}
