
import '../../domin/entities/cart_entity.dart';
import 'cart_item_dto.dart';

class CartDto {
  final int? userId;
  final List<CartItemDto> items;
  CartDto({
    this.userId,
    required this.items,
  });

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'products': items.map((e) => e.toJson()).toList()
    };
  }

  factory CartDto.fromEntity(CartEntity cart) {
    return CartDto(
      userId: cart.userId,
      items: cart.items.map((item) => CartItemDto.fromEntity(item)).toList(),
    );
  }
}
