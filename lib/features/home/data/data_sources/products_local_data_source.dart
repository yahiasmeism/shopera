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
  late Box<ProductModel> productBox;
  late Box<CategoryModel> categoryBox;
  ProductsLocalDataSourceImpl() {
    productBox = Hive.box<ProductModel>(kProductsBox);
    categoryBox = Hive.box<CategoryModel>(kCategoriesBox);
  }
  @override
  Future<List<ProductModel>> getProducts({required int pageNumber}) async {
    List<ProductModel> products;
    try {
      products = await _getPaginatedItems<ProductModel>(box: productBox, pageNumber: pageNumber, filter: (p) => true);
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
    for (var product in products) {
      if (!productBox.containsKey(product.id)) {
        await productBox.put(product.id, product);
      }
    }
  }

  /// Retrieves all categories from local storage
  @override
  Future<List<CategoryModel>> getCategories() async {
    try {
    
      return categoryBox.values.toList();
    } catch (e) {
      return [];
    }
  }

  /// Saves a list of categories to local storage
  @override
  Future<void> saveCategories({required List<CategoryModel> categories}) async {
  
    for (var category in categories) {
      if (!categoryBox.containsKey(category.name)) {
        await categoryBox.put(category.name, category);
      }
    }
  }

  /// Retrieves a paginated list of products by category from local storage
  @override
  Future<List<ProductModel>> getProductByCategory({required String categoryName, required int pageNumber}) async {
    try {
      return _getPaginatedItems<ProductModel>(
          box: productBox, pageNumber: pageNumber, filter: (p) => p.category.name == categoryName);
    } catch (e) {
      return [];
    }
  }

  /// Searches for products by keyword and retrieves a paginated list from local storage
  @override
  Future<List<ProductModel>> searchProduct({required String keyword, required int pageNumber}) async {
    try {
      return _getPaginatedItems<ProductModel>(box: productBox, pageNumber: pageNumber, filter: (p) => p.title.contains(keyword));
    } catch (e) {
      return [];
    }
  }

  Future<List<T>> _getPaginatedItems<T>({
    required Box<T> box,
    required int pageNumber,
    required bool Function(T) filter,
  }) async {
    int startIndex = pageNumber * 20;
    int endIndex = (pageNumber + 1) * 20;

    // Apply filter
    List<T> filteredList = box.values.where(filter).toList();
    int length = filteredList.length;

    if (startIndex >= length) {
      return [];
    }

    endIndex = endIndex > length ? length : endIndex;

    // Ensure that startIndex and endIndex are within bounds of filteredList
    startIndex = startIndex < 0 ? 0 : startIndex;
    endIndex = endIndex > length ? length : endIndex;

    return filteredList.sublist(startIndex, endIndex);
  }
}
