import 'package:dio/dio.dart';
import 'package:udemy_flutter_mvvm/app/constants.dart';

const String contentType = "Content-Type";
const String accept = "Accept";
const String applicationJson = "application/json";
const String defaultLanguage = "language";
const String xApiKey = "xApiKey";

class DioFactory {
  Future<Dio> getDio() async {
    Dio dio = Dio();
    Duration _timeout = Duration(minutes: 1);

    Map<String, String> headers = {
      contentType: applicationJson,
      accept: applicationJson,
      xApiKey: Constants.apiKey,
      defaultLanguage: "en", // TODO: get language from app prefs.
    };

    dio.options = BaseOptions(
      baseUrl: Constants.baseUrl,
      connectTimeout: _timeout,
      receiveTimeout: _timeout,
      headers: headers,
    );

    return dio;
  }
}
