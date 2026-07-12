/// Thin exception wrapper so ViewModels can show friendly
/// messages regardless of the underlying data source error.
class AppException implements Exception {
  final String message;
  AppException(this.message);

  @override
  String toString() => message;
}

AppException mapErrorToAppException(Object error) {
  if (error is AppException) return error;
  final msg = error.toString().replaceFirst('Exception: ', '');
  return AppException(msg.isEmpty ? 'Something went wrong. Please try again.' : msg);
}
