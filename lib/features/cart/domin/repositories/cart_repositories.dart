
import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../../data/dtos/cart_item_dto.dart';
import '../entities/cart_entity.dart';
abstract interface class CartRepository {
  Future<Either<Failure, CartEntity>> create(List<CartItemDto> items);
  Future<Either<Failure, CartEntity>> update(int id,List<CartItemDto> items);
  Future<Either<Failure, Unit>> delete(int id);
}
