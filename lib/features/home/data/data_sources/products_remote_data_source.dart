import 'package:dio/dio.dart';
import 'package:shopera/core/api/api_consumer.dart';
import 'package:shopera/core/constants/end_points.dart';
import 'package:shopera/features/home/data/models/category_model.dart';
import 'package:shopera/features/home/domin/entities/category_entity.dart';
import 'package:shopera/features/home/domin/entities/product_entity.dart';
import '../models/product_model.dart';

// Abstract class for product remote data source
abstract class ProductsRemoteDataSource {
  Future<List<ProductEntity>> getProducts({required int pageNumber});
  Future<List<ProductEntity>> getProductsByCategory({required String categoryName, required int pageNumber});
  Future<List<ProductEntity>> searchProducts({required String keyword, required int pageNumber});
  Future<List<CategoryEntity>> getCategories();
}

// Implementation of the product remote data source
class ProductsRemoteDataSourceImpl implements ProductsRemoteDataSource {
  final ApiConsumer api;

  // Constructor with required api parameter
  ProductsRemoteDataSourceImpl({required this.api});

  // Fetch categories from the API
  @override
  Future<List<CategoryEntity>> getCategories() async {
    final Response response = await api.get(CATEGORIES);
    final categoriesList = response.data as List;
    return categoriesList.map((categoryName) => CategoryModel(name: categoryName)).toList();
  }

  // Fetch products from the API with pagination
  @override
  Future<List<ProductEntity>> getProducts({required int pageNumber}) async {
    const int limit = 10;
    final int skip = pageNumber * 10;
    final Response response = await api.get(
      PRODUCTS,
      query: {'limit': limit, 'skip': skip},
    );
    return _processProductsResponse(response);
  }

  // Fetch products by category from the API with pagination
  @override
  Future<List<ProductModel>> getProductsByCategory({required String categoryName, required int pageNumber}) async {
    const int limit = 10;
    final int skip = pageNumber * 10;
    final Response response = await api.get(
      '$PRODUCTS_CATEGORY$categoryName',
      query: {'limit': limit, 'skip': skip},
    );
    return _processProductsResponse(response);
  }

  // Search products by keyword from the API with pagination
  @override
  Future<List<ProductModel>> searchProducts({required String keyword, required int pageNumber}) async {
    const int limit = 10;
    final int skip = pageNumber * 10;
    final Response response = await api.get(
      SEARCH_PRODUCTS,
      query: {'limit': limit, 'skip': skip, 'q': keyword},
    );
    return _processProductsResponse(response);
  }

  // Process product response and map to list of ProductModel
  List<ProductModel> _processProductsResponse(Response response) {
    final List productsResponse = response.data['products'] as List;
    return productsResponse.map((product) => ProductModel.fromMap(product as Map<String, dynamic>)).toList();
  }
}
