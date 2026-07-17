import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yumm/repositories/auth_repository.dart';

enum SplashStatus { loading, authenticated, unauthenticated }

class SplashState {
  final SplashStatus status;
  const SplashState(this.status);
}

class SplashCubit extends Cubit<SplashState> {
  final AuthRepository authRepository;

  SplashCubit({required this.authRepository})
      : super(const SplashState(SplashStatus.loading));

  Future<void> checkAuthStatus() async {
    await Future.delayed(const Duration(milliseconds: 1200));
    final loggedIn = await authRepository.isLoggedIn();
    emit(SplashState(
      loggedIn ? SplashStatus.authenticated : SplashStatus.unauthenticated,
    ));
  }
}
