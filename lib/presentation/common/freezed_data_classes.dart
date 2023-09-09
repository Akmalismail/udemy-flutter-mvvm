import 'package:freezed_annotation/freezed_annotation.dart';

part 'freezed_data_classes.freezed.dart';

@freezed
class LoginFields with _$LoginFields {
  const factory LoginFields({
    required String username,
    required String password,
  }) = _LoginFields;
}

@freezed
class ResetPasswordFields with _$ResetPasswordFields {
  const factory ResetPasswordFields({
    required String email,
  }) = _ResetPasswordFields;
}

@freezed
class RegisterFields with _$RegisterFields {
  const factory RegisterFields({
    required String countryMobileCode,
    required String name,
    required String email,
    required String password,
    required String profilePicture,
  }) = _RegisterFields;
}
