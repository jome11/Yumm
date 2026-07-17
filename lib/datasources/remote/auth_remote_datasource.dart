import 'package:yumm/models/user_model.dart';

class AuthRemoteDatasource {
  Future<UserModel> login({
    required String email,
    required String password,
  }) async {
    await Future.delayed(const Duration(milliseconds: 900));

    if (email.isEmpty || password.isEmpty) {
      throw Exception('Email and password are required.');
    }
    if (password.length < 6) {
      throw Exception('Invalid email or password.');
    }

    return UserModel(
      id: 'usr_001',
      name: 'Natnael Behaylu',
      email: email,
      role: 'Admin',
      avatarUrl:
          'https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?ixlib=rb-4.0.3&auto=format&fit=crop&w=100&q=80',
    );
  }

  Future<UserModel> signup({
    required String name,
    required String email,
    required String password,
  }) async {
    await Future.delayed(const Duration(milliseconds: 900));

    if (name.isEmpty || email.isEmpty || password.isEmpty) {
      throw Exception('All fields are required.');
    }

    return UserModel(
      id: 'usr_002',
      name: name,
      email: email,
      role: 'Admin',
      avatarUrl:
          'https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?ixlib=rb-4.0.3&auto=format&fit=crop&w=100&q=80',
    );
  }
}
