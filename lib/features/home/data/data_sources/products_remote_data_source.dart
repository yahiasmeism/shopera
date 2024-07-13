import 'package:shopera/core/api/api_consumer.dart';
import 'package:shopera/core/constants/end_points.dart';

import '../../domin/entities/product_entity.dart';
import '../models/product_model.dart';

abstract class ProductsRemoteDataSource {
  Future<List<ProductModel>> getProducts({required int pageNumber});
  Future<List<ProductModel>> getProductsByCategory({required String categoryName, required int pageNumber});
  Future<List<ProductEntity>> searchProducts({required String keyword, required int pageNumber});
  Future<List<String>> getCategoris();
}

class ProductsRemoteDataSourceImpl implements ProductsRemoteDataSource {
  final ApiConsumer api;

  ProductsRemoteDataSourceImpl({required this.api});
  @override
  Future<List<String>> getCategoris() async {
    return await api.get(CATEGORIES);
  }

  @override
  Future<List<ProductModel>> getProducts({required int pageNumber}) async {
    const limit = 10;
    final skip = pageNumber * limit;
    return await api.get(PRODUCTS, query: {'limit': limit, 'skip': skip});
  }

  @override
  Future<List<ProductModel>> getProductsByCategory({required String categoryName, required int pageNumber}) async {
    const limit = 10;
    final skip = pageNumber * limit;
    return await api.get(
      PRODUCTS_CATEGORY + categoryName,
      query: {'limit': limit, 'skip': skip},
    );
  }

  @override
  Future<List<ProductEntity>> searchProducts({required String keyword, required int pageNumber}) async {
    const limit = 10;
    final skip = pageNumber * limit;
    return await api.get(SEARCH_PRODUCTS, query: {'q': keyword, 'limit': limit, 'skip': skip});
  }
}
