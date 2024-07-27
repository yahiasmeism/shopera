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

  // Open the boxes if they are not already open
  if (!Hive.isBoxOpen(User_Box)) {
    await Hive.openBox<UserModel>(User_Box);
  }
  if (!Hive.isBoxOpen(kProductsBox)) {
    await Hive.openBox<ProductModel>(kProductsBox);
  }
  if (!Hive.isBoxOpen(kCategoriesBox)) {
    await Hive.openBox<CategoryModel>(kCategoriesBox);
  }
  if (!Hive.isBoxOpen(kOrdersBox)) {
    await Hive.openBox<OrderModel>(kOrdersBox);
  }
  if (!Hive.isBoxOpen(kFavoriteBox)) {
    await Hive.openBox<ProductModel>(kFavoriteBox);
  }
}
