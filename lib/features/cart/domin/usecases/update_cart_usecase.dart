import 'package:dartz/dartz.dart';
import 'package:shopera/features/cart/data/dtos/cart_item_dto.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/cart_entity.dart';
import '../repositories/cart_repositories.dart';

class UpdateCartUsecase implements UseCase<CartEntity, UpdateParam> {
  final CartRepository _repository;

  UpdateCartUsecase({required CartRepository repository}) : _repository = repository;

  @override
  Future<Either<Failure, CartEntity>> call(UpdateParam params) {
    return _repository.update(params.cartId, params.items);
  }
}

class UpdateParam {
  final int cartId;
  final List<CartItemDto> items;

  UpdateParam({required this.cartId, required this.items});
}
