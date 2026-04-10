import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../config/theme/app_theme.dart';
import '../../../../core/enums/student_status_enum.dart';

class UserStateCard extends StatelessWidget {
  const UserStateCard({
    super.key,
    required this.status,
    required this.isArabic,
  });
  final StudentStatus status;
  final bool isArabic;

  @override
  Widget build(BuildContext context) {
    if (status == StudentStatus.active) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        decoration: BoxDecoration(
          color: AppTheme.primary,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Text(
          isArabic ? StudentStatus.active.arabic : StudentStatus.active.english,
          style: GoogleFonts.inter(
            fontSize: 11.sp,
            color: AppTheme.onPrimary,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
    } else if (status == StudentStatus.inactive) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        decoration: BoxDecoration(
          color: Color(0xFFF3F3FA),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Text(
          isArabic
              ? StudentStatus.inactive.arabic
              : StudentStatus.inactive.english,
          style: GoogleFonts.inter(
            fontSize: 11.sp,
            color: const Color(0xFF5C5F68),
            fontWeight: FontWeight.bold,
          ),
        ),
      );
    } else {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        decoration: BoxDecoration(
          color: Colors.red.shade100,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Text(
          isArabic
              ? StudentStatus.latePayment.arabic
              : StudentStatus.latePayment.english,
          style: GoogleFonts.inter(
            fontSize: 11.sp,
            color: Colors.red.shade800,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
    }
  }
}
