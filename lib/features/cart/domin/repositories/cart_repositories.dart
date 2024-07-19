
import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/cart_entity.dart';

import '../../data/dtos/cart_dto.dart';
abstract interface class CartRepository {
  Future<Either<Failure, CartEntity>> create(CartDto cart);
  Future<Either<Failure, CartEntity>> update(int id,CartDto cart);
  Future<Either<Failure, Unit>> delete(int id);
}
