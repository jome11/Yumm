import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:yumm/viewmodels/splash_cubit.dart';
import 'package:yumm/constants.dart';
import 'package:yumm/views/dashboard_shell.dart';
import 'package:yumm/views/welcome_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SplashCubit()..checkAuthStatus(),
      child: BlocListener<SplashCubit, SplashState>(
        listener: (context, state) {
          if (state.status == SplashStatus.authenticated) {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const DashboardShell()));
          } else if (state.status == SplashStatus.unauthenticated) {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const WelcomeScreen()));
          }
        },
        child: const _SplashBody(),
      ),
    );
  }
}

class _SplashBody extends StatelessWidget {
  const _SplashBody();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(AppAssets.iconTransparent, width: 220, height: 220, fit: BoxFit.contain),
            const SizedBox(height: 8),
            Image.asset(AppAssets.wordmarkTransparent, width: 160, fit: BoxFit.contain),
          ],
        ),
      ),
    );
  }
}
