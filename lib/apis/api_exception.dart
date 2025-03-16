import 'package:dio/dio.dart';

class AppException implements Exception {
  final String errorMessage;

  AppException({
    required this.errorMessage,
  });

  @override
  String toString() {
    return errorMessage;
  }

  factory AppException.fromDioError(DioException dioError) {
    String? err;
    switch (dioError.type) {
      case DioExceptionType.cancel:
        err = 'Cancel request';
        break;
      case DioExceptionType.connectionTimeout:
        err = "Connection timeout";
        break;
      case DioExceptionType.receiveTimeout:
        err = "Receive timeout";
        break;
      case DioExceptionType.sendTimeout:
        err = "Send timeout";
        break;
      case DioExceptionType.badResponse:
        try {
          err = dioError.response?.data;
        } catch (_) {
          err = "Some error occur";
        }
        break;
      case DioExceptionType.unknown:
        if ((dioError.message ?? '').contains('SocketException')) {
          err = "No internet";
          break;
        }
        err = "No data";
        break;
      default:
        err = "No data";
        break;
    }
    return AppException(errorMessage: err ?? '');
  }
}
