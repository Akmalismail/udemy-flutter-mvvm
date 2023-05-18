import 'package:dartz/dartz.dart';
import 'package:udemy_flutter_mvvm/data/data_source/remote_data_source.dart';
import 'package:udemy_flutter_mvvm/data/mapper/mapper.dart';
import 'package:udemy_flutter_mvvm/data/network/failure.dart';
import 'package:udemy_flutter_mvvm/data/network/network_info.dart';
import 'package:udemy_flutter_mvvm/data/request/request.dart';
import 'package:udemy_flutter_mvvm/domain/model.dart';
import 'package:udemy_flutter_mvvm/domain/repository.dart';

class RepositoryImpl extends Repository {
  final RemoteDataSource _remoteDataSource;
  final NetworkInfo _networkInfo;

  RepositoryImpl(this._remoteDataSource, this._networkInfo);

  @override
  Future<Either<Failure, Authentication>> login(
    LoginRequest loginRequest,
  ) async {
    // no network
    if (!await _networkInfo.isConnected) {
      return Left(
        Failure(
          0,
          "Please check your internet connection",
        ),
      );
    }

    // request
    final response = await _remoteDataSource.login(loginRequest);

    // http error
    if (response.status != 200) {
      return Left(
        Failure(
          response.status ?? 0,
          response.message ?? "Backend returned error",
        ),
      );
    }

    // success
    return Right(response.toDomain());
  }
}
