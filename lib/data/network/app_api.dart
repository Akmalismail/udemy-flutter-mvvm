import 'package:retrofit/http.dart';
import 'package:udemy_flutter_mvvm/app/constants.dart';
import 'package:dio/dio.dart';
import 'package:udemy_flutter_mvvm/data/responses/responses.dart';

part 'app_api.g.dart';

@RestApi(baseUrl: Constancts.baseUrl)
abstract class AppServiceClient {
  factory AppServiceClient(Dio dio, {String baseUrl}) = _AppServiceClient;

  @POST("/customers/login")
  Future<AuthenticationResponse> login();
}
