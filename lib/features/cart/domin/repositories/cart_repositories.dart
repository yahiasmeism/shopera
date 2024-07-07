
import 'package:dartz/dartz.dart';
import 'package:shopera/core/errors/failures.dart';
import 'package:shopera/features/cart/domin/entities/cart_entity.dart';

import '../../data/dtos/cart_dto.dart';
abstract interface class CartRepository {
  Future<Either<Failure, CartEntity>> create(CartDto cart);
  Future<Either<Failure, CartEntity>> update(int id,CartDto cart);
  Future<Either<Failure, Unit>> delete(int id);
}
