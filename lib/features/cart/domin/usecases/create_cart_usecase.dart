import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../../data/dtos/cart_dto.dart';
import '../entities/cart_entity.dart';
import '../repositories/cart_repositories.dart';

class CreateCartUsecase implements UseCase<CartEntity, CartDto> {
  final CartRepository _repository;

  CreateCartUsecase({required CartRepository repository}) : _repository = repository;
  @override
  Future<Either<Failure, CartEntity>> call(CartDto params) {
    return _repository.create(params);
  }
}
