import 'package:equatable/equatable.dart';

import '../../domin/entities/cart_item.dart';


class CartItemDto extends Equatable {
  final int? id;
  final int quantity;

  const CartItemDto({required this.id, required this.quantity});

  @override
  List<Object?> get props => [id, quantity];

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'quantity': quantity,
    };
  }

  factory CartItemDto.fromEntity(CartItem cartItem) {
    return CartItemDto(
      id: cartItem.id,
      quantity: cartItem.quantity,
    );
  }
}
