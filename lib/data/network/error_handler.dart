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
