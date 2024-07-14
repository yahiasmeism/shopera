import 'dart:convert';

import 'package:shopera/features/home/data/models/category_model.dart';
import 'package:shopera/features/home/domin/entities/product_entity.dart';

class ProductModel extends ProductEntity {
  const ProductModel(
      {required super.id,
      required super.title,
      required super.description,
      required super.category,
      required super.price,
      required super.discountPercentage,
      required super.rating,
      required super.tags,
      required super.brand,
      required super.thumbnail,
      required super.images});

  factory ProductModel.fromMap(Map<String, dynamic> data) => ProductModel(
        id: data['id'] as int? ?? 0,
        title: data['title'] as String? ?? '',
        description: data['description'] as String? ?? '',
        category: CategoryModel.fromMap(data),
        price: (data['price'] as num? ?? 0).toDouble(),
        discountPercentage: (data['discountPercentage'] as num? ?? 0).toDouble(),
        rating: (data['rating'] as num? ?? 0).toDouble(),
        tags: data['tags'] as List<String>? ?? [],
        brand: data['brand'] as String? ?? '',
        images: data['images'] as List<String>? ?? [],
        thumbnail: data['thumbnail'] as String? ?? '',
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'title': title,
        'description': description,
        'category': category,
        'price': price,
        'discountPercentage': discountPercentage,
        'rating': rating,
        'tags': tags,
        'brand': brand,
        'images': images,
        'thumbnail': thumbnail,
      };

  factory ProductModel.fromJson(String data) {
    return ProductModel.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  String toJson() => json.encode(toMap());
}
