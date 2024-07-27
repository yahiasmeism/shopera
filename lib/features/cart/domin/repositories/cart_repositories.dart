import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../../data/dtos/cart_item_dto.dart';
import '../entities/cart.dart';

abstract interface class CartRepository {
  Future<Either<Failure, Cart>> create(List<CartItemDto> items);
  Future<Either<Failure, Cart>> update(int id, List<CartItemDto> items);
  Future<Either<Failure, Unit>> delete(int id);
}
