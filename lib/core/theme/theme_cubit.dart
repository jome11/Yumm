import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// App-wide dark/light mode toggle, persisted locally. Lives at the
/// top of the widget tree (see main.dart) so both the Settings screen
/// and MaterialApp share the same instance.
class ThemeCubit extends Cubit<ThemeMode> {
  static const _kKey = 'theme_mode_is_dark';

  ThemeCubit() : super(ThemeMode.light) {
    _restore();
  }

  Future<void> _restore() async {
    final prefs = await SharedPreferences.getInstance();
    final isDark = prefs.getBool(_kKey) ?? false;
    emit(isDark ? ThemeMode.dark : ThemeMode.light);
  }

  Future<void> toggle(bool isDark) async {
    emit(isDark ? ThemeMode.dark : ThemeMode.light);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_kKey, isDark);
  }
}
