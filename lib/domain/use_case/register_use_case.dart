import 'package:dartz/dartz.dart';
import 'package:udemy_flutter_mvvm/data/network/failure.dart';
import 'package:udemy_flutter_mvvm/data/request/request.dart';
import 'package:udemy_flutter_mvvm/domain/model/model.dart';
import 'package:udemy_flutter_mvvm/domain/respository/repository.dart';
import 'package:udemy_flutter_mvvm/domain/use_case/base_use_case.dart';

class RegisterUseCase
    implements BaseUseCase<RegisterUseCaseInput, Authentication> {
  final Repository _repository;
  RegisterUseCase(this._repository);

  @override
  Future<Either<Failure, Authentication>> execute(
    RegisterUseCaseInput input,
  ) async {
    return await _repository.register(RegisterRequest(
      input.countryMobileCode,
      input.name,
      input.email,
      input.password,
      input.profilePicture,
    ));
  }
}

class RegisterUseCaseInput {
  final String mobileNumber;
  final String countryMobileCode;
  final String name;
  final String email;
  final String password;
  final String profilePicture;

  const RegisterUseCaseInput(
    this.mobileNumber,
    this.countryMobileCode,
    this.name,
    this.email,
    this.password,
    this.profilePicture,
  );
}
