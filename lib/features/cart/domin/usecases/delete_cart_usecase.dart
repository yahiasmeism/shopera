import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/cart_repositories.dart';

class DeleteCartUsecase implements UseCase<Unit, int> {
  final CartRepository _repository;

  DeleteCartUsecase({required CartRepository repository}) : _repository = repository;
  @override
  Future<Either<Failure, Unit>> call(int params) {
    return _repository.delete(params);
  }
}
