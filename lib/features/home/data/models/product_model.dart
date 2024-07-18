// ignore_for_file: annotate_overrides, overridden_fields

import 'dart:convert';
import 'package:hive/hive.dart';
import 'package:shopera/features/home/data/models/category_model.dart';
import 'package:shopera/features/home/domin/entities/product_entity.dart';

import '../../domin/entities/category_entity.dart';
part 'product_model.g.dart';


@HiveType(typeId: 4)
class ProductModel extends ProductEntity {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String title;
  @HiveField(2)
  final String description;
  @HiveField(3)
  final double price;
  @HiveField(4)
  final double discountPercentage;
  @HiveField(5)
  final double rating;
  @HiveField(6)
  final String brand;
  @HiveField(7)
  final CategoryEntity category;
  @HiveField(8)
  final List<String> images;
  @HiveField(9)
  final String thumbnail;

  const ProductModel(
      {required this.id,
      required this.title,
      required this.description,
      required this.category,
      required this.price,
      required this.discountPercentage,
      required this.rating,
      required this.brand,
      required this.thumbnail,
      required this.images})
      : super(
          brand: brand,
          category: category,
          description: description,
          discountPercentage: discountPercentage,
          id: id,
          images: images,
          price: price,
          rating: rating,
          thumbnail: thumbnail,
          title: title,
        );

  factory ProductModel.fromMap(Map<String, dynamic> data) => ProductModel(
        id: data['id'] as int? ?? 0,
        title: data['title'] as String? ?? '',
        description: data['description'] as String? ?? '',
        category: CategoryModel.fromMap(data),
        price: (data['price'] as num? ?? 0).toDouble(),
        discountPercentage: (data['discountPercentage'] as num? ?? 0).toDouble(),
        rating: (data['rating'] as num? ?? 0).toDouble(),
        brand: data['brand'] as String? ?? '',
        images: (data['images'] as List).map((e) => e as String).toList(),
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
        'brand': brand,
        'images': images,
        'thumbnail': thumbnail,
      };

  factory ProductModel.fromJson(String data) {
    return ProductModel.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  String toJson() => json.encode(toMap());
}
