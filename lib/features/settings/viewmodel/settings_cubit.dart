import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/models/user_model.dart';
import '../../../data/repositories/auth_repository.dart';

class SettingsState {
  final bool loading;
  final UserModel? user;
  final bool notificationsEnabled;
  final bool healthReportsEnabled;

  const SettingsState({
    this.loading = true,
    this.user,
    this.notificationsEnabled = true,
    this.healthReportsEnabled = false,
  });

  SettingsState copyWith({
    bool? loading,
    UserModel? user,
    bool? notificationsEnabled,
    bool? healthReportsEnabled,
  }) {
    return SettingsState(
      loading: loading ?? this.loading,
      user: user ?? this.user,
      notificationsEnabled: notificationsEnabled ?? this.notificationsEnabled,
      healthReportsEnabled: healthReportsEnabled ?? this.healthReportsEnabled,
    );
  }
}

/// Simple Cubit: settings is a single screen with local toggles,
/// no multi-event flow is needed. Dark mode itself lives in the
/// app-wide ThemeCubit so it can drive MaterialApp directly.
class SettingsCubit extends Cubit<SettingsState> {
  final AuthRepository authRepository;

  SettingsCubit({required this.authRepository}) : super(const SettingsState());

  Future<void> loadUser() async {
    final user = await authRepository.getCachedUser();
    emit(state.copyWith(loading: false, user: user));
  }

  void toggleNotifications(bool value) {
    emit(state.copyWith(notificationsEnabled: value));
  }

  void toggleHealthReports(bool value) {
    emit(state.copyWith(healthReportsEnabled: value));
  }
}
