import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/network/network_exceptions.dart';
import '../../../data/repositories/auth_repository.dart';
import 'signup_event.dart';
import 'signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  final AuthRepository authRepository;

  SignupBloc({required this.authRepository}) : super(const SignupState()) {
    on<SignupSubmitted>(_onSignupSubmitted);
  }

  Future<void> _onSignupSubmitted(
    SignupSubmitted event,
    Emitter<SignupState> emit,
  ) async {
    emit(state.copyWith(status: SignupStatus.loading));
    try {
      final user = await authRepository.signup(
        name: event.name,
        email: event.email,
        password: event.password,
      );
      emit(state.copyWith(status: SignupStatus.success, user: user));
    } catch (e) {
      emit(state.copyWith(
        status: SignupStatus.failure,
        errorMessage: mapErrorToAppException(e).message,
      ));
    }
  }
}
