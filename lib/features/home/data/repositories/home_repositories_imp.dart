import 'package:dartz/dartz.dart';
import '../../../../core/errors/exceptions.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/network/network_info.dart';
import '../data_sources/products_local_data_source.dart';
import '../data_sources/products_remote_data_source.dart';
import '../../domin/entities/category_entity.dart';

import '../../domin/entities/product_entity.dart';

import '../../domin/repositories/home_repository.dart';

class HomeRepositoryImpl implements HomeRepository {
  final NetworkInfo networkInfo;
  final ProductsRemoteDataSource remote;
  final ProductsLocalDataSource local;

  HomeRepositoryImpl({required this.remote, required this.local, required this.networkInfo});

  @override
  Future<Either<Failure, List<CategoryEntity>>> getCategoris() async {
    return executeRemoteOrLocal<List<CategoryEntity>>(
      remoteCall: () async {
        final categories = await remote.getCategories();
        await local.saveCategories(categories: categories);
        return categories;
      },
      localCall: () => local.getCategories(),
    );
  }

  @override
  Future<Either<Failure, List<ProductEntity>>> getProducts({required int pageNumber}) {
    return executeRemoteOrLocal(
      remoteCall: () async {
        final products = await remote.getProducts(pageNumber: pageNumber);
        local.saveProducts(products: products);
        return products;
      },
      localCall: () async {
        return await local.getProducts(pageNumber: pageNumber);
      },
    );
  }

  @override
  Future<Either<Failure, List<ProductEntity>>> getProductsByCategory({required String categoryName, required int pageNumber}) {
    return executeRemoteOrLocal(
      remoteCall: () => remote.getProductsByCategory(categoryName: categoryName, pageNumber: pageNumber),
      localCall: () => local.getProductByCategory(categoryName: categoryName, pageNumber: pageNumber),
    );
  }

  @override
  Future<Either<Failure, List<ProductEntity>>> searchProducts({required String keyword, required int pageNumber}) async {
    return executeRemoteOrLocal(
      remoteCall: () => remote.searchProducts(keyword: keyword, pageNumber: pageNumber),
      localCall: () {
        return local.searchProduct(keyword: keyword, pageNumber: pageNumber);
      },
    );
  }

  /// Executes a remote or local call based on network connectivity.
  ///
  /// This function checks the network connection status using [networkInfo].
  /// If connected, it executes the [remoteCall]. Otherwise, it executes the [localCall].
  /// If a [ServerException] occurs during the remote call, it returns a [ServerFailure].
  ///
  /// Parameters:
  /// - [remoteCall]: The function to execute if there is network connectivity.
  /// - [localCall]: The function to execute if there is no network connectivity.
  ///
  /// Returns:
  /// - [Either<Failure, T>]: The result of the remote or local call wrapped in an Either type.
  Future<Either<Failure, T>> executeRemoteOrLocal<T>({
    required Future<T> Function() remoteCall,
    required Future<T> Function() localCall,
  }) async {
    try {
      if (await networkInfo.isConnected) {
        return right(await remoteCall());
      } else {
        return right(await localCall());
      }
    } on ServerException catch (e) {
      return left(ServerFailure(message: e.message));
    } on EmptyCacheException catch (e) {
      return left(EmptyCacheFailure(message: e.message));
    }
  }
}
