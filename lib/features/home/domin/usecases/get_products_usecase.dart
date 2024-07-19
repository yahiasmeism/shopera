import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/product_entity.dart';
import '../repositories/home_repository.dart';

class GetProductsUsecase implements UseCase<List<ProductEntity>, int> {
 final HomeRepository homeRepository;
  GetProductsUsecase({required this.homeRepository});
  @override
  Future<Either<Failure, List<ProductEntity>>> call([int params = 0]) {
    return homeRepository.getProducts(pageNumber: params);
  }
}
