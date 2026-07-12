import 'package:flutter/material.dart';
import 'app_colors.dart';

/// Central text style catalogue. Static styles are theme-agnostic
/// (weight/size only); use the context-aware helpers below when a
/// style also needs to flip color between light/dark mode.
class AppTextStyles {
  AppTextStyles._();

  static const TextStyle h1 = TextStyle(fontSize: 28, fontWeight: FontWeight.w800, height: 1.15);
  static const TextStyle h2 = TextStyle(fontSize: 22, fontWeight: FontWeight.w800);
  static const TextStyle h3 = TextStyle(fontSize: 17, fontWeight: FontWeight.w700);
  static const TextStyle body = TextStyle(fontSize: 14, fontWeight: FontWeight.w400);
  static const TextStyle bodySecondary = TextStyle(fontSize: 13, fontWeight: FontWeight.w400);
  static const TextStyle caption = TextStyle(fontSize: 11, fontWeight: FontWeight.w600, letterSpacing: 0.6);
  static const TextStyle statNumber = TextStyle(fontSize: 26, fontWeight: FontWeight.w800);
  static const TextStyle button = TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: Colors.white);

  static TextStyle h1c(BuildContext c) => h1.copyWith(color: AppColors.textPrimary(c));
  static TextStyle h2c(BuildContext c) => h2.copyWith(color: AppColors.textPrimary(c));
  static TextStyle h3c(BuildContext c) => h3.copyWith(color: AppColors.textPrimary(c));
  static TextStyle bodyc(BuildContext c) => body.copyWith(color: AppColors.textPrimary(c));
  static TextStyle bodySecondaryc(BuildContext c) => bodySecondary.copyWith(color: AppColors.textSecondary(c));
  static TextStyle captionc(BuildContext c) => caption.copyWith(color: AppColors.textSecondary(c));
  static TextStyle statNumberc(BuildContext c) => statNumber.copyWith(color: AppColors.textPrimary(c));
}
