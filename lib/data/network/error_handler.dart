import 'package:udemy_flutter_mvvm/data/network/failure.dart';

enum HttpStatus {
  success(
    200,
    "Success",
  ),
  noContent(
    201,
    'Success with no content.',
  ),
  badRequest(
    400,
    'Bad request. Please try again later.',
  ),
  forbidden(
    403,
    'Forbidden request.',
  ),
  unauthorized(
    401,
    'User is not authorised.',
  ),
  notFound(
    404,
    'URL not found.',
  ),
  internalServerError(
    500,
    'Something went wrong server side. Please try again later.',
  ),
  unknown(
    -1,
    'Something went wrong. Please try again later.',
  ),
  connectTimeout(
    -2,
    'Connection timed out.',
  ),
  cancel(
    -3,
    'Request was cancelled.',
  ),
  receiveTimeout(
    -4,
    'Request was timed out.',
  ),
  sendTimeout(
    -5,
    'Request was timed out.',
  ),
  cacheError(
    -6,
    'Cache error. Please try again later.',
  ),
  noInternetConnection(
    -7,
    'Please check your internet connection.',
  );

  final int code;
  final String message;

  const HttpStatus(this.code, this.message);
}

enum DataSource {
  success,
  noContent,
  badRequest,
  forbidden,
  unauthorized,
  notFound,
  internalServerError,
  connectTimeout,
  cancel,
  receiveTimeout,
  sendTimeout,
  cacheError,
  noInternetConnection,
}

extension DataSourceExtension on DataSource {
  Failure getFailure() {
    switch (this) {
      case DataSource.badRequest:
        return Failure(
          ResponseCode.badRequest,
          ResponseMessage.badRequest,
        );
      case DataSource.forbidden:
        return Failure(
          ResponseCode.forbidden,
          ResponseMessage.forbidden,
        );
      case DataSource.unauthorized:
        return Failure(
          ResponseCode.unauthorized,
          ResponseMessage.unauthorized,
        );
      case DataSource.notFound:
        return Failure(
          ResponseCode.notFound,
          ResponseMessage.notFound,
        );
      case DataSource.internalServerError:
        return Failure(
          ResponseCode.internalServerError,
          ResponseMessage.internalServerError,
        );

      case DataSource.connectTimeout:
        return Failure(
          ResponseCode.connectTimeout,
          ResponseMessage.connectTimeout,
        );
      case DataSource.cancel:
        return Failure(
          ResponseCode.cancel,
          ResponseMessage.cancel,
        );
      case DataSource.receiveTimeout:
        return Failure(
          ResponseCode.receiveTimeout,
          ResponseMessage.receiveTimeout,
        );
      case DataSource.sendTimeout:
        return Failure(
          ResponseCode.sendTimeout,
          ResponseMessage.sendTimeout,
        );
      case DataSource.cacheError:
        return Failure(
          ResponseCode.cacheError,
          ResponseMessage.cacheError,
        );
      case DataSource.noInternetConnection:
        return Failure(
          ResponseCode.noInternetConnection,
          ResponseMessage.noInternetConnection,
        );
      default:
        return Failure(
          ResponseCode.unknown,
          ResponseMessage.unknown,
        );
    }
  }
}

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
  static const int connectTimeout = -2;
  static const int cancel = -3;
  static const int receiveTimeout = -4;
  static const int sendTimeout = -5;
  static const int cacheError = -6;
  static const int noInternetConnection = -7;
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
  static const String connectTimeout = 'Connection timed out.';
  static const String cancel = 'Request was cancelled.';
  static const String receiveTimeout = 'Request was timed out.';
  static const String sendTimeout = 'Request was timed out.';
  static const String cacheError = 'Cache error. Please try again later.';
  static const String noInternetConnection =
      'Please check your internet connection.';
}
