import 'package:hive/hive.dart';
import '../../constants/strings.dart';
import '../../../features/authentication/data/models/user_model.dart';

class UserRepository {
  static final UserRepository _instance = UserRepository._internal();
  factory UserRepository() => _instance;
  UserRepository._internal();

  final Box<UserModel> _userBox = Hive.box<UserModel>(User_Box);

  Future<void> saveUser(UserModel user) async {
    await _userBox.put(K_User_Box, user);
  }

  UserModel? getUser() {
    return _userBox.get(K_User_Box);
  }

  Future<void> clearUser() async {
    await _userBox.clear();
  }
}
