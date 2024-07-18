import 'package:shopera/features/home/data/models/category_model.dart';
import 'package:shopera/features/home/data/models/product_model.dart';

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
  Hive.registerAdapter(ProductModelAdapter());
  Hive.registerAdapter(CategoryModelAdapter());

  await Hive.openBox<UserModel>(User_Box);
  await Hive.openBox(APP_BOX);
  await Hive.openBox<ProductModel>(kProductsBox);
  await Hive.openBox<CategoryModel>(kCategoriesBox);
}
