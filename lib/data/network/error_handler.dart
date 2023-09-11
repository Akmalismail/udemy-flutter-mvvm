import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:udemy_flutter_mvvm/data/network/failure.dart';
import 'package:udemy_flutter_mvvm/presentation/resources/strings_manager.dart';

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
    ResponseMessage.unauthorised,
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
    ResponseMessage.connectTimeout,
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
    ResponseMessage.noInternetError,
  ),
  connectionError(
    ResponseCode.connectionError,
    ResponseMessage.connectionError,
  ),
  badCertificate(
    ResponseCode.badCertificate,
    ResponseMessage.badRequest,
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

    if (status == HttpStatus.unknown) {
      Logger().e(error);
    }

    return status.failure;
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
  static const String success = AppStrings.success; // success with data
  static const String noContent =
      AppStrings.noContent; // success with no content
  static const String badRequest =
      AppStrings.badRequestError; // failure, api rejected our request
  static const String forbidden =
      AppStrings.forbiddenError; // failure,  api rejected our request
  static const String unauthorised =
      AppStrings.unauthorizedError; // failure, user is not authorised
  static const String notFound = AppStrings
      .notFoundError; // failure, API url is not correct and not found in api side.
  static const String internalServerError =
      AppStrings.internalServerError; // failure, a crash happened in API side.

  // local responses codes
  static const String unknown =
      AppStrings.defaultError; // unknown error happened
  static const String connectTimeout =
      AppStrings.timeoutError; // issue in connectivity
  static const String cancel =
      AppStrings.defaultError; // API request was cancelled
  static const String receiveTimeout =
      AppStrings.timeoutError; //  issue in connectivity
  static const String sendTimeout =
      AppStrings.timeoutError; //  issue in connectivity
  static const String cacheError = AppStrings
      .defaultError; //  issue in getting data from local data source (cache)
  static const String noInternetError =
      AppStrings.noInternetError; // issue in connectivity
  static const String connectionError =
      AppStrings.connectionError; // issue in connectivity
}

class ApiInternalStatus {
  static const int success = 200;
  static const int failure = -1;
}
