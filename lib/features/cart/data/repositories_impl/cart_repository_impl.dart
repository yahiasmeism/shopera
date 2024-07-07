
import 'package:dartz/dartz.dart';
import 'package:shopera/core/errors/exceptions.dart';
import 'package:shopera/core/errors/failures.dart';
import 'package:shopera/features/cart/data/data_sources/cart_remote_data_source.dart';
import 'package:shopera/features/cart/data/dtos/cart_dto.dart';
import 'package:shopera/features/cart/domin/entities/cart_entity.dart';
import 'package:shopera/features/cart/domin/repositories/cart_repositories.dart';

import '../data_sources/cart_local_data_source.dart';

class CartRepositoryImpl implements CartRepository {
  final CartRemoteDataSource remote;
  final CartLocalDataSource local;

  CartRepositoryImpl({required this.remote, required this.local});

  @override
  Future<Either<Failure, CartEntity>> create(CartDto cart) async {
    try {
      final cartModel = await remote.create(cart);
      return right(cartModel);
    } on ServerException catch (e) {
      return left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, Unit>> delete(int id) async {
    try {
      await remote.delete(id);
      return right(unit);
    } on ServerException catch (e) {
      return left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, CartEntity>> update(int id,CartDto cart) async {
    try {
      final cartModel = await remote.update(id,cart);
      return right(cartModel);
    } on ServerException catch (e) {
      return left(ServerFailure(message: e.message));
    }
  }
}
