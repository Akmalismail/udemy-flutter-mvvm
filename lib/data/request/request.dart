class LoginRequest {
  String email;
  String password;
  String imei;
  String deviceType;

  LoginRequest(
    this.email,
    this.password,
    this.imei,
    this.deviceType,
  );
}

class ResetPasswordRequest {
  String email;

  ResetPasswordRequest(
    this.email,
  );
}
