import 'package:shopera/features/home/domin/entities/category_entity.dart';

class CategoryModel extends CategoryEntity {
  CategoryModel({required super.name});

  factory CategoryModel.fromMap(Map<String, dynamic> map) {
    return CategoryModel(
      name: map['category'] as String? ?? '',
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'category': name,
    };
  }
}
