import 'package:dartz/dartz.dart';
import 'package:shopera/features/cart/data/dtos/cart_item_dto.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/cart.dart';
import '../repositories/cart_repositories.dart';

class CreateCartUsecase implements UseCase<Cart, List<CartItemDto>> {
  final CartRepository _repository;

  CreateCartUsecase({required CartRepository repository}) : _repository = repository;
  @override
  Future<Either<Failure, Cart>> call(List<CartItemDto> params) {
    return _repository.create(params);
  }
}
