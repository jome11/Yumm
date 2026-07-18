import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:yumm/dummy_data.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(const LoginState()) {
    on<LoginSubmitted>(_onLoginSubmitted);
  }

  Future<void> _onLoginSubmitted(LoginSubmitted event, Emitter<LoginState> emit) async {
    emit(state.copyWith(status: LoginStatus.loading));
    await Future.delayed(const Duration(milliseconds: 900));

    if (event.password.length < 6) {
      emit(state.copyWith(status: LoginStatus.failure, errorMessage: 'Invalid email or password.'));
      return;
    }

    final user = dummyUser;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('is_logged_in', true);

    emit(state.copyWith(status: LoginStatus.success, user: user));
  }
}
