import 'package:dio/dio.dart';
import '../../../../core/api/api_consumer.dart';
import '../../../../core/constants/end_points.dart';
import '../models/category_model.dart';
import '../models/product_model.dart';

// Abstract class for product remote data source
abstract class ProductsRemoteDataSource {
  Future<List<ProductModel>> getProducts({required int pageNumber});
  Future<List<ProductModel>> getProductsByCategory({required String categoryName, required int pageNumber});
  Future<List<ProductModel>> searchProducts({required String keyword, required int pageNumber});
  Future<List<CategoryModel>> getCategories();
}

// Implementation of the product remote data source
class ProductsRemoteDataSourceImpl implements ProductsRemoteDataSource {
  final ApiConsumer api;

  // Constants for pagination
  static const int _limit = 20;

  // Constructor with required api parameter
  ProductsRemoteDataSourceImpl({required this.api});

  // Fetch categories from the API
  @override
  Future<List<CategoryModel>> getCategories() async {
    final Response response = await api.get(CATEGORY_LIST);
    final categoriesList = response.data as List;
    return categoriesList.map((categoryName) => CategoryModel(name: categoryName)).toList();
  }

  // Fetch products from the API with pagination
  @override
  Future<List<ProductModel>> getProducts({required int pageNumber}) async {
    return _fetchProducts(PRODUCTS, pageNumber);
  }

  // Fetch products by category from the API with pagination
  @override
  Future<List<ProductModel>> getProductsByCategory({required String categoryName, required int pageNumber}) async {
    return _fetchProducts('$PRODUCTS_CATEGORY$categoryName', pageNumber);
  }

  // Search products by keyword from the API with pagination
  @override
  Future<List<ProductModel>> searchProducts({required String keyword, required int pageNumber}) async {
    return _fetchProducts(SEARCH_PRODUCTS, pageNumber, query: {'q': keyword});
  }

  // General method to fetch products from the API with pagination
  Future<List<ProductModel>> _fetchProducts(String url, int pageNumber, {Map<String, dynamic>? query}) async {
    final int skip = pageNumber * _limit;
    final Response response = await api.get(
      url,
      query: {'limit': _limit, 'skip': skip, ...?query},
    );
    return _processProductsResponse(response);
  }

  // Process product response and map to list of ProductModel
  List<ProductModel> _processProductsResponse(Response response) {
    final List productsResponse = response.data['products'] as List;
    return productsResponse.map((product) => ProductModel.fromMap(product as Map<String, dynamic>)).toList();
  }
}
