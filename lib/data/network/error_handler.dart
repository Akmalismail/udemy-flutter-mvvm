import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:logger/logger.dart';
import 'package:udemy_flutter_mvvm/data/network/failure.dart';
import 'package:udemy_flutter_mvvm/presentation/resources/strings_manager.dart';

enum HttpStatus {
  success,
  noContent,
  badRequest,
  forbidden,
  unauthorized,
  notFound,
  internalServerError,
  unknown,
  connectionTimeout,
  cancel,
  receiveTimeout,
  sendTimeout,
  cacheError,
  noInternetConnection,
  connectionError,
  badCertificate,
}

extension HttpStatusX on HttpStatus {
  Failure get failure {
    int code;
    String message;

    switch (this) {
      case HttpStatus.success:
        code = ResponseCode.success;
        message = ResponseMessage.success.tr();
        break;
      case HttpStatus.noContent:
        code = ResponseCode.noContent;
        message = ResponseMessage.noContent.tr();
        break;
      case HttpStatus.badRequest:
        code = ResponseCode.badRequest;
        message = ResponseMessage.badRequest.tr();
        break;
      case HttpStatus.forbidden:
        code = ResponseCode.forbidden;
        message = ResponseMessage.forbidden.tr();
        break;
      case HttpStatus.unauthorized:
        code = ResponseCode.unauthorized;
        message = ResponseMessage.unauthorised.tr();
        break;
      case HttpStatus.notFound:
        code = ResponseCode.notFound;
        message = ResponseMessage.notFound.tr();
        break;
      case HttpStatus.internalServerError:
        code = ResponseCode.internalServerError;
        message = ResponseMessage.internalServerError.tr();
        break;
      case HttpStatus.unknown:
        code = ResponseCode.unknown;
        message = ResponseMessage.unknown.tr();
        break;
      case HttpStatus.connectionTimeout:
        code = ResponseCode.connectionTimeout;
        message = ResponseMessage.connectTimeout.tr();
        break;
      case HttpStatus.cancel:
        code = ResponseCode.cancel;
        message = ResponseMessage.cancel.tr();
        break;
      case HttpStatus.receiveTimeout:
        code = ResponseCode.receiveTimeout;
        message = ResponseMessage.receiveTimeout.tr();
        break;
      case HttpStatus.sendTimeout:
        code = ResponseCode.sendTimeout;
        message = ResponseMessage.sendTimeout.tr();
        break;
      case HttpStatus.cacheError:
        code = ResponseCode.cacheError;
        message = ResponseMessage.cacheError.tr();
        break;
      case HttpStatus.noInternetConnection:
        code = ResponseCode.noInternetConnection;
        message = ResponseMessage.noInternetError.tr();
        break;
      case HttpStatus.connectionError:
        code = ResponseCode.connectionError;
        message = ResponseMessage.connectionError.tr();
        break;
      case HttpStatus.badCertificate:
        code = ResponseCode.badCertificate;
        message = ResponseMessage.badRequest.tr();
        break;
    }

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
