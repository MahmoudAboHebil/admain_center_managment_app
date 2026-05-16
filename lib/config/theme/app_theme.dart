import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Primary
  static const Color primary = Color(0xFF495F8B);
  static const Color primaryDim = Color(0xFF3D537E);
  static const Color onPrimary = Color(0xFFF9F8FF);
  static const Color primaryContainer = Color(0xFFB0C7F9);
  static const Color onPrimaryContainer = Color(0xFF29406A);
  static const Color primaryFixedDim = Color(0xFFA2B9EA);
  static const Color onPrimaryFixed = Color(0xFF122B54);

  // Secondary
  static const Color secondary = Color(0xFF575F72);
  static const Color onSecondary = Color(0xFFF9F8FF);
  static const Color secondaryContainer = Color(0xFFDBE2F9);
  static const Color onSecondaryContainer = Color(0xFF4A5264);
  static const Color secondaryFixed = Color(0xFFdbe2f9);

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
  static const Color surfaceVariant = Color(0xFFe0e2ed);

  static const Color onSurface = Color(0xFF2F323A);
  static const Color onSurfaceVariant = Color(0xFF5C5F68);
  static const Color onSecondaryFixedVariant = Color(0xFF545b6e);
  static const Color outline = Color(0xFF787A84);
  static const Color outlineVariant = Color(0xFFAFB1BC);

  // General theme data
  static ThemeData get lightTheme {
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: primary,
        primary: primary,
        onPrimary: onPrimary,
        primaryContainer: primaryContainer,
        secondaryContainer: secondaryContainer,
        onSecondaryContainer: onSecondaryContainer,
        tertiary: tertiary,
        tertiaryContainer: tertiaryContainer,
        error: error,
        surface: surface,
        onSurface: onSurface,
        onSurfaceVariant: onSurfaceVariant,
        outline: outline,
        outlineVariant: outlineVariant,
      ),
      scaffoldBackgroundColor: surface,
      textTheme: TextTheme(
        displayLarge: GoogleFonts.manrope(
          color: onSurface,
          fontWeight: FontWeight.bold,
        ),
        displayMedium: GoogleFonts.manrope(
          color: onSurface,
          fontWeight: FontWeight.bold,
        ),
        displaySmall: GoogleFonts.manrope(
          color: onSurface,
          fontWeight: FontWeight.bold,
        ),
        headlineLarge: GoogleFonts.manrope(
          color: onSurface,
          fontWeight: FontWeight.bold,
        ),
        headlineMedium: GoogleFonts.manrope(
          color: onSurface,
          fontWeight: FontWeight.bold,
        ),
        headlineSmall: GoogleFonts.manrope(
          color: onSurface,
          fontWeight: FontWeight.bold,
        ),
        titleLarge: GoogleFonts.manrope(
          color: onSurface,
          fontWeight: FontWeight.bold,
        ),
        titleMedium: GoogleFonts.manrope(
          color: onSurface,
          fontWeight: FontWeight.bold,
        ),
        titleSmall: GoogleFonts.manrope(
          color: onSurface,
          fontWeight: FontWeight.bold,
        ),
        bodyLarge: GoogleFonts.inter(color: onSurface),
        bodyMedium: GoogleFonts.inter(color: onSurface),
        bodySmall: GoogleFonts.inter(color: onSurface),
        labelLarge: GoogleFonts.inter(color: onSurfaceVariant),
        labelMedium: GoogleFonts.inter(color: onSurfaceVariant),
        labelSmall: GoogleFonts.inter(color: onSurfaceVariant),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: surface.withOpacity(0.8),
        elevation: 0,
        centerTitle: false,
        iconTheme: const IconThemeData(color: primary),
        titleTextStyle: GoogleFonts.manrope(
          color: primary,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: surfaceContainerLowest,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: outlineVariant),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: outlineVariant.withOpacity(0.3)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: primary, width: 2),
        ),
        labelStyle: GoogleFonts.inter(color: onSurfaceVariant, fontSize: 12),
        hintStyle: GoogleFonts.inter(color: outline, fontSize: 14),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primary,
          foregroundColor: onPrimary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(vertical: 16),
          textStyle: GoogleFonts.inter(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: primary,
        foregroundColor: onPrimary,
        shape: CircleBorder(),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: surface,
        selectedItemColor: primary,
        unselectedItemColor: onSurfaceVariant,
        selectedLabelStyle: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 11,
        ),
        unselectedLabelStyle: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 11,
        ),
        type: BottomNavigationBarType.fixed,
        elevation: 8,
      ),
    );
  }
}
