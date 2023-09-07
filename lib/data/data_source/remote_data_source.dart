import 'package:udemy_flutter_mvvm/data/network/app_api.dart';
import 'package:udemy_flutter_mvvm/data/request/request.dart';
import 'package:udemy_flutter_mvvm/data/responses/responses.dart';

abstract class RemoteDataSource {
  Future<AuthenticationResponse> login(LoginRequest loginRequest);
  Future<ResetPasswordResponse> resetPassword(
      ResetPasswordRequest resetPasswordRequest);
}

class RemoteDataSourceImplementer implements RemoteDataSource {
  final AppServiceClient _appServiceClient;

  RemoteDataSourceImplementer(this._appServiceClient);

  @override
  Future<AuthenticationResponse> login(LoginRequest loginRequest) async {
    return await _appServiceClient.login(
      loginRequest.email,
      loginRequest.password,
      loginRequest.imei,
      loginRequest.deviceType,
    );
  }

  @override
  Future<ResetPasswordResponse> resetPassword(
      ResetPasswordRequest resetPasswordRequest) async {
    return await _appServiceClient.resetPassword(
      resetPasswordRequest.email,
    );
  }
}
