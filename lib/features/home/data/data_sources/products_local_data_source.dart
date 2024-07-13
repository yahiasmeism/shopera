import 'package:hive_flutter/adapters.dart';
import 'package:shopera/core/constants/strings.dart';
import 'package:shopera/features/home/domin/entities/product_entity.dart';

abstract class ProductsLocalDataSource {
  Future<void> saveProducts(List<ProductEntity> products);
  Future<List<ProductEntity>> getProducts(int pageNumber);
}

class ProductsLocalDataSourceImpl implements ProductsLocalDataSource {
  @override
  Future<List<ProductEntity>> getProducts(int pageNumber) async {
    int startIndex = pageNumber * 10;
    int endIndex = (pageNumber + 1) * 10;
    var box = Hive.box<ProductEntity>(kProductsBox);
    int length = box.values.length;
    if (startIndex >= length || endIndex > length) {
      return [];
    }
    return box.values.toList().sublist(startIndex, endIndex);
  }

  @override
  Future<void> saveProducts(List<ProductEntity> products) async {
    final box = Hive.box<ProductEntity>(kProductsBox);
    for (var product in products) {
      await box.put(product.id, product);
    }
  }
}
