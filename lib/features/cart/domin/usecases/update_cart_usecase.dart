import 'package:dartz/dartz.dart';
import 'package:shopera/features/cart/data/dtos/cart_item_dto.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/cart.dart';
import '../repositories/cart_repositories.dart';

class UpdateCartUsecase implements UseCase<Cart, UpdateParam> {
  final CartRepository _repository;

  UpdateCartUsecase({required CartRepository repository}) : _repository = repository;

  @override
  Future<Either<Failure, Cart>> call(UpdateParam params) {
    return _repository.update(params.cartId, params.items);
  }
}

class UpdateParam {
  final int cartId;
  final List<CartItemDto> items;

  UpdateParam({required this.cartId, required this.items});
}
