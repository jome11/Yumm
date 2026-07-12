import '../datasources/local/auth_local_datasource.dart';
import '../datasources/remote/auth_remote_datasource.dart';
import '../models/user_model.dart';

class AuthRepository {
  final AuthRemoteDatasource remoteDatasource;
  final AuthLocalDatasource localDatasource;

  AuthRepository({
    required this.remoteDatasource,
    required this.localDatasource,
  });

  Future<UserModel> login({
    required String email,
    required String password,
  }) async {
    final user =
        await remoteDatasource.login(email: email, password: password);
    await localDatasource.saveSession(
      userId: user.id,
      name: user.name,
      email: user.email,
      role: user.role,
      avatarUrl: user.avatarUrl,
    );
    return user;
  }

  Future<UserModel> signup({
    required String name,
    required String email,
    required String password,
  }) async {
    final user = await remoteDatasource.signup(
      name: name,
      email: email,
      password: password,
    );
    await localDatasource.saveSession(
      userId: user.id,
      name: user.name,
      email: user.email,
      role: user.role,
      avatarUrl: user.avatarUrl,
    );
    return user;
  }

  Future<bool> isLoggedIn() => localDatasource.isLoggedIn();

  Future<UserModel?> getCachedUser() async {
    final cached = await localDatasource.getCachedUser();
    if (cached == null) return null;
    return UserModel(
      id: cached['id']!,
      name: cached['name']!,
      email: cached['email']!,
      role: cached['role']!,
      avatarUrl: cached['avatarUrl']!,
    );
  }

  Future<void> logout() => localDatasource.clearSession();
}
