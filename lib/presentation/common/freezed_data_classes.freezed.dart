// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'freezed_data_classes.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$LoginFields {
  String get username => throw _privateConstructorUsedError;
  String get password => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $LoginFieldsCopyWith<LoginFields> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LoginFieldsCopyWith<$Res> {
  factory $LoginFieldsCopyWith(
          LoginFields value, $Res Function(LoginFields) then) =
      _$LoginFieldsCopyWithImpl<$Res, LoginFields>;
  @useResult
  $Res call({String username, String password});
}

/// @nodoc
class _$LoginFieldsCopyWithImpl<$Res, $Val extends LoginFields>
    implements $LoginFieldsCopyWith<$Res> {
  _$LoginFieldsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? username = null,
    Object? password = null,
  }) {
    return _then(_value.copyWith(
      username: null == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String,
      password: null == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_LoginFieldsCopyWith<$Res>
    implements $LoginFieldsCopyWith<$Res> {
  factory _$$_LoginFieldsCopyWith(
          _$_LoginFields value, $Res Function(_$_LoginFields) then) =
      __$$_LoginFieldsCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String username, String password});
}

/// @nodoc
class __$$_LoginFieldsCopyWithImpl<$Res>
    extends _$LoginFieldsCopyWithImpl<$Res, _$_LoginFields>
    implements _$$_LoginFieldsCopyWith<$Res> {
  __$$_LoginFieldsCopyWithImpl(
      _$_LoginFields _value, $Res Function(_$_LoginFields) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? username = null,
    Object? password = null,
  }) {
    return _then(_$_LoginFields(
      username: null == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String,
      password: null == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_LoginFields implements _LoginFields {
  const _$_LoginFields({required this.username, required this.password});

  @override
  final String username;
  @override
  final String password;

  @override
  String toString() {
    return 'LoginFields(username: $username, password: $password)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_LoginFields &&
            (identical(other.username, username) ||
                other.username == username) &&
            (identical(other.password, password) ||
                other.password == password));
  }

  @override
  int get hashCode => Object.hash(runtimeType, username, password);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_LoginFieldsCopyWith<_$_LoginFields> get copyWith =>
      __$$_LoginFieldsCopyWithImpl<_$_LoginFields>(this, _$identity);
}

abstract class _LoginFields implements LoginFields {
  const factory _LoginFields(
      {required final String username,
      required final String password}) = _$_LoginFields;

  @override
  String get username;
  @override
  String get password;
  @override
  @JsonKey(ignore: true)
  _$$_LoginFieldsCopyWith<_$_LoginFields> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$ResetPasswordFields {
  String get email => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ResetPasswordFieldsCopyWith<ResetPasswordFields> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ResetPasswordFieldsCopyWith<$Res> {
  factory $ResetPasswordFieldsCopyWith(
          ResetPasswordFields value, $Res Function(ResetPasswordFields) then) =
      _$ResetPasswordFieldsCopyWithImpl<$Res, ResetPasswordFields>;
  @useResult
  $Res call({String email});
}

/// @nodoc
class _$ResetPasswordFieldsCopyWithImpl<$Res, $Val extends ResetPasswordFields>
    implements $ResetPasswordFieldsCopyWith<$Res> {
  _$ResetPasswordFieldsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? email = null,
  }) {
    return _then(_value.copyWith(
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ResetPasswordFieldsCopyWith<$Res>
    implements $ResetPasswordFieldsCopyWith<$Res> {
  factory _$$_ResetPasswordFieldsCopyWith(_$_ResetPasswordFields value,
          $Res Function(_$_ResetPasswordFields) then) =
      __$$_ResetPasswordFieldsCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String email});
}

/// @nodoc
class __$$_ResetPasswordFieldsCopyWithImpl<$Res>
    extends _$ResetPasswordFieldsCopyWithImpl<$Res, _$_ResetPasswordFields>
    implements _$$_ResetPasswordFieldsCopyWith<$Res> {
  __$$_ResetPasswordFieldsCopyWithImpl(_$_ResetPasswordFields _value,
      $Res Function(_$_ResetPasswordFields) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? email = null,
  }) {
    return _then(_$_ResetPasswordFields(
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_ResetPasswordFields implements _ResetPasswordFields {
  const _$_ResetPasswordFields({required this.email});

  @override
  final String email;

  @override
  String toString() {
    return 'ResetPasswordFields(email: $email)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ResetPasswordFields &&
            (identical(other.email, email) || other.email == email));
  }

  @override
  int get hashCode => Object.hash(runtimeType, email);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ResetPasswordFieldsCopyWith<_$_ResetPasswordFields> get copyWith =>
      __$$_ResetPasswordFieldsCopyWithImpl<_$_ResetPasswordFields>(
          this, _$identity);
}

abstract class _ResetPasswordFields implements ResetPasswordFields {
  const factory _ResetPasswordFields({required final String email}) =
      _$_ResetPasswordFields;

  @override
  String get email;
  @override
  @JsonKey(ignore: true)
  _$$_ResetPasswordFieldsCopyWith<_$_ResetPasswordFields> get copyWith =>
      throw _privateConstructorUsedError;
}
