import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/category_entity.dart';
import '../entities/product_entity.dart';

abstract interface class HomeRepository {
  Future<Either<Failure, List<ProductEntity>>> getProducts({required int pageNumber});
  Future<Either<Failure, List<ProductEntity>>> getProductsByCategory({required String categoryName, required int pageNumber});
  Future<Either<Failure, List<ProductEntity>>> searchProducts({required String keyword, required int pageNumber});
  Future<Either<Failure, List<CategoryEntity>>> getCategoris();
}
