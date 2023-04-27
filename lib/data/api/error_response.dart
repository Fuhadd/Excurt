class ApiErrorResponse {
  final String message;
  final List<String>? errors;
  final Map<String, dynamic>? data;

  const ApiErrorResponse(
      {this.message = "Request failed",
      this.errors = const [],
      this.data = const {}});
}
