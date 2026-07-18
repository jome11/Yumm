import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum SplashStatus { loading, authenticated, unauthenticated }

class SplashState {
  final SplashStatus status;
  const SplashState(this.status);
}

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(const SplashState(SplashStatus.loading));

  Future<void> checkAuthStatus() async {
    await Future.delayed(const Duration(milliseconds: 1200));
    final prefs = await SharedPreferences.getInstance();
    final loggedIn = prefs.getBool('is_logged_in') ?? false;
    emit(SplashState(
      loggedIn ? SplashStatus.authenticated : SplashStatus.unauthenticated,
    ));
  }
}
