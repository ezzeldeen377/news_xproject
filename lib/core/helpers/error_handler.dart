class ApiException implements Exception {
  final String message;
  final int? statusCode;

  ApiException(this.message, {this.statusCode});

  @override
  String toString() => 'ApiException: $message${statusCode != null ? ' (Status code: $statusCode)' : ''}';
}

class NetworkException extends ApiException {
  NetworkException([super.message = 'Network connection failed']);
}

class ServerException extends ApiException {
  ServerException(super.message, {super.statusCode});
}

class ClientException extends ApiException {
  ClientException(super.message, {super.statusCode});
}

class ParseException extends ApiException {
  ParseException([super.message = 'Failed to parse response']);
}

class AuthException extends ClientException {
  AuthException([super.message = 'Authentication failed'])
      : super(statusCode: 401);
}

class NotFoundException extends ClientException {
  NotFoundException([super.message = 'Resource not found'])
      : super(statusCode: 404);
}

/// Helper class to handle API exceptions
class ErrorHandler {
  /// Handles HTTP response status codes and throws appropriate exceptions
  static void handleStatusCode(int statusCode, String message) {
    if (statusCode >= 500) {
      throw ServerException(message, statusCode: statusCode);
    } else if (statusCode == 401 || statusCode == 403) {
      throw AuthException(message);
    } else if (statusCode == 404) {
      throw NotFoundException(message);
    } else if (statusCode >= 400 && statusCode < 500) {
      throw ClientException(message, statusCode: statusCode);
    }
  }

  /// Handles exceptions and returns appropriate error messages
  static String getErrorMessage(Exception exception) {
    if (exception is NetworkException) {
      return 'Please check your internet connection and try again.';
    } else if (exception is AuthException) {
      return 'Authentication failed. Please check your API key.';
    } else if (exception is NotFoundException) {
      return 'The requested resource was not found.';
    } else if (exception is ServerException) {
      return 'Server error occurred. Please try again later.';
    } else if (exception is ClientException) {
      return 'Request error: ${exception.message}';
    } else if (exception is ParseException) {
      return 'Failed to process the response data.';
    } else {
      return 'An unexpected error occurred: ${exception.toString()}';
    }
  }
}