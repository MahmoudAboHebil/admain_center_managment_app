import 'package:flutter/material.dart';

import '../../../../config/theme/colors.dart';
import '../../../../config/theme/typography.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final String? placeholder;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool readOnly;
  final TextEditingController? controller;
  final String? initialValue;
  final int maxLines;
  final TextInputType keyboardType;
  final TextDirection? textDirection;

  const CustomTextField({
    super.key,
    required this.label,
    this.placeholder,
    this.prefixIcon,
    this.suffixIcon,
    this.readOnly = false,
    this.controller,
    this.initialValue,
    this.maxLines = 1,
    this.keyboardType = TextInputType.text,
    this.textDirection,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0, right: 4.0),
          child: Text(
            label,
            style: AppTypography.textTheme.labelMedium?.copyWith(
              color: AppColors.onSurfaceVariant,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        TextFormField(
          controller: controller,
          initialValue: initialValue,
          readOnly: readOnly,
          maxLines: maxLines,
          keyboardType: keyboardType,
          textDirection: textDirection,
          style: AppTypography.textTheme.bodyMedium?.copyWith(
            color: readOnly ? AppColors.outline : AppColors.onSurface,
          ),
          decoration: InputDecoration(
            hintText: placeholder,
            hintStyle: AppTypography.textTheme.bodyMedium?.copyWith(
              color: AppColors.outlineVariant,
            ),
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon,
            fillColor: readOnly
                ? AppColors.surfaceContainerLow
                : AppColors.surfaceContainerHigh,
            filled: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: readOnly
                  ? const BorderSide(
                      color: AppColors.outlineVariant,
                      width: 0.2,
                    )
                  : BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: readOnly
                  ? const BorderSide(
                      color: AppColors.outlineVariant,
                      width: 0.2,
                    )
                  : BorderSide.none,
            ),
            focusedBorder: readOnly
                ? OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(
                      color: AppColors.outlineVariant,
                      width: 0.2,
                    ),
                  )
                : OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(
                      color: AppColors.primary,
                      width: 2,
                    ),
                  ),
          ),
        ),
      ],
    );
  }
}
