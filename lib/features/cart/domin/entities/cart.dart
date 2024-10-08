import 'package:equatable/equatable.dart';

import 'cart_item.dart';


class Cart extends Equatable {
  final int id;
  final List<CartItem> items;
  final double total;
  final double discountedTotal;
  final int userId;
  final int totalProducts;
  final int totalQuantity;

  const Cart({
    required this.id,
    required this.items,
    required this.total,
    required this.discountedTotal,
    required this.userId,
    required this.totalProducts,
    required this.totalQuantity,
  });

  @override
  List<Object> get props {
    return [
      id,
      total,
      discountedTotal,
      userId,
      totalProducts,
      totalQuantity,
    ];
  }

  get merge => null;

  Cart copyWith({
    int? id,
    List<CartItem>? items,
    double? total,
    double? discountedTotal,
    int? userId,
    int? totalProducts,
    int? totalQuantity,
  }) {
    return Cart(
      id: id ?? this.id,
      items: items ?? this.items,
      total: total ?? this.total,
      discountedTotal: discountedTotal ?? this.discountedTotal,
      userId: userId ?? this.userId,
      totalProducts: totalProducts ?? this.totalProducts,
      totalQuantity: totalQuantity ?? this.totalQuantity,
    );
  }

  @override
  String toString() {
    return 'CartEntity(id: $id, items: $items, total: $total, discountedTotal: $discountedTotal, userId: $userId, totalProducts: $totalProducts, totalQuantity: $totalQuantity)\n--------------------------------------------------------------------------------';
  }
}
