import 'package:dio/dio.dart';

import '../../../../core/api/api_consumer.dart';
import '../dtos/cart_dto.dart';
import '../models/cart_model.dart';

abstract interface class CartRemoteDataSource {
  Future<CartModel> create(CartDto cart);
  Future<CartModel> update(int id, CartDto cart);
  Future<void> delete(int id);
}

class CartRemoteDataSourceImpl implements CartRemoteDataSource {
  final ApiConsumer api;

  CartRemoteDataSourceImpl({required this.api});
  @override
  Future<CartModel> create(CartDto cart) async {
    Response response = await api.post('carts/add', data: cart.toJson());
    return CartModel.fromJson(response.data);
  }

  @override
  Future<void> delete(int id) async {
    await api.delete('carts/1');
  }

  @override
  Future<CartModel> update(int id, CartDto cart) async {
    Response response = await api.put('carts/1', data: cart.toJson());
    return CartModel.fromJson(response.data);
  }
}
