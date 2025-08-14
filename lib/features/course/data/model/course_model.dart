import 'package:coachera/features/course/data/model/module_model.dart';

import '../../../category/data/model/category_model.dart';
import '../../../category/domain/entities/category.dart';
import '../../domain/entities/course.dart';
import '../../domain/entities/module.dart';

class CourseModel extends Course {
  CourseModel({
    required super.createdAt,
    required super.updatedAt,
    required super.id,
    required super.title,
    required super.description,
    required super.durationHours,
    required super.price,
    required super.rating,
    required super.orgId,
    required super.categories,
    required super.learningPathIds,
    required super.instructors,
    required super.image,
    required super.modules,
  });

  factory CourseModel.fromJson(Map<String, dynamic> json) => CourseModel(
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        id: json["id"],
        title: json["title"],
        description: json["description"],
        durationHours: json["durationHours"],
        price: json["price"]?.toDouble(),
        rating: json["rating"]?.toDouble(),
        orgId: json["orgId"],
        categories: List<CategoryModel>.from(
            json["categories"].map((x) => CategoryModel.fromJson(x))),
        learningPathIds:
            List<dynamic>.from(json["learningPathIds"].map((x) => x)),
        instructors: List<dynamic>.from(json["instructors"].map((x) => x)),
        image: json["image"],
        modules: List<ModuleModel>.from(
            json["modules"] ?? [].map((x) => ModuleModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "id": id,
        "title": title,
        "description": description,
        "durationHours": durationHours,
        "price": price,
        "rating": rating,
        "orgId": orgId,
        "categories": List<dynamic>.from(categories.map((x) => x)),
        "learningPathIds": List<dynamic>.from(learningPathIds.map((x) => x)),
        "instructors": List<dynamic>.from(instructors.map((x) => x)),
        "image": image,
        "modules": List<ModuleModel>.from(modules.map((x) => x.toJson())),
      };
}
