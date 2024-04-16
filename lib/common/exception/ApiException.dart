class ApiException implements Exception {
  String message;
  final String? errorCode;
  dynamic data;
  ApiException(this.message, {this.errorCode, this.data});

  @override
  String toString() {
    return "ApiException: $message, errorCode: $errorCode";
  }
}
