import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shopera/features/orders/data/repository/orders_repository.dart';

import '../../data/models/order_model.dart';

part 'orders_state.dart';

class OrdersCubit extends Cubit<OrdersState> {
  final OrdersRepository repository;
  OrdersCubit({required this.repository}) : super(const OrderLoaded());

  createOrder(OrderModel order) async {
    final state = this.state as OrderLoaded;
    emit(state.copyWith(loading: true));
    await Future.delayed(const Duration(seconds: 4));
    await repository.saveOrder(order);
    final orders = List.of(state.orders)..add(order);
    emit(state.copyWith(orders: orders));
  }

  getAllOrder() async {
    final state = this.state as OrderLoaded;
    emit(state.copyWith(loading: true));
    await Future.delayed(const Duration(seconds: 4));
    emit(state.copyWith(orders: repository.getOrders()));
  }
}
