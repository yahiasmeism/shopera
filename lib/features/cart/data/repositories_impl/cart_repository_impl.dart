import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopera/core/constants/strings.dart';
import 'package:shopera/features/cart/data/dtos/cart_item_dto.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failures.dart';
import '../data_sources/cart_remote_data_source.dart';
import '../dtos/cart_dto.dart';
import '../../domin/entities/cart_entity.dart';
import '../../domin/repositories/cart_repositories.dart';

import '../data_sources/cart_local_data_source.dart';

class CartRepositoryImpl implements CartRepository {
  final CartRemoteDataSource remote;
  final CartLocalDataSource local;
  final SharedPreferences sharedPreferences;
  CartRepositoryImpl({required this.sharedPreferences, required this.remote, required this.local});
  int? get userID {
    if (sharedPreferences.containsKey(K_U_ID)) {
      return sharedPreferences.getInt(K_U_ID);
    }
    return null;
  }

  @override
  Future<Either<Failure, CartEntity>> create(List<CartItemDto> items) async {
    try {
      final cartModel = await remote.create(CartDto(items: items, userId: userID));
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
  Future<Either<Failure, CartEntity>> update(int id, List<CartItemDto> items) async {
    try {
      final cartModel = await remote.update(id, CartDto(items: items, userId: userID));
      return right(cartModel);
    } on ServerException catch (e) {
      return left(ServerFailure(message: e.message));
    }
  }
}
