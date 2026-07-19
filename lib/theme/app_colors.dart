import 'package:flutter/material.dart';

/// Color palette extracted from the Yumm Hive design screenshots.
/// Two surfaces are used across the app:
///  - Dark ("hive night"): dashboard, alerts feed
///  - Light ("hive parchment"): Intelligence, Analytics, My Hives
///
/// The accent family (gold / green / red / blue) is shared between both
/// surfaces — only the background/text/badge treatment changes.
class AppColors {
  AppColors._();

  // ---------------------------------------------------------------------
  // Dark surface ("hive night")
  // ---------------------------------------------------------------------
  static const Color darkBackground = Color(0xFF0A120D);
  static const Color darkSurface = Color(0xFF10190F);
  static const Color darkSurfaceBorder = Color(0xFF23301F);
  static const Color darkTextPrimary = Color(0xFFF5F0E6);
  static const Color darkTextSecondary = Color(0xFF8FA093);

  // ---------------------------------------------------------------------
  // Light surface ("hive parchment")
  // ---------------------------------------------------------------------
  static const Color lightBackground = Color(0xFFEDE6D6);
  static const Color lightSurface = Color(0xFFFAF7EF);
  static const Color lightSurfaceBorder = Color(0xFFE1D8C2);
  static const Color lightTextPrimary = Color(0xFF1E1B16);
  static const Color lightTextSecondary = Color(0xFF6B6558);

  // ---------------------------------------------------------------------
  // Shared accent family
  // ---------------------------------------------------------------------
  /// Primary brand accent — gold/amber, used for key numbers, active
  /// nav states, buttons, and the "Harvest Ready" hive card.
  static const Color gold = Color(0xFFD4A24C);
  static const Color goldMuted = Color(0xFF3A2E14); // dark badge bg

  /// Positive / healthy status — teal-green.
  static const Color success = Color(0xFF34D399);
  static const Color successMuted = Color(0xFF15291F); // dark badge bg

  /// Warning / alert status — coral-red.
  static const Color warning = Color(0xFFE2574C);
  static const Color warningMuted = Color(0xFF2E1512); // dark badge bg

  /// Informational status — sky blue (seen on Hive #15).
  static const Color info = Color(0xFF4EA8DE);
  static const Color infoMuted = Color(0xFF14232E); // dark badge bg

  // ---------------------------------------------------------------------
  // Light-surface badge chips (Intelligence feed pills)
  // ---------------------------------------------------------------------
  static const Color priorityChipBg = Color(0xFFF7E4C7);
  static const Color priorityChipFg = Color(0xFFB9741F);

  static const Color warningChipBg = Color(0xFFF9DAD6);
  static const Color warningChipFg = Color(0xFFC94635);

  static const Color routineChipBg = Color(0xFFD8F0DE);
  static const Color routineChipFg = Color(0xFF2F9E56);

  static const Color automatedChipBg = Color(0xFFD9E8F7);
  static const Color automatedChipFg = Color(0xFF3E7FBE);

  /// Fleet-breakdown progress bar colors (Analytics screen), in order
  /// of appearance: #02 amber, #06 red, #07 green, #12 green, #15 blue.
  static const List<Color> fleetBarColors = [
    gold,
    warning,
    success,
    success,
    info,
  ];
}
