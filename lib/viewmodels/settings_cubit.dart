import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:yumm/dummy_data.dart';
import 'package:yumm/models/user_model.dart';

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

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit() : super(const SettingsState());

  Future<void> loadUser() async {
    emit(state.copyWith(loading: false, user: dummyUser));
  }

  void toggleNotifications(bool value) {
    emit(state.copyWith(notificationsEnabled: value));
  }

  void toggleHealthReports(bool value) {
    emit(state.copyWith(healthReportsEnabled: value));
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('is_logged_in', false);
  }
}
