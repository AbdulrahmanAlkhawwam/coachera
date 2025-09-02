import 'dart:convert';

import '../../../category/data/model/category_model.dart';
import '../../../module/data/model/module_model.dart';
import '../../domain/entities/course.dart';

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

  CourseModel.fromCourse(Course course)
      : super(
    createdAt: course.createdAt,
    updatedAt: course.updatedAt,
    id: course.id,
    title: course.title,
    description: course.description,
    durationHours: course.durationHours,
    price: course.price,
    rating: course.rating,
    orgId: course.orgId,
    categories: course.categories,
    learningPathIds: course.learningPathIds,
    instructors: course.instructors,
    image: course.image,
    modules: course.modules,
  );


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

  Map<String, dynamic> toDatabase() => {
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "id": id,
        "title": title,
        "description": description,
        "durationHours": durationHours,
        "price": price,
        "rating": rating,
        "orgId": orgId,
        // "categories": jsonEncode(categories.map((x) => x.toJson()).toList()),
        // "learningPathIds": jsonEncode(learningPathIds),
        // "instructors": jsonEncode(instructors.map((x) => x.toJson()).toList()),
        "image": image,
        // "modules": jsonEncode(modules.map((x) => x.toJson()).toList()),
      };

  factory CourseModel.fromDatabase(Map<String, dynamic> db) => CourseModel(
        createdAt: DateTime.parse(db["createdAt"]),
        updatedAt: DateTime.parse(db["updatedAt"]),
        id: db["id"],
        title: db["title"],
        description: db["description"],
        durationHours: db["durationHours"],
        price: db["price"]?.toDouble(),
        rating: db["rating"]?.toDouble(),
        orgId: db["orgId"],
        categories: (jsonDecode(db["categories"]) as List)
            .map((x) => CategoryModel.fromJson(x))
            .toList(),
        learningPathIds: List<dynamic>.from(jsonDecode(db["learningPathIds"])),
        // instructors: (jsonDecode(db["instructors"]) as List)
        //     .map((x) => InstructorModel.fromJson(x))
        //     .toList(),
        image: db["image"],
        modules: (jsonDecode(db["modules"]) as List)
            .map((x) => ModuleModel.fromJson(x))
            .toList(),
        instructors: [],
      );
}
