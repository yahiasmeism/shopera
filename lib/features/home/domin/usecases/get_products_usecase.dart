import 'package:dartz/dartz.dart';

import 'package:shopera/core/errors/failures.dart';
import 'package:shopera/core/usecases/usecase.dart';
import 'package:shopera/features/home/domin/entities/product_entity.dart';
import 'package:shopera/features/home/domin/repositories/home_repository.dart';

class GetProductsUsecase implements UseCase<List<ProductEntity>, int> {
 final HomeRepository homeRepository;
  GetProductsUsecase({required this.homeRepository});
  @override
  Future<Either<Failure, List<ProductEntity>>> call([int params = 0]) {
    return homeRepository.getProducts(pageNumber: params);
  }
}
