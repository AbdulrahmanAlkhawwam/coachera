import 'package:coachera/features/category/domain/entities/category.dart';

class CategoryModel extends Category {
  CategoryModel({
    required super.id,
    required super.title,
     super.iconName,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
        id: json['id'],
        title: json['name'],
        iconName: json['icon'],
      );
}
