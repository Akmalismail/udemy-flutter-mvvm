import 'package:dartz/dartz.dart';
import 'package:udemy_flutter_mvvm/data/network/failure.dart';
import 'package:udemy_flutter_mvvm/domain/model/model.dart';
import 'package:udemy_flutter_mvvm/domain/respository/repository.dart';
import 'package:udemy_flutter_mvvm/domain/use_case/base_use_case.dart';

class HomeUseCase extends BaseUseCase<void, Home> {
  final Repository _repository;
  HomeUseCase(this._repository);

  @override
  Future<Either<Failure, Home>> execute(void input) async {
    return await _repository.getHome();
  }
}
