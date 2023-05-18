import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:udemy_flutter_mvvm/app/constants.dart';

const String contentType = "Content-Type";
const String accept = "Accept";
const String applicationJson = "application/json";
const String defaultLanguage = "language";
const String xApiKey = "xApiKey";

class DioFactory {
  Future<Dio> getDio() async {
    Dio dio = Dio();
    Duration timeout = const Duration(minutes: 1);

    Map<String, String> headers = {
      contentType: applicationJson,
      accept: applicationJson,
      xApiKey: Constants.apiKey,
      defaultLanguage: "en", // TODO: get language from app prefs.
    };

    dio.options = BaseOptions(
      baseUrl: Constants.baseUrl,
      connectTimeout: timeout,
      receiveTimeout: timeout,
      headers: headers,
    );

    if (!kReleaseMode) {
      dio.interceptors.add(
        PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
          responseHeader: true,
        ),
      );
    } else {
      print("Release mode. No logs.");
    }

    return dio;
  }
}
