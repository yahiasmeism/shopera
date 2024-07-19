import 'package:dartz/dartz.dart';
import '../../../../core/constants/strings.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/local/hive/user_repository.dart';
import '../models/user_model.dart';

abstract class AuthLocalDataSource {
  Future<UserModel> getCachedUser();
  Future<Unit> cacheUser(UserModel userModel);
  Future<Unit> clearUserData();
}

class AuthLocalDataSourceImpl extends AuthLocalDataSource {
  @override
  Future<Unit> cacheUser(UserModel userModel) async {
    await UserRepository().saveUser(userModel);
    return Future.value(unit);
  }

  @override
  Future<UserModel> getCachedUser() async {
    try {
      return UserRepository().getUser()!;
    } catch (e) {
      throw EmptyCacheException(EMPTY_CACHE_FAILURE_MESSAGE);
    }
  }

  @override
  Future<Unit> clearUserData() async {
    try {
      // Clear the user data from local storage (Hive, SharedPreferences, etc.)
      await UserRepository().clearUser();

      return Future.value(unit);
    } catch (e) {
      throw LogoutException(LOGOUT_FAILURE_MESSAGE);
    }
  }
}
