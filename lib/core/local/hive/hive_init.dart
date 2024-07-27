import 'package:shopera/features/orders/data/models/order_model.dart';
import 'package:hive_flutter/adapters.dart';
import '../../../features/cart/domin/entities/cart_item.dart';
import '../../../features/home/data/models/product_model.dart';
import '../../../features/home/data/models/category_model.dart';
import '../../../features/authentication/data/models/user_model.dart';
import '../../constants/strings.dart';

Future<void> hiveInit() async {
  await Hive.initFlutter();

  // Register your adapters
  Hive.registerAdapter(UserModelAdapter());
  Hive.registerAdapter(AddressAdapter());
  Hive.registerAdapter(CoordinatesAdapter());
  Hive.registerAdapter(ProductModelAdapter());
  Hive.registerAdapter(CategoryModelAdapter());
  Hive.registerAdapter(OrderModelAdapter());
  Hive.registerAdapter(CartItemAdapter());

    await Hive.openBox<UserModel>(User_Box);
    await Hive.openBox<ProductModel>(kProductsBox);
    await Hive.openBox<CategoryModel>(kCategoriesBox);
    await Hive.openBox<OrderModel>(kOrdersBox);
    await Hive.openBox<ProductModel>(kFavoriteBox);
}
