import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:yumm/constants.dart';
import 'package:yumm/theme/app_theme.dart';
import 'package:yumm/theme/app_colors.dart' as new_colors;
import 'package:yumm/theme/hexagon_background.dart';
import 'package:yumm/viewmodels/theme_cubit.dart';
import 'package:yumm/views/splash_screen.dart';

class YummApp extends StatelessWidget {
  const YummApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeMode>(
      builder: (context, mode) {
        return MaterialApp(
          title: AppStrings.appName,
          debugShowCheckedModeBanner: false,
          theme: AppTheme.light,
          darkTheme: AppTheme.dark,
          themeMode: mode,
          builder: (context, child) {
            final isDark = Theme.of(context).brightness == Brightness.dark;
            return Stack(
              children: [
                // The solid background color now lives here instead of in
                // each Scaffold (which is transparent) - this is what
                // actually paints the screen behind the hex pattern.
                Positioned.fill(
                  child: Container(
                    color: isDark ? new_colors.AppColors.darkBackground : new_colors.AppColors.lightBackground,
                  ),
                ),
                Positioned.fill(
                  child: HexagonBackground(
                    color: isDark
                        ? new_colors.AppColors.gold
                        : new_colors.AppColors.lightTextPrimary,
                    opacity: isDark ? 0.06 : 0.04,
                  ),
                ),
                if (child != null) child,
              ],
            );
          },
          home: const SplashScreen(),
        );
      },
    );
  }
}
