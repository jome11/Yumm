/// Placeholder endpoint constants for when the mock datasources
/// are swapped for a real backend (e.g. via Dio/http).
class ApiEndpoints {
  ApiEndpoints._();

  static const baseUrl = 'https://api.yumm-hive.example.com';
  static const login = '/auth/login';
  static const signup = '/auth/signup';
  static const overviewStats = '/dashboard/overview';
  static const hives = '/hives';
  static const insights = '/dashboard/insights';
  static const analyticsYield = '/analytics/yield';
  static const recommendations = '/recommendations';
}
