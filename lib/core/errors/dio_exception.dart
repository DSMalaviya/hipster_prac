import 'package:dio/dio.dart';

class DioExceptions implements Exception {
  late String message;

  DioExceptions.fromDioError(DioException dioError) {
    switch (dioError.type) {
      case DioExceptionType.cancel:
        message = "Request to API server was cancelled";
        break;
      case DioExceptionType.connectionTimeout:
        message = "Connection timeout with API server";
        break;
      case DioExceptionType.receiveTimeout:
        message = "Receive timeout in connection with API server";
        break;
      case DioExceptionType.badCertificate:
        message = "Bad certificate";
        break;
      case DioExceptionType.connectionError:
        message =
            "Connection Error with server please try again after sometime";
        break;

      case DioExceptionType.sendTimeout:
        message = "Send timeout in connection with API server";
        break;
      case DioExceptionType.badResponse:
        message = _handleError(
          dioError.response?.statusCode,
          dioError.response?.data,
        );
        break;
      case DioExceptionType.unknown:
        message = "Something went wrong";
        break;
    }
  }

  String _handleError(int? statusCode, dynamic response) {
    Map<String, dynamic> error = {};
    if (response is Map<String, dynamic>) {
      error = response;
    }
    switch (statusCode) {
      case 400:
        return error['message'] ?? 'Bad request';
      case 401:
        return "Unauthorized";
      case 403:
        return error['message'] ?? 'Forbidden';
      case 404:
        return error['message'] ?? "Page not found";
      case 500:
        return 'Internal server error';
      case 502:
        return 'Bad gateway';
      default:
        return error['message'] ?? 'Oops something went wrong';
    }
  }

  @override
  String toString() => message;
}

class NetworkException implements Exception {
  @override
  String toString() {
    return "Error while communitcating with server";
  }
}
