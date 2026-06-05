import 'package:admain_center_managment_app/config/route/route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../config/theme/app_theme.dart';
import '../../../../generated/l10n.dart';

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
          color: AppTheme.surface.withOpacity(0.9),
          border: Border(
            bottom: BorderSide(color: AppTheme.outlineVariant.withOpacity(0.1)),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            IconButton(
              icon: Icon(Icons.close, size: 24.sp),
              onPressed: () {
                context.goNamed(RouteName.studentsOverview);
              },
            ),
            Text(
              S.of(context).filterResults,
              style: TextStyle(
                fontSize: 20.sp,
                color: AppTheme.primary,
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
