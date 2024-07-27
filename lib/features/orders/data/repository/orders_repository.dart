import 'package:hive/hive.dart';
import 'package:shopera/core/constants/strings.dart';
import 'package:shopera/features/orders/data/models/order_model.dart';

abstract class OrdersRepository {
  Future<void> saveOrder(OrderModel order);
  List<OrderModel> getOrders();
}

class OrdersRepositoryImpl implements OrdersRepository {
  late Box<OrderModel> _box;
  OrdersRepositoryImpl() {
    _box = Hive.box(kOrdersBox);
  }

  @override
  List<OrderModel> getOrders() {
    try {
      return _box.values.toList();
    } catch (e) {
      return [];
    }
  }

  @override
  Future<void> saveOrder(OrderModel order) async {
    await _box.put(order.orderNo, order);
  }
}
