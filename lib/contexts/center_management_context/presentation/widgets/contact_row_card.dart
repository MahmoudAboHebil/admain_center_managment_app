import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../config/theme/app_theme.dart';
import '../../../../generated/l10n.dart';

class ContactRowCard extends StatelessWidget {
  const ContactRowCard({
    super.key,
    required this.screenWidth,
    required this.context,
    required this.icon,
    required this.title,
    this.value,
    required this.hasCallAction,
  });
  final double screenWidth;
  final BuildContext context;
  final IconData icon;
  final String title;
  final String? value;
  final bool hasCallAction;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTheme.outlineVariant.withOpacity(0.15)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(icon, color: AppTheme.onSurfaceVariant, size: 24.sp),
          const SizedBox(width: 12),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: GoogleFonts.inter(
                  fontSize: 11.sp,
                  color: AppTheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 2),
              value != null
                  ? Container(
                      width: screenWidth * 0.60,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Text(
                          value!,
                          style: GoogleFonts.inter(
                            fontSize: 13.sp,
                            fontWeight: FontWeight.bold,
                            color: AppTheme.onSurface,
                          ),
                        ),
                      ),
                    )
                  : Text(
                      S.of(context).notAdded,
                      style: GoogleFonts.inter(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.error,
                      ),
                    ),
            ],
          ),
          Spacer(),
          if (hasCallAction)
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                if (value != null)
                  MaterialButton(
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,

                    onPressed: () {},
                    elevation: 0,
                    hoverElevation: 0,
                    disabledElevation: 0,
                    highlightElevation: 0,
                    focusElevation: 0,
                    padding: EdgeInsets.zero,
                    shape: CircleBorder(),
                    minWidth: 32,
                    child: Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        color: AppTheme.primary.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.phone,
                        size: 16.sp,
                        color: AppTheme.primary,
                      ),
                    ),
                  ),
              ],
            ),
          if (!hasCallAction)
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                if (value != null)
                  MaterialButton(
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,

                    onPressed: () {},
                    elevation: 0,
                    hoverElevation: 0,
                    disabledElevation: 0,
                    highlightElevation: 0,
                    focusElevation: 0,
                    padding: EdgeInsets.zero,
                    shape: CircleBorder(),
                    minWidth: 32,
                    child: Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        color: AppTheme.primary.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.email,
                        size: 16.sp,
                        color: AppTheme.primary,
                      ),
                    ),
                  ),
              ],
            ),
        ],
      ),
    );
  }
}
