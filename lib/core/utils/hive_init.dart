import '../constants/strings.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:shopera/features/authentication/data/models/user_model.dart';


Future<void> hiveInit() async {
  await Hive.initFlutter();

  //register your adapter
  // example:
  // Hive.registerAdapter(adapter);
  Hive.registerAdapter(UserModelAdapter());
  Hive.registerAdapter(AddressAdapter());
  Hive.registerAdapter(CoordinatesAdapter());


  await Hive.openBox<UserModel>(User_Box);
  await Hive.openBox(APP_BOX);
}
