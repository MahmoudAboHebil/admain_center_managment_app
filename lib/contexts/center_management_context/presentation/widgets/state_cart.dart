import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../config/theme/colors.dart';
import '../../../../config/theme/typography.dart';

class StatCard extends StatelessWidget {
  const StatCard({
    super.key,
    required this.label,
    required this.value,
    required this.valueColor,
    this.isDesktop = true,
    required this.lineColor,
  });
  final String label;
  final String value;
  final Color valueColor;
  final Color lineColor;
  final bool isDesktop;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.centerStart,
      clipBehavior: Clip.hardEdge,

      children: [
        Container(
          margin: EdgeInsets.symmetric(vertical: 5),
          width: 20,
          height: 86,
          decoration: BoxDecoration(
            color: lineColor,
            borderRadius: BorderRadius.circular(300),
          ),
        ),
        Row(
          children: [
            Expanded(
              child: Container(
                margin: const EdgeInsetsDirectional.only(start: 5),
                alignment: Alignment.center,
                height: 93,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 4,
                      spreadRadius: 0,
                      offset: Offset(0, 2),
                    ),
                  ],
                  color: AppColors.surfaceContainerLowest,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: AppColors.outlineVariant.withOpacity(0.15),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      label,
                      style: TextStyle(
                        color: AppColors.onSurfaceVariant,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      value,
                      style: AppTypography.textTheme.headlineMedium?.copyWith(
                        color: valueColor,
                        fontSize: 17.sp,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
