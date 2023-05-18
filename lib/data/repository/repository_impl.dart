import 'package:dartz/dartz.dart';
import 'package:udemy_flutter_mvvm/data/data_source/remote_data_source.dart';
import 'package:udemy_flutter_mvvm/data/mapper/mapper.dart';
import 'package:udemy_flutter_mvvm/data/network/error_handler.dart';
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
      return Left(HttpStatus.noInternetConnection.failure);
    }

    try {
      // request
      final response = await _remoteDataSource.login(loginRequest);

      // http error
      if (response.status != ApiInternalStatus.success) {
        return Left(
          Failure(
            response.status ?? ApiInternalStatus.failure,
            response.message ?? HttpStatus.unknown.message,
          ),
        );
      }

      // success
      return Right(response.toDomain());
    } catch (error) {
      return Left(ErrorHandler.handle(error).failure);
    }
  }
}
