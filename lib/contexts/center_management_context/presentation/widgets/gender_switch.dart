import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../config/theme/app_theme.dart';
import '../../../../generated/l10n.dart';

class GenderSwitch extends StatelessWidget {
  const GenderSwitch({
    super.key,
    required this.onTapMale,
    required this.onTapFemail,
    required bool isMale,
  }) : _isMale = isMale;
  final VoidCallback onTapMale;
  final VoidCallback onTapFemail;
  final bool _isMale;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: AppTheme.surfaceContainerHigh,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: onTapMale,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: _isMale
                    ? BoxDecoration(
                        color: AppTheme.surfaceContainerLowest,
                        borderRadius: BorderRadius.circular(6),
                        boxShadow: const [
                          BoxShadow(color: Colors.black12, blurRadius: 4),
                        ],
                      )
                    : null,
                child: Center(
                  child: Text(
                    S.of(context).male,
                    style: GoogleFonts.inter(
                      fontSize: 13.sp,

                      fontWeight: _isMale ? FontWeight.bold : FontWeight.w500,
                      color: _isMale
                          ? AppTheme.primary
                          : AppTheme.onSurfaceVariant,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: onTapFemail,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: !_isMale
                    ? BoxDecoration(
                        color: AppTheme.surfaceContainerLowest,
                        borderRadius: BorderRadius.circular(6),
                        boxShadow: const [
                          BoxShadow(color: Colors.black12, blurRadius: 4),
                        ],
                      )
                    : null,
                child: Center(
                  child: Text(
                    S.of(context).female,
                    style: GoogleFonts.inter(
                      fontSize: 13.sp,

                      fontWeight: !_isMale ? FontWeight.bold : FontWeight.w500,
                      color: !_isMale
                          ? AppTheme.primary
                          : AppTheme.onSurfaceVariant,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
