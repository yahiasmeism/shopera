// ignore_for_file: overridden_fields, annotate_overrides

import 'package:hive/hive.dart';
import 'package:shopera/features/home/domin/entities/category_entity.dart';
part 'category_model.g.dart';

@HiveType(typeId: 9)
class CategoryModel extends CategoryEntity {
  @HiveField(0)
  final String name;
  CategoryModel({required this.name}) : super(name: name);

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
