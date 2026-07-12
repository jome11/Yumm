import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';

/// Small square metric card used for Hives / Temp / Alerts on Home.
class StatCard extends StatelessWidget {
  final String value;
  final String label;
  final IconData icon;

  const StatCard({super.key, required this.value, required this.label, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
      decoration: BoxDecoration(
        color: AppColors.surface(context),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        children: [
          Icon(icon, color: AppColors.primary, size: 20),
          const SizedBox(height: 8),
          Text(value, style: AppTextStyles.h2c(context)),
          const SizedBox(height: 2),
          Text(label, style: AppTextStyles.captionc(context)),
        ],
      ),
    );
  }
}
