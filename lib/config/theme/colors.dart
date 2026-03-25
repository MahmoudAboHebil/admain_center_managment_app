import 'package:flutter/material.dart';

class AppColors {
  // Primary
  static const Color primary = Color(0xFF495F8B);
  static const Color primaryDim = Color(0xFF3D537E);
  static const Color onPrimary = Color(0xFFF9F8FF);
  static const Color primaryContainer = Color(0xFFB0C7F9);
  static const Color onPrimaryContainer = Color(0xFF29406A);
  static const Color primaryFixedDim = Color(0xFFA2B9EA);

  // Secondary
  static const Color secondary = Color(0xFF575F72);
  static const Color onSecondary = Color(0xFFF9F8FF);
  static const Color secondaryContainer = Color(0xFFDBE2F9);
  static const Color onSecondaryContainer = Color(0xFF4A5264);

  // Tertiary
  static const Color tertiary = Color(0xFF685781);
  static const Color tertiaryContainer = Color(0xFFE4CEFF);
  static const Color onTertiaryContainer = Color(0xFF54436B);

  // Error
  static const Color error = Color(0xFFA83836);
  static const Color errorContainer = Color(0xFFFA746F);
  static const Color onError = Color(0xFFFFF7F6);
  static const Color onErrorContainer = Color(0xFF6E0A12);

  // Custom opacities specified in DESIGN.md
  static final Color ghostBorder = outlineVariant.withOpacity(0.15);
  static final Color ambientShadow = onSurface.withOpacity(0.06);

  // Surfaces
  static const Color background = Color(0xFFFAF9FE);
  static const Color onBackground = Color(0xFF2F323A);

  static const Color surface = Color(0xFFFAF9FE);
  static const Color surfaceContainerLowest = Color(0xFFFFFFFF);
  static const Color surfaceContainerLow = Color(0xFFF3F3FA);
  static const Color surfaceContainer = Color(0xFFEDEDF6);
  static const Color surfaceContainerHigh = Color(0xFFE7E8F1);
  static const Color surfaceContainerHighest = Color(0xFFE0E2ED);

  static const Color onSurface = Color(0xFF2F323A);
  static const Color onSurfaceVariant = Color(0xFF5C5F68);

  static const Color outline = Color(0xFF787A84);
  static const Color outlineVariant = Color(0xFFAFB1BC);
}
