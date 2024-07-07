import '../dtos/cart_dto.dart';
import '../models/cart_model.dart';

abstract interface class CartLocalDataSource {
  Future<CartModel> create(CartDto cart);
  Future<CartModel> update(CartDto cart);
  Future<void> delete(int id);
}

class CartLocalDataSourceImpl extends CartLocalDataSource {
  @override
  Future<CartModel> create(CartDto cart) {
    // TODO: implement create
    throw UnimplementedError();
  }

  @override
  Future<void> delete(int id) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<CartModel> update(CartDto cart) {
    // TODO: implement update
    throw UnimplementedError();
  }
}
