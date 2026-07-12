/// Minimal placeholder for a real HTTP client (Dio/http package).
/// Swap this in when the mock datasources are replaced with
/// actual network calls. Kept intentionally small so it doesn't
/// pull in extra dependencies while the backend is mocked.
class ApiClient {
  final String baseUrl;

  ApiClient({required this.baseUrl});

  // Example shape for future real implementation:
  //
  // Future<Map<String, dynamic>> get(String path) async {
  //   final res = await _dio.get('$baseUrl$path');
  //   return res.data as Map<String, dynamic>;
  // }
}
