import '../constants/strings.dart';
import 'package:hive_flutter/adapters.dart';
import '../../features/home/data/models/product_model.dart';
import '../../features/home/data/models/category_model.dart';
import '../../features/favorite/data/models/favorite_model.dart';
import '../../features/authentication/data/models/user_model.dart';


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
    Hive.registerAdapter(FavoriteModelAdapter());
  

  await Hive.openBox<UserModel>(User_Box);
  await Hive.openBox(APP_BOX);
  await Hive.openBox<ProductModel>(kProductsBox);
  await Hive.openBox<CategoryModel>(kCategoriesBox);
  await Hive.openBox<FavoriteModel>(kFavoriteBox);
}
