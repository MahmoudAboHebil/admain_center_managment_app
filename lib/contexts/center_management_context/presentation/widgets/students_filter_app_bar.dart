import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../config/theme/app_theme.dart';
import '../../../../config/theme/colors.dart';
import '../../../../generated/l10n.dart';
import '../screens/mobile_app_screens/students_list_screen.dart';

class StudentsFilterAppBar extends StatefulWidget
    implements PreferredSizeWidget {
  final Function onClickingReset;

  const StudentsFilterAppBar({super.key, required this.onClickingReset});

  @override
  State<StudentsFilterAppBar> createState() => _StudentsFilterAppBarState();

  @override
  Size get preferredSize => Size.fromHeight(60);
}

class _StudentsFilterAppBarState extends State<StudentsFilterAppBar> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Container(
        height: 60,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: AppColors.surface.withOpacity(0.9),
          border: Border(
            bottom: BorderSide(
              color: AppColors.outlineVariant.withOpacity(0.1),
            ),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            IconButton(
              icon: Icon(Icons.close, size: 24.sp),
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  PageRouteBuilder(
                    transitionDuration: Duration(milliseconds: 300),
                    reverseTransitionDuration: Duration(milliseconds: 300),

                    pageBuilder: (context, animation, secondaryAnimation) {
                      return StudentsListScreen();
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
                            child: SlideTransition(
                              position: slide,
                              child: child,
                            ),
                          );
                        },
                  ),
                  (route) => false,
                );
              },
            ),
            Text(
              S.of(context).filterResults,
              style: TextStyle(
                fontSize: 20.sp,
                color: AppColors.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
            Spacer(),
            TextButton(
              onPressed: () async {
                await widget.onClickingReset();
              },
              child: Text(
                S.of(context).reset,
                style: GoogleFonts.manrope(
                  fontSize: 13.sp,
                  color: AppTheme.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
