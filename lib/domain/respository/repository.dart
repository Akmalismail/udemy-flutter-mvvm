import 'package:dartz/dartz.dart';
import 'package:udemy_flutter_mvvm/data/network/failure.dart';
import 'package:udemy_flutter_mvvm/data/request/request.dart';
import 'package:udemy_flutter_mvvm/domain/model/model.dart';

abstract class Repository {
  Future<Either<Failure, Authentication>> login(LoginRequest loginRequest);
  Future<Either<Failure, String>> resetPassword(
      ResetPasswordRequest resetPasswordRequest);
}
