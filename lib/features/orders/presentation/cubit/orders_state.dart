part of 'orders_cubit.dart';

sealed class OrdersState extends Equatable {
  const OrdersState();

  @override
  List<Object> get props => [];
}

final class OrdersInitial extends OrdersState {}

class OrderLoaded extends OrdersState {
  final List<OrderModel> orders;
  final bool loading;
  const OrderLoaded({
    this.orders = const [],
    this.loading = false,
  });

  @override
  List<Object> get props => [orders, loading];

  OrderLoaded copyWith({List<OrderModel>? orders, bool? loading}) {
    return OrderLoaded(orders: orders ?? this.orders, loading: loading ?? this.loading);
  }
}
