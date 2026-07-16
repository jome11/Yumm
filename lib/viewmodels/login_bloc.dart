import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:yumm/repositories/auth_repository.dart';
import 'login_event.dart';
import 'login_state.dart';
import 'package:yumm/viewmodels/app_exception.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepository authRepository;

  LoginBloc({required this.authRepository}) : super(const LoginState()) {
    on<LoginSubmitted>(_onLoginSubmitted);
  }

  Future<void> _onLoginSubmitted(
    LoginSubmitted event,
    Emitter<LoginState> emit,
  ) async {
    emit(state.copyWith(status: LoginStatus.loading));
    try {
      final user = await authRepository.login(
        email: event.email,
        password: event.password,
      );
      emit(state.copyWith(status: LoginStatus.success, user: user));
    } catch (e) {
      emit(state.copyWith(
        status: LoginStatus.failure,
        errorMessage: mapErrorToAppException(e).message,
      ));
    }
  }
}
