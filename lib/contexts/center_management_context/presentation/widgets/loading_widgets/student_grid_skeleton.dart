import 'package:flutter/material.dart';

import '../../../../../config/theme/app_theme.dart';
import '../../../../../config/theme/typography.dart';

class StudentGridSkeleton extends StatelessWidget {
  const StudentGridSkeleton();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        int crossAxisCount = 1;

        if (constraints.maxWidth >= 1400) {
          crossAxisCount = 5;
        } else if (constraints.maxWidth >= 1200) {
          crossAxisCount = 4;
        } else if (constraints.maxWidth >= 900) {
          crossAxisCount = 3;
        } else if (constraints.maxWidth >= 600) {
          crossAxisCount = 2;
        } else {
          crossAxisCount = 1;
        }
        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: 24,
            mainAxisSpacing: 24,
            childAspectRatio: 1.6,
            mainAxisExtent: 160,
          ),
          itemCount: 6,
          itemBuilder: (context, index) {
            if (index == 5) {
              return _buildAddStudentPlaceholder();
            }
            return _buildStudentCardSkeleton(index);
          },
        );
      },
    );
  }

  Widget _buildStudentCardSkeleton(int index) {
    final widths = [0.5, 0.66, 0.5, 0.75, 0.5];
    final wMultiplier = widths[index % widths.length];

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppTheme.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTheme.ghostBorder),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FractionallySizedBox(
                      widthFactor: wMultiplier,
                      child: const _SkeletonBlock(height: 24),
                    ),
                    const SizedBox(height: 12),
                    FractionallySizedBox(
                      widthFactor: wMultiplier * 0.7,
                      child: const _SkeletonBlock(height: 12),
                    ),
                    const SizedBox(height: 8),
                  ],
                ),
              ),
              const _SkeletonBlock(width: 24, height: 24),
            ],
          ),
          Container(
            padding: const EdgeInsets.only(top: 16),
            decoration: BoxDecoration(
              border: Border(top: BorderSide(color: AppTheme.ghostBorder)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const _SkeletonBlock(width: 28, height: 28, isCircle: true),
                    if (index % 2 == 0) ...[
                      const SizedBox(width: 4),
                      const _SkeletonBlock(
                        width: 28,
                        height: 28,
                        isCircle: true,
                      ),
                    ],
                  ],
                ),
                const _SkeletonBlock(width: 80, height: 32, radius: 8),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAddStudentPlaceholder() {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.surfaceContainerLow.withOpacity(0.3),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppTheme.ghostBorder.withOpacity(0.4),
          width: 2,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.5),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.add, color: AppTheme.outlineVariant),
          ),
          const SizedBox(height: 12),
          Text(
            'إضافة طالب جديد',
            style: AppTypography.textTheme.bodyMedium?.copyWith(
              color: AppTheme.outlineVariant,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class _SkeletonBlock extends StatelessWidget {
  final double width;
  final double height;
  final double radius;
  final bool isCircle;

  const _SkeletonBlock({
    this.width = double.infinity,
    this.height = 20,
    this.radius = 4,
    this.isCircle = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: AppTheme.surfaceContainerHigh,
        borderRadius: isCircle ? null : BorderRadius.circular(radius),
        shape: isCircle ? BoxShape.circle : BoxShape.rectangle,
      ),
    );
  }
}
