import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

/// Typography extracted from the screenshots. Three families are in play:
///
/// 1. Serif display — big numbers, names, section headers
///    ("Natnael", "1,280 kg", "Intelligence", "My Hives")
///    -> Playfair Display (closest open-source match)
///
/// 2. Tracked uppercase mono — small eyebrow labels
///    ("GOOD MORNING", "SEASON YIELD", "HIVES", "6 NODES ACTIVE")
///    -> JetBrains Mono
///
/// 3. Sans body — list content, descriptions, hive names
///    ("Hive #02", "North Field", "Harvest Ready")
///    -> Inter
///
/// Add to pubspec.yaml:
///   dependencies:
///     google_fonts: ^6.2.1
class AppTypography {
  AppTypography._();

  static TextStyle _serif({
    required double size,
    FontWeight weight = FontWeight.w700,
    required Color color,
    double? height,
  }) =>
      GoogleFonts.playfairDisplay(
        fontSize: size,
        fontWeight: weight,
        color: color,
        height: height,
      );

  static TextStyle _mono({
    required double size,
    FontWeight weight = FontWeight.w500,
    required Color color,
    double letterSpacing = 1.6,
  }) =>
      GoogleFonts.jetBrainsMono(
        fontSize: size,
        fontWeight: weight,
        color: color,
        letterSpacing: letterSpacing,
      );

  static TextStyle _sans({
    required double size,
    FontWeight weight = FontWeight.w500,
    required Color color,
  }) =>
      GoogleFonts.inter(
        fontSize: size,
        fontWeight: weight,
        color: color,
      );

  /// Full Material TextTheme for a given base text color, so it can be
  /// reused for both the dark and light surfaces.
  static TextTheme textTheme(Color primary, Color secondary) => TextTheme(
        // Big serif numbers e.g. "1,280 kg", "94%"
        displayLarge: _serif(size: 40, weight: FontWeight.w700, color: primary),
        displayMedium: _serif(size: 32, weight: FontWeight.w700, color: primary),
        // Section titles e.g. "Intelligence", "My Hives", "Fleet Status"
        headlineLarge: _serif(size: 28, weight: FontWeight.w700, color: primary),
        headlineMedium: _serif(size: 22, weight: FontWeight.w700, color: primary),
        // Card titles e.g. "Harvest Window — Hive #02"
        titleLarge: _sans(size: 17, weight: FontWeight.w600, color: primary),
        titleMedium: _sans(size: 15, weight: FontWeight.w600, color: primary),
        // Tracked uppercase eyebrow labels e.g. "SEASON YIELD", "TEMP"
        labelLarge: _mono(size: 12, color: secondary),
        labelMedium: _mono(size: 11, color: secondary),
        labelSmall: _mono(size: 10, color: secondary),
        // Body copy e.g. "North Field", "Peak capacity reached."
        bodyLarge: _sans(size: 15, weight: FontWeight.w400, color: primary),
        bodyMedium: _sans(size: 13, weight: FontWeight.w400, color: secondary),
        bodySmall: _sans(size: 12, weight: FontWeight.w400, color: secondary),
      );

  static TextTheme get dark =>
      textTheme(AppColors.darkTextPrimary, AppColors.darkTextSecondary);

  static TextTheme get light =>
      textTheme(AppColors.lightTextPrimary, AppColors.lightTextSecondary);
}
