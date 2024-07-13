import 'package:dartz/dartz.dart';
import 'package:shopera/core/errors/failures.dart';
import 'package:shopera/features/home/domin/entities/product_entity.dart';

abstract interface class HomeRepository {
  Future<Either<Failure, List<ProductEntity>>> getProducts({required int pageNumber});
  Future<Either<Failure, List<ProductEntity>>> getProductsByCategory({required String categoryName, required int pageNumber});
  Future<Either<Failure, List<ProductEntity>>> searchProducts({required String keyword, required int pageNumber});
  Future<Either<Failure, List<ProductEntity>>> getCategoris();
}
