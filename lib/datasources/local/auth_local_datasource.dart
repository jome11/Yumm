import 'package:shared_preferences/shared_preferences.dart';

class AuthLocalDatasource {
  static const _kIsLoggedIn = 'is_logged_in';
  static const _kUserId = 'user_id';
  static const _kUserName = 'user_name';
  static const _kUserEmail = 'user_email';
  static const _kUserRole = 'user_role';
  static const _kUserAvatar = 'user_avatar';

  Future<void> saveSession({
    required String userId,
    required String name,
    required String email,
    required String role,
    required String avatarUrl,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_kIsLoggedIn, true);
    await prefs.setString(_kUserId, userId);
    await prefs.setString(_kUserName, name);
    await prefs.setString(_kUserEmail, email);
    await prefs.setString(_kUserRole, role);
    await prefs.setString(_kUserAvatar, avatarUrl);
  }

  Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_kIsLoggedIn) ?? false;
  }

  Future<Map<String, String>?> getCachedUser() async {
    final prefs = await SharedPreferences.getInstance();
    final loggedIn = prefs.getBool(_kIsLoggedIn) ?? false;
    if (!loggedIn) return null;
    return {
      'id': prefs.getString(_kUserId) ?? '',
      'name': prefs.getString(_kUserName) ?? '',
      'email': prefs.getString(_kUserEmail) ?? '',
      'role': prefs.getString(_kUserRole) ?? 'Member',
      'avatarUrl': prefs.getString(_kUserAvatar) ?? '',
    };
  }

  Future<void> clearSession() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
