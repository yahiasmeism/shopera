import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/product_entity.dart';
import '../repositories/home_repository.dart';

import '../../../../core/usecases/usecase.dart';

class GetProductsByCategoryUsecase implements UseCase<List<ProductEntity>, ProductsByCategoryParams> {
 final HomeRepository homeRepository;
  GetProductsByCategoryUsecase({required this.homeRepository});

  @override
  Future<Either<Failure, List<ProductEntity>>> call(ProductsByCategoryParams params) {
    return homeRepository.getProductsByCategory(
      categoryName: params.categoryName,
      pageNumber: params.pageNumber,
    );
  }
}

class ProductsByCategoryParams {
  final String categoryName;
  final int pageNumber;

  ProductsByCategoryParams({
    required this.categoryName,
    required this.pageNumber,
  });
}
