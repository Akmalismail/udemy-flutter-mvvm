import 'package:dio/dio.dart';
import 'package:udemy_flutter_mvvm/data/network/failure.dart';

enum HttpStatus {
  success(
    ResponseCode.success,
    ResponseMessage.success,
  ),
  noContent(
    ResponseCode.noContent,
    ResponseMessage.noContent,
  ),
  badRequest(
    ResponseCode.badRequest,
    ResponseMessage.badRequest,
  ),
  forbidden(
    ResponseCode.forbidden,
    ResponseMessage.forbidden,
  ),
  unauthorized(
    ResponseCode.unauthorized,
    ResponseMessage.unauthorized,
  ),
  notFound(
    ResponseCode.notFound,
    ResponseMessage.notFound,
  ),
  internalServerError(
    ResponseCode.internalServerError,
    ResponseMessage.internalServerError,
  ),
  unknown(
    ResponseCode.unknown,
    ResponseMessage.unknown,
  ),
  connectionTimeout(
    ResponseCode.connectionTimeout,
    ResponseMessage.connectionTimeout,
  ),
  cancel(
    ResponseCode.cancel,
    ResponseMessage.cancel,
  ),
  receiveTimeout(
    ResponseCode.receiveTimeout,
    ResponseMessage.receiveTimeout,
  ),
  sendTimeout(
    ResponseCode.sendTimeout,
    ResponseMessage.sendTimeout,
  ),
  cacheError(
    ResponseCode.cacheError,
    ResponseMessage.cacheError,
  ),
  noInternetConnection(
    ResponseCode.noInternetConnection,
    ResponseMessage.noInternetConnection,
  ),
  connectionError(
    ResponseCode.connectionError,
    ResponseMessage.connectionError,
  ),
  badCertificate(
    ResponseCode.badCertificate,
    ResponseMessage.badCertificate,
  );

  final int code;
  final String message;

  const HttpStatus(this.code, this.message);

  Failure get failure {
    return Failure(
      code,
      message,
    );
  }
}

// enum DataSource {
//   success,
//   noContent,
//   badRequest,
//   forbidden,
//   unauthorized,
//   notFound,
//   internalServerError,
//   unknown,
//   connectTimeout,
//   cancel,
//   receiveTimeout,
//   sendTimeout,
//   cacheError,
//   noInternetConnection,
// }

class ErrorHandler implements Exception {
  late Failure failure;

  ErrorHandler.handle(dynamic error) {
    if (error is DioError) {
      // dio error from api response
      failure = _handleError(error);
    } else {
      // default error
      failure = HttpStatus.unknown.failure;
    }
  }

  Failure _handleError(DioError error) {
    HttpStatus status;
    switch (error.type) {
      case DioErrorType.connectionTimeout:
        status = HttpStatus.connectionTimeout;
        break;
      case DioErrorType.sendTimeout:
        status = HttpStatus.sendTimeout;
        break;
      case DioErrorType.receiveTimeout:
        status = HttpStatus.receiveTimeout;
        break;
      case DioErrorType.badCertificate:
        status = HttpStatus.badCertificate;
        break;
      case DioErrorType.badResponse:
        switch (error.response?.statusCode) {
          case ResponseCode.badRequest:
            status = HttpStatus.badRequest;
            break;
          case ResponseCode.forbidden:
            status = HttpStatus.forbidden;
            break;
          case ResponseCode.unauthorized:
            status = HttpStatus.unauthorized;
            break;
          case ResponseCode.notFound:
            status = HttpStatus.notFound;
            break;
          case ResponseCode.internalServerError:
            status = HttpStatus.internalServerError;
            break;
          default:
            status = HttpStatus.unknown;
        }
        break;
      case DioErrorType.cancel:
        status = HttpStatus.cancel;
        break;
      case DioErrorType.connectionError:
        status = HttpStatus.connectionError;
        break;
      case DioErrorType.unknown:
        status = HttpStatus.unknown;
        break;
    }

    return status.failure;
  }
}

// extension DataSourceExtension on DataSource {
//   Failure getFailure() {
//     switch (this) {
//       case DataSource.badRequest:
//         return Failure(
//           ResponseCode.badRequest,
//           ResponseMessage.badRequest,
//         );
//       case DataSource.forbidden:
//         return Failure(
//           ResponseCode.forbidden,
//           ResponseMessage.forbidden,
//         );
//       case DataSource.unauthorized:
//         return Failure(
//           ResponseCode.unauthorized,
//           ResponseMessage.unauthorized,
//         );
//       case DataSource.notFound:
//         return Failure(
//           ResponseCode.notFound,
//           ResponseMessage.notFound,
//         );
//       case DataSource.internalServerError:
//         return Failure(
//           ResponseCode.internalServerError,
//           ResponseMessage.internalServerError,
//         );
//       case DataSource.connectTimeout:
//         return Failure(
//           ResponseCode.connectionTimeout,
//           ResponseMessage.connectionTimeout,
//         );
//       case DataSource.cancel:
//         return Failure(
//           ResponseCode.cancel,
//           ResponseMessage.cancel,
//         );
//       case DataSource.receiveTimeout:
//         return Failure(
//           ResponseCode.receiveTimeout,
//           ResponseMessage.receiveTimeout,
//         );
//       case DataSource.sendTimeout:
//         return Failure(
//           ResponseCode.sendTimeout,
//           ResponseMessage.sendTimeout,
//         );
//       case DataSource.cacheError:
//         return Failure(
//           ResponseCode.cacheError,
//           ResponseMessage.cacheError,
//         );
//       case DataSource.noInternetConnection:
//         return Failure(
//           ResponseCode.noInternetConnection,
//           ResponseMessage.noInternetConnection,
//         );
//       case DataSource.unknown:
//       default:
//         return Failure(
//           ResponseCode.unknown,
//           ResponseMessage.unknown,
//         );
//     }
//   }
// }

class ResponseCode {
  // http status codes.
  static const int success = 200;
  static const int noContent = 201;
  static const int badRequest = 400;
  static const int forbidden = 403;
  static const int unauthorized = 401;
  static const int notFound = 404;
  static const int internalServerError = 500;

  // local status codes.
  static const int unknown = -1;
  static const int connectionTimeout = -2;
  static const int cancel = -3;
  static const int receiveTimeout = -4;
  static const int sendTimeout = -5;
  static const int cacheError = -6;
  static const int noInternetConnection = -7;
  static const int connectionError = -8;
  static const int badCertificate = -9;
}

class ResponseMessage {
  // http status codes.
  static const String success = 'Success.';
  static const String noContent = 'Success with no content.';
  static const String badRequest = 'Bad request. Please try again later.';
  static const String forbidden = 'Forbidden request.';
  static const String unauthorized = 'User is not authorised.';
  static const String notFound = 'URL not found.';
  static const String internalServerError =
      'Something went wrong server side. Please try again later.';

  // local status codes.
  static const String unknown = 'Something went wrong. Please try again later.';
  static const String connectionTimeout = 'Connection timed out.';
  static const String cancel = 'Request was cancelled.';
  static const String receiveTimeout = 'Request was timed out.';
  static const String sendTimeout = 'Request was timed out.';
  static const String cacheError = 'Cache error. Please try again later.';
  static const String noInternetConnection =
      'Please check your internet connection.';
  static const String connectionError = 'Connection error.';
  static const String badCertificate = 'Bad certificate.';
}
