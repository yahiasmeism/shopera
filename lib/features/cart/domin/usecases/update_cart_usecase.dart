import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../../data/dtos/cart_dto.dart';
import '../entities/cart_entity.dart';
import '../repositories/cart_repositories.dart';

class UpdateCartUsecase implements UseCase<CartEntity, UpdateParam> {
  final CartRepository _repository;

  UpdateCartUsecase({required CartRepository repository}) : _repository = repository;

  @override
  Future<Either<Failure, CartEntity>> call(UpdateParam params) {
    return _repository.update(params.cartId, params.cartDto);
  }
}

class UpdateParam {
  final int cartId;
  final CartDto cartDto;

  UpdateParam({required this.cartId, required this.cartDto});
}
