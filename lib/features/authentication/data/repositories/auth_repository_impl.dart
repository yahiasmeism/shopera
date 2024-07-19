import 'package:dartz/dartz.dart';
import '../models/user_model.dart';
import '../../domain/entities/user.dart';
import 'package:shopera/core/errors/failures.dart';
import '../datasources/auth_local_data_source.dart';
import 'package:shopera/core/constants/strings.dart';
import 'package:shopera/core/errors/exceptions.dart';
import '../datasources/auth_remote_data_source.dart';
import 'package:shopera/core/network/network_info.dart';
import '../../domain/repositories/auth_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
        sharedPreferences.setString(K_TOKEN, remoteLogin.token ?? "");
        sharedPreferences.setInt(K_U_ID, remoteLogin.id);

        localDataSource.cacheUser(remoteLogin);
        return Right(remoteLogin);
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message));
      }
    }else {
      return Left(OfflineFailure(message: OFFLINE_FAILURE_MESSAGE));
    }
  }

  @override
  Future<Either<Failure, User>> register(String userName, String email, String password) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteRegister = await remoteDataSource.register(userName, email, password);

        sharedPreferences.setInt(K_U_ID, remoteRegister.id);

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
        final remoteUpdatedUser = await remoteDataSource.updateUser(UserModel.fromEntity(user));

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
  Future<Unit> logout() async {
  
      await localDataSource.clearUserData();
      sharedPreferences.clear;
      return unit;
  }
}
