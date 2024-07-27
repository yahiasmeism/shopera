import 'package:hive_flutter/adapters.dart';

import '../../../cart/domin/entities/cart_item.dart';
part 'order_model.g.dart';

@HiveType(typeId: 8)
class OrderModel {
  @HiveField(0)
  final String orderNo;
  @HiveField(1)
  final int selectedItems;
  @HiveField(2)
  final double total;
  @HiveField(3)
  final DateTime createAt;
  @HiveField(4)
  final String status;
  @HiveField(5)
  final List<CartItem> items;

  OrderModel({
    required this.orderNo,
    required this.selectedItems,
    required this.total,
    required this.createAt,
    required this.status,
    required this.items,
  });
}
