import 'package:hive_flutter/adapters.dart';
import 'package:shopera/core/constants/strings.dart';
import 'package:shopera/features/home/domin/entities/category_entity.dart';
import 'package:shopera/features/home/domin/entities/product_entity.dart';

/// Abstract class defining the methods for local data source of products
abstract class ProductsLocalDataSource {
  Future<void> saveProducts({required List<ProductEntity> products});
  Future<List<ProductEntity>> getProducts({required int pageNumber});
  Future<void> saveCategories({required List<CategoryEntity> categories});
  Future<List<CategoryEntity>> getCategories();
  Future<List<ProductEntity>> getProductByCategory({required String categoryName, required int pageNumber});
  Future<List<ProductEntity>> searchProduct({required String keyword, required int pageNumber});
}

/// Implementation of the local data source for products
class ProductsLocalDataSourceImpl implements ProductsLocalDataSource {
  /// Retrieves a paginated list of products from local storage
  @override
  Future<List<ProductEntity>> getProducts({required int pageNumber}) async {
    try {
      var box = Hive.box<ProductEntity>(kProductsBox);
      return _getPaginatedItems<ProductEntity>(box: box, pageNumber: pageNumber, filter: (p) => true);
    } catch (e) {
      return [];
    }
  }

  /// Saves a list of products to local storage
  @override
  Future<void> saveProducts({required List<ProductEntity> products}) async {
    var box = Hive.box<ProductEntity>(kProductsBox);
    await _saveItems<ProductEntity>(box: box, items: products);
  }

  /// Retrieves all categories from local storage
  @override
  Future<List<CategoryEntity>> getCategories() async {
    try {
      var box = Hive.box<CategoryEntity>(kCategoriesBox);
      return box.values.toList();
    } catch (e) {
      return [];
    }
  }

  /// Saves a list of categories to local storage
  @override
  Future<void> saveCategories({required List<CategoryEntity> categories}) async {
    var box = Hive.box<CategoryEntity>(kCategoriesBox);
    await _saveItems<CategoryEntity>(box: box, items: categories);
  }

  /// Retrieves a paginated list of products by category from local storage
  @override
  Future<List<ProductEntity>> getProductByCategory({required String categoryName, required int pageNumber}) async {
    try {
      var box = Hive.box<ProductEntity>(kProductsBox);
      return _getPaginatedItems<ProductEntity>(box: box, pageNumber: pageNumber, filter: (p) => p.category.name == categoryName);
    } catch (e) {
      return [];
    }
  }

  /// Searches for products by keyword and retrieves a paginated list from local storage
  @override
  Future<List<ProductEntity>> searchProduct({required String keyword, required int pageNumber}) async {
    try {
      var box = Hive.box<ProductEntity>(kProductsBox);
      return _getPaginatedItems<ProductEntity>(box: box, pageNumber: pageNumber, filter: (p) => p.props.contains(keyword));
    } catch (e) {
      return [];
    }
  }

  /// Saves a list of items to the specified Hive box
  Future<void> _saveItems<T>({required Box<T> box, required List<T> items}) async {
    for (var item in items) {
      await box.add(item);
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
