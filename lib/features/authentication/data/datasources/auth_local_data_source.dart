
import 'package:dartz/dartz.dart';
import 'package:shopera/core/constants/strings.dart';
import 'package:shopera/core/errors/exceptions.dart';
import 'package:shopera/core/local/hive/user_repository.dart';
import 'package:shopera/features/authentication/data/models/user_model.dart';

abstract class AuthLocalDataSource {
  Future<UserModel?> getCachedUser();
  Future<Unit> cacheUser(UserModel userModel);
}

class AuthLocalDataSourceImpl extends AuthLocalDataSource {
  @override
  Future<Unit> cacheUser(UserModel userModel) async {
    await UserRepository().saveUsers(userModel);
    return Future.value(unit);
  }

  @override
  Future<UserModel> getCachedUser() async {
    try {
      return  UserRepository().getUsers()!; 
    } catch (e) {
      throw EmptyCacheException(message: EMPTY_CACHE_FAILURE_MESSAGE);
    }
  }
}
