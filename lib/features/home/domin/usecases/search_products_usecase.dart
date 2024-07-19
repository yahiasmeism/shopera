import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/product_entity.dart';
import '../repositories/home_repository.dart';

import '../../../../core/usecases/usecase.dart';

class SearchProductsUsecase implements UseCase<List<ProductEntity>, SearchParams> {
  final HomeRepository homeRepository;

  SearchProductsUsecase({required this.homeRepository});
  @override
  Future<Either<Failure, List<ProductEntity>>> call(SearchParams params) {
    return homeRepository.searchProducts(keyword: params.keyword, pageNumber: params.pageNumber);
  }
}

class SearchParams {
  final String keyword;
  final int pageNumber;

  SearchParams({required this.keyword, required this.pageNumber});
}
