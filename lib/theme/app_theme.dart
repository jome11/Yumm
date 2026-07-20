import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_typography.dart';

/// Drop-in ThemeData for the two surfaces used across Yumm Hive.
/// Wire into MaterialApp as:
///
/// ```dart
/// MaterialApp(
///   theme: AppTheme.light,
///   darkTheme: AppTheme.dark,
///   themeMode: ThemeMode.system, // or control manually per-screen
///   ...
/// )
/// ```
///
/// Screens in the screenshots don't strictly follow system dark/light —
/// Dashboard/Alerts are always dark, Intelligence/Analytics/My Hives are
/// always light — so you may instead want to apply these as fixed Theme
/// wrappers per-screen rather than via themeMode. Both are provided so
/// either approach works.
class AppTheme {
  AppTheme._();

  static ThemeData get dark => ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Colors.transparent,
        canvasColor: AppColors.darkBackground,
        colorScheme: const ColorScheme.dark(
          surface: AppColors.darkSurface,
          primary: AppColors.gold,
          secondary: AppColors.success,
          error: AppColors.warning,
          tertiary: AppColors.info,
          onSurface: AppColors.darkTextPrimary,
        ),
        textTheme: AppTypography.dark,
        cardTheme: CardThemeData(
          color: AppColors.darkSurface,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: const BorderSide(color: AppColors.darkSurfaceBorder),
          ),
        ),
        dividerColor: AppColors.darkSurfaceBorder,
        iconTheme: const IconThemeData(color: AppColors.gold),
        appBarTheme: AppBarTheme(
          backgroundColor: AppColors.darkBackground,
          elevation: 0,
          titleTextStyle: AppTypography.dark.headlineMedium,
          iconTheme: const IconThemeData(color: AppColors.darkTextPrimary),
        ),
      );

  static ThemeData get light => ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        scaffoldBackgroundColor: Colors.transparent,
        canvasColor: AppColors.lightBackground,
        colorScheme: const ColorScheme.light(
          surface: AppColors.lightSurface,
          primary: AppColors.gold,
          secondary: AppColors.success,
          error: AppColors.warning,
          tertiary: AppColors.info,
          onSurface: AppColors.lightTextPrimary,
        ),
        textTheme: AppTypography.light,
        cardTheme: CardThemeData(
          color: AppColors.lightSurface,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: const BorderSide(color: AppColors.lightSurfaceBorder),
          ),
        ),
        dividerColor: AppColors.lightSurfaceBorder,
        iconTheme: const IconThemeData(color: AppColors.gold),
        appBarTheme: AppBarTheme(
          backgroundColor: AppColors.lightBackground,
          elevation: 0,
          titleTextStyle: AppTypography.light.headlineMedium,
          iconTheme: const IconThemeData(color: AppColors.lightTextPrimary),
        ),
      );
}
