
import 'package:shopera/features/cart/data/models/cart_item_model.dart';
import 'package:shopera/features/cart/domin/entities/cart_entity.dart';

class CartModel extends CartEntity {
  const CartModel({
    required super.id,
    required super.items,
    required super.total,
    required super.discountedTotal,
    required super.userId,
    required super.totalProducts,
    required super.totalQuantity,
  });

  factory CartModel.fromJson(Map<String, dynamic> json) {
    // Extract products from json array
    var itemList = json['products'] as List;
    List<CartItemModel> itemsList = itemList
        .map((productJson) => CartItemModel.fromJson(productJson))
        .toList();

    return CartModel(
      id: json['id'],
      items: itemsList,
      total: json['total'].toDouble(),
      discountedTotal: json['discountedTotal'].toDouble(),
      userId: json['userId'],
      totalProducts: json['totalProducts'],
      totalQuantity: json['totalQuantity'],
    );
  }
}
