import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:yumm/repositories/auth_repository.dart';
import 'package:yumm/viewmodels/splash_cubit.dart';
import 'package:yumm/constants.dart';
import 'package:yumm/routes.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SplashCubit(authRepository: context.read<AuthRepository>())
        ..checkAuthStatus(),
      child: BlocListener<SplashCubit, SplashState>(
        listener: (context, state) {
          if (state.status == SplashStatus.authenticated) {
            Navigator.pushReplacementNamed(context, AppRoutes.dashboard);
          } else if (state.status == SplashStatus.unauthenticated) {
            Navigator.pushReplacementNamed(context, AppRoutes.welcome);
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
