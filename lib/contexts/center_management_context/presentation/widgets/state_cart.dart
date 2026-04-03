import 'package:flutter/material.dart';

import '../../../../config/theme/colors.dart';
import '../../../../config/theme/typography.dart';

class StatCard extends StatelessWidget {
  const StatCard({
    super.key,
    required this.label,
    required this.value,
    required this.valueColor,
    this.isDesktop = true,
  });
  final String label;
  final String value;
  final Color valueColor;
  final bool isDesktop;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      alignment: Alignment.center,

      padding: isDesktop ? EdgeInsets.all(24) : EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.outlineVariant.withOpacity(0.15)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            label,
            style: const TextStyle(
              color: AppColors.onSurfaceVariant,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: isDesktop ? 8 : 5),
          Text(
            value,
            style: isDesktop
                ? AppTypography.textTheme.headlineMedium?.copyWith(
                    color: valueColor,
                  )
                : AppTypography.textTheme.headlineMedium?.copyWith(
                    color: valueColor,
                    fontSize: 20,
                  ),
          ),
        ],
      ),
    );
  }
}
