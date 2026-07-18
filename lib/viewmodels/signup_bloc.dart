import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:yumm/dummy_data.dart';
import 'signup_event.dart';
import 'signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  SignupBloc() : super(const SignupState()) {
    on<SignupSubmitted>(_onSignupSubmitted);
  }

  Future<void> _onSignupSubmitted(SignupSubmitted event, Emitter<SignupState> emit) async {
    emit(state.copyWith(status: SignupStatus.loading));
    await Future.delayed(const Duration(milliseconds: 900));

    final user = dummyUser;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('is_logged_in', true);

    emit(state.copyWith(status: SignupStatus.success, user: user));
  }
}
