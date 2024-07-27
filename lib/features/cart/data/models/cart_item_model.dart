import '../../domin/entities/cart_item.dart';
class CartItemModel extends CartItem {
  const CartItemModel({
    required super.id,
    required super.title,
    required super.price,
    required super.quantity,
    required super.total,
    required super.discountPercentage,
    required super.discountedPrice,
    required super.thumbnail,
  });

  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    return CartItemModel(
      id: json['id'] as int? ?? 0,
      title: json['title'] as String? ?? '',
      price: json['price'].toDouble(),
      quantity: json['quantity'] as int? ?? 0,
      total: json['total'].toDouble(),
      discountPercentage: json['discountPercentage'].toDouble(),
      discountedPrice: json['discountedPrice'] as int? ?? 0,
      thumbnail: json['thumbnail'] as String?,
    );
  }
}
