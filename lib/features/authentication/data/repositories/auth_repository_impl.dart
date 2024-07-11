import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:shopera/core/errors/failures.dart';
import 'package:shopera/core/constants/strings.dart';
import 'package:shopera/core/errors/exceptions.dart';
import 'package:shopera/core/network/network_info.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopera/features/authentication/domain/entities/user.dart';
import 'package:shopera/features/authentication/data/models/user_model.dart';
import 'package:shopera/features/authentication/domain/repositories/auth_repository.dart';
import 'package:shopera/features/authentication/data/datasources/auth_local_data_source.dart';
import 'package:shopera/features/authentication/data/datasources/auth_remote_data_source.dart';

class AuthRepositoryImpl extends AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final AuthLocalDataSource localDataSource;
  final NetworkInfo networkInfo;
  final SharedPreferences sharedPreferences;

  AuthRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
    required this.sharedPreferences,
  });

  @override
  Future<Either<Failure, User>> login(String userName, String password) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteLogin = await remoteDataSource.login(userName, password);
        // todo: cache login
        sharedPreferences
            .setString(K_TOKEN, remoteLogin.token ?? "")
            .then((val) {
          if (val) token = remoteLogin.token;
        });
        sharedPreferences.setInt(K_U_ID, remoteLogin.id).then((val) {
          if (val) uId = remoteLogin.id;
        });

        localDataSource.cacheUser(remoteLogin);
        return Right(remoteLogin);
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message));
      }
    } else {
      try {
        if (kDebugMode) {
          print("NoInternet");
        }
        final localLogin = await localDataSource.getCachedUser();
        return Right(localLogin!);
      } on EmptyCacheException {
        if (kDebugMode) {
          print("EmptyCacheException");
        }
        return Left(
            EmptyLocalStorageFailure(message: EMPTY_CACHE_FAILURE_MESSAGE));
      }
    }
  }

  @override
  Future<Either<Failure, User>> register(
      String userName, String email, String password) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteRegister =
            await remoteDataSource.register(userName, email, password);

        sharedPreferences.setInt(K_U_ID, remoteRegister.id).then((val) {
          if (val) uId = remoteRegister.id;
        });

        // CacheHelper.saveData(key: U_ID, value: remoteRegister.id);
        localDataSource.cacheUser(remoteRegister);
        return Right(remoteRegister);
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message));
      }
    } else {
      return Left(OfflineFailure(message: OFFLINE_FAILURE_MESSAGE));
    }
  }

  @override
  Future<Either<Failure, User>> updateUser(User user) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteUpdatedUser =
            await remoteDataSource.updateUser(UserModel.fromEntity(user));

        localDataSource.cacheUser(remoteUpdatedUser);
        return Right(remoteUpdatedUser);
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message));
      }
    } else {
      return Left(OfflineFailure(message: OFFLINE_FAILURE_MESSAGE));
    }
  }

  @override
  Future<Either<Failure, Unit>> logout() async {
    try {
      await localDataSource.clearUserData();
      sharedPreferences.clear;
      return const Right(unit);
    } on LogoutException catch (e) {
      return Left(LogoutFailure(message: e.message));
    }
  }
}
