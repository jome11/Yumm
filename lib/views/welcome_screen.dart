import 'package:flutter/material.dart';
import 'package:yumm/constants.dart';
import 'package:yumm/routes.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Image.asset(AppAssets.iconTransparent, width: 34, height: 34, fit: BoxFit.contain),
                      const SizedBox(width: 8),
                      const Text(
                        AppStrings.appName,
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800, color: Colors.black),
                      ),
                    ],
                  ),
                  OutlinedButton(
                    onPressed: () => Navigator.pushNamed(context, AppRoutes.login),
                    style: OutlinedButton.styleFrom(
                      backgroundColor: AppColors.chrome,
                      foregroundColor: Colors.white,
                      side: BorderSide.none,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    ),
                    child: const Text(AppStrings.login, style: TextStyle(fontWeight: FontWeight.w600)),
                  ),
                ],
              ),
              const SizedBox(height: 28),
              const Text(AppStrings.welcomeHeadline1,
                  style: TextStyle(fontSize: 36, fontWeight: FontWeight.w900, color: Colors.black, height: 1.05)),
              const Text(AppStrings.welcomeHeadline2,
                  style: TextStyle(fontSize: 36, fontWeight: FontWeight.w900, color: Colors.white, height: 1.05)),
              const Text(AppStrings.welcomeHeadline3,
                  style: TextStyle(fontSize: 36, fontWeight: FontWeight.w900, color: Colors.black, height: 1.05)),
              const Text(AppStrings.welcomeHeadline4,
                  style: TextStyle(fontSize: 36, fontWeight: FontWeight.w900, color: Colors.black, height: 1.05)),
              const SizedBox(height: 14),
              const Text(
                AppStrings.welcomeSubtitle,
                style: TextStyle(fontSize: 14, color: Colors.black87, height: 1.35),
              ),
              const SizedBox(height: 28),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: AppColors.chrome,
                  borderRadius: BorderRadius.circular(28),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      AppStrings.welcomeCtaTitle,
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800, color: Colors.white, height: 1.2),
                    ),
                    const SizedBox(height: 14),
                    const Text(
                      AppStrings.welcomeCtaSubtitle,
                      style: TextStyle(fontSize: 13, color: Colors.white60, height: 1.4),
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () => Navigator.pushNamed(context, AppRoutes.signup),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          minimumSize: const Size.fromHeight(52),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(26)),
                        ),
                        child: const Text(AppStrings.getStartedNow,
                            style: TextStyle(fontWeight: FontWeight.w700, color: Colors.white)),
                      ),
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton(
                        onPressed: () {},
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.white,
                          minimumSize: const Size.fromHeight(52),
                          side: const BorderSide(color: Colors.white24),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(26)),
                        ),
                        child: const Text(AppStrings.contactSales, style: TextStyle(fontWeight: FontWeight.w600)),
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              const Text(AppStrings.appName,
                  style: TextStyle(fontWeight: FontWeight.w800, color: Colors.black)),
              const SizedBox(height: 4),
              const Text('© 2026 YUMM. ALL RIGHTS RESERVED.',
                  style: TextStyle(fontSize: 10, color: Colors.black45)),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
