import 'package:hive_flutter/adapters.dart';

import '../constants/strings.dart';

Future<void> hiveInit() async {
  await Hive.initFlutter();

  //register your adapter
  // example:
  // Hive.registerAdapter(adapter);

  await Hive.openBox(APP_BOX);
}
