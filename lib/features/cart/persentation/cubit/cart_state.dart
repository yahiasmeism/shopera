part of 'cart_cubit.dart';

sealed class CartState extends Equatable {
  const CartState();

  @override
  List<Object?> get props => [];
}

final class CartInitial extends CartState {}

final class CartLoaded extends CartState {
  final CartEntity cart;

  const CartLoaded({required this.cart});
  CartLoaded copyWith({CartEntity? cart}) {
    return CartLoaded(cart: cart ?? this.cart);
  }

  @override
  List<Object?> get props => [cart];
}

final class CartFailure extends CartState {
  final String message;
  late final DateTime uniqueKey;
  CartFailure({required this.message}) {
    uniqueKey = DateTime.now();
  }
  CartFailure copyWith({String? message}) {
    return CartFailure(message: message ?? this.message);
  }

  @override
  List<Object?> get props => [message, uniqueKey];
}
