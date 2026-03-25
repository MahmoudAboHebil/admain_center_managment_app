import 'package:flutter/material.dart';

import '../../../../config/theme/colors.dart';

enum ButtonType { primary, secondary, tertiary, icon }

class CustomButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final ButtonType type;
  final IconData? icon;
  final bool isFullWidth;
  final Color? customColor;
  final Color? customTextColor;

  const CustomButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.type = ButtonType.primary,
    this.icon,
    this.isFullWidth = false,
    this.customColor,
    this.customTextColor,
  });

  @override
  Widget build(BuildContext context) {
    Widget buttonContent = Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (icon != null) ...[Icon(icon, size: 20), const SizedBox(width: 8)],
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
      ],
    );

    if (isFullWidth) {
      buttonContent = SizedBox(width: double.infinity, child: buttonContent);
    }

    switch (type) {
      case ButtonType.primary:
        return ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: customColor ?? AppColors.primary,
            foregroundColor: customTextColor ?? AppColors.onPrimary,
            elevation: 2,
            shadowColor: AppColors.onSurface.withOpacity(0.1),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          ),
          child: buttonContent,
        );
      case ButtonType.secondary:
        return ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: customColor ?? AppColors.secondaryContainer,
            foregroundColor: customTextColor ?? AppColors.onSecondaryContainer,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          ),
          child: buttonContent,
        );
      case ButtonType.tertiary:
        return TextButton(
          onPressed: onPressed,
          style: TextButton.styleFrom(
            foregroundColor: customTextColor ?? AppColors.primary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          ),
          child: buttonContent,
        );
      case ButtonType.icon:
        return IconButton(
          onPressed: onPressed,
          icon: Icon(
            icon,
            color: customTextColor ?? AppColors.onSurfaceVariant,
          ),
          style: IconButton.styleFrom(
            backgroundColor: customColor ?? AppColors.surfaceContainerHigh,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        );
    }
  }
}
