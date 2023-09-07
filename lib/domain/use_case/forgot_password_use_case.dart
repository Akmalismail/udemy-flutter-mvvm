import 'package:dartz/dartz.dart';
import 'package:udemy_flutter_mvvm/data/network/failure.dart';
import 'package:udemy_flutter_mvvm/data/request/request.dart';
import 'package:udemy_flutter_mvvm/domain/respository/repository.dart';
import 'package:udemy_flutter_mvvm/domain/use_case/base_use_case.dart';

class ForgotPasswordUseCase
    implements BaseUseCase<ForgotPasswordUseCaseInput, String> {
  final Repository _repository;
  ForgotPasswordUseCase(this._repository);

  @override
  Future<Either<Failure, String>> execute(
    ForgotPasswordUseCaseInput input,
  ) async {
    return await _repository.resetPassword(ResetPasswordRequest(
      input.email,
    ));
  }
}

class ForgotPasswordUseCaseInput {
  final String email;

  const ForgotPasswordUseCaseInput(this.email);
}
