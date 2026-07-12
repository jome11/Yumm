import 'package:equatable/equatable.dart';
import '../../../data/models/user_model.dart';

enum SignupStatus { initial, loading, success, failure }

class SignupState extends Equatable {
  final SignupStatus status;
  final UserModel? user;
  final String? errorMessage;

  const SignupState({
    this.status = SignupStatus.initial,
    this.user,
    this.errorMessage,
  });

  SignupState copyWith({
    SignupStatus? status,
    UserModel? user,
    String? errorMessage,
  }) {
    return SignupState(
      status: status ?? this.status,
      user: user ?? this.user,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, user, errorMessage];
}
