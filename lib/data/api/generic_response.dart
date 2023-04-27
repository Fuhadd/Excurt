import 'package:dartz/dartz.dart';

import 'api_response.dart';

class GenericResponse<T> {
  final bool success;
  final String message;
  final List<String>? errors;
  late final T? data;

  GenericResponse({
    this.success = false,
    this.message = '',
    this.errors,
    this.data,
  });

  factory GenericResponse.fromJson(
    Either<Failure, Success> response, {
    Function? parseJson,
  }) {
    return response.fold(
      (failure) => GenericResponse(
        errors: failure.error.errors,
        message: failure.error.message,
      ),
      (success) => GenericResponse(
        success: true,
        message: success.data['message'] ?? "",
        data: parseJson != null
            ? parseJson(success.data['data'])
            : success.data['data'] ?? "",
      ),
    );
  }

  static List<String> getErrorMessage(Object? message) {
    if (message is List<String> && message.isNotEmpty) {
      return message;
    }
    if (message is String) return [message];
    return ["Something went wrong, try again!"];
  }
}
