import 'package:flutter/material.dart';


class AppColors {
  AppColors._();


  static const Color primary = Color(0xFFF3A93B); // honey amber
  static const Color primaryDark = Color(0xFFB9791E);


  static const Color lightBackground = Color(0xFFF1EEE6);
  static const Color lightSurface = Colors.white;
  static const Color lightTextPrimary = Color(0xFF1C1A16);
  static const Color lightTextSecondary = Color(0xFF7A756B);
  static const Color lightDivider = Color(0xFFE7E2D8);


  static const Color darkBackground = Color(0xFF15130E);
  static const Color darkSurface = Color(0xFF201C14);
  static const Color darkTextPrimary = Color(0xFFF5F2EA);
  static const Color darkTextSecondary = Color(0xFF9C9686);
  static const Color darkDivider = Color(0xFF322C1F);


  static const Color chrome = Color(0xFF17150F);


  static const Color statusHarvestReady = Color(0xFF544512);
  static const Color statusWarning = Color(0xFF5B2323);
  static const Color statusOptimal = Color(0xFF1B4332);
  static const Color statusRoutine = Color(0xFF1B2B4A);


  static const Color accentGold = Color(0xFFE0B341);
  static const Color accentRed = Color(0xFFE06666);
  static const Color accentGreen = Color(0xFF4CAF7D);
  static const Color accentBlue = Color(0xFF5C8DE0);


  static const Color tagPriority = Color(0xFFC9A22B);
  static const Color tagWarning = Color(0xFFC0392B);
  static const Color tagRoutine = Color(0xFF2E7D5B);

  static Color statusColor(String label) {
    switch (label) {
      case 'Warning':
        return statusWarning;
      case 'Optimal':
        return statusOptimal;
      case 'Routine':
        return statusRoutine;
      default:
        return statusHarvestReady;
    }
  }

  static Color statusAccent(String label) {
    switch (label) {
      case 'Warning':
        return accentRed;
      case 'Optimal':
        return accentGreen;
      case 'Routine':
        return accentBlue;
      default:
        return accentGold;
    }
  }

  static Color insightColor(String tag) {
    switch (tag.toUpperCase()) {
      case 'PRIORITY':
        return tagPriority;
      case 'WARNING':
        return tagWarning;
      default:
        return tagRoutine;
    }
  }


  static bool isDark(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark;

  static Color background(BuildContext context) =>
      isDark(context) ? darkBackground : lightBackground;

  static Color surface(BuildContext context) =>
      isDark(context) ? darkSurface : lightSurface;

  static Color textPrimary(BuildContext context) =>
      isDark(context) ? darkTextPrimary : lightTextPrimary;

  static Color textSecondary(BuildContext context) =>
      isDark(context) ? darkTextSecondary : lightTextSecondary;

  static Color divider(BuildContext context) =>
      isDark(context) ? darkDivider : lightDivider;
}
