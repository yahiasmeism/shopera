import 'package:hive_flutter/adapters.dart';
import '../../../../core/constants/strings.dart';
import '../models/category_model.dart';
import '../models/product_model.dart';

import '../../../../core/errors/exceptions.dart';

/// Abstract class defining the methods for local data source of products
abstract class ProductsLocalDataSource {
  Future<void> saveProducts({required List<ProductModel> products});
  Future<List<ProductModel>> getProducts({required int pageNumber});
  Future<void> saveCategories({required List<CategoryModel> categories});
  Future<List<CategoryModel>> getCategories();
  Future<List<ProductModel>> getProductByCategory({required String categoryName, required int pageNumber});
  Future<List<ProductModel>> searchProduct({required String keyword, required int pageNumber});
}

/// Implementation of the local data source for products
class ProductsLocalDataSourceImpl implements ProductsLocalDataSource {
  /// Retrieves a paginated list of products from local storage
  @override
  Future<List<ProductModel>> getProducts({required int pageNumber}) async {
    List<ProductModel> products;
    try {
      var box = Hive.box<ProductModel>(kProductsBox);
      products = await _getPaginatedItems<ProductModel>(box: box, pageNumber: pageNumber, filter: (p) => true);
    } catch (e) {
      products = [];
    }
    if (products.isEmpty) {
      throw EmptyCacheException(EMPTY_CACHE_FAILURE_MESSAGE);
    } else {
      return products;
    }
  }

  /// Saves a list of products to local storage
  @override
  Future<void> saveProducts({required List<ProductModel> products}) async {
    var box = Hive.box<ProductModel>(kProductsBox);
    for (var product in products) {
      if (!box.containsKey(product.id)) {
        await box.put(product.id, product);
      }
    }
  }

  /// Retrieves all categories from local storage
  @override
  Future<List<CategoryModel>> getCategories() async {
    try {
      var box = Hive.box<CategoryModel>(kCategoriesBox);
      return box.values.toList();
    } catch (e) {
      return [];
    }
  }

  /// Saves a list of categories to local storage
  @override
  Future<void> saveCategories({required List<CategoryModel> categories}) async {
    var box = Hive.box<CategoryModel>(kCategoriesBox);
    for (var category in categories) {
      if (!box.containsKey(category.name)) {
        await box.put(category.name, category);
      }
    }
  }

  /// Retrieves a paginated list of products by category from local storage
  @override
  Future<List<ProductModel>> getProductByCategory({required String categoryName, required int pageNumber}) async {
    try {
      var box = Hive.box<ProductModel>(kProductsBox);
      return _getPaginatedItems<ProductModel>(box: box, pageNumber: pageNumber, filter: (p) => p.category.name == categoryName);
    } catch (e) {
      return [];
    }
  }

  /// Searches for products by keyword and retrieves a paginated list from local storage
  @override
  Future<List<ProductModel>> searchProduct({required String keyword, required int pageNumber}) async {
    try {
      var box = Hive.box<ProductModel>(kProductsBox);
      return _getPaginatedItems<ProductModel>(box: box, pageNumber: pageNumber, filter: (p) => p.props.contains(keyword));
    } catch (e) {
      return [];
    }
  }

  /// Retrieves a paginated list of items from the specified Hive box
  Future<List<T>> _getPaginatedItems<T>({
    required Box<T> box,
    required int pageNumber,
    required bool Function(T) filter,
  }) async {
    int startIndex = pageNumber * 10;
    int endIndex = (pageNumber + 1) * 10;
    int length = box.values.length;

    if (startIndex >= length) {
      return [];
    }
    return box.values.where(filter).toList().sublist(startIndex, endIndex > length ? length : endIndex);
  }
}
