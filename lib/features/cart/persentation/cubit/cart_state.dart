part of 'cart_cubit.dart';

sealed class CartState extends Equatable {
  const CartState();

  @override
  List<Object?> get props => [];
}

final class CartInitial extends CartState {}

final class CartLoaded extends CartState {
  final Cart cart;

  const CartLoaded({required this.cart});
  CartLoaded copyWith({Cart? cart}) {
    return CartLoaded(cart: cart ?? this.cart);
  }

  @override
  List<Object?> get props => [cart];
}

final class CartFailure extends CartState {
  final String message;

  const CartFailure({required this.message});
}
