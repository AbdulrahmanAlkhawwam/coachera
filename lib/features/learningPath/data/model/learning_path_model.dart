import '../../domain/entities/learning_path.dart';

class LearningPathModel extends LearningPath {
  LearningPathModel({
    required super.createdAt,
    required super.updatedAt,
    required super.id,
    required super.orgId,
    required super.title,
    required super.description,
    required super.imageUrl,
    required super.courses,
  });

  factory LearningPathModel.fromJson(Map<String, dynamic> json) =>
      LearningPathModel(
          createdAt: DateTime.parse(json["createdAt"]),
          updatedAt: DateTime.parse(json["updatedAt"]),
          id: json["id"],
          orgId: json["orgId"],
          title: json["title"],
          description: json["description"],
          imageUrl: json["imageUrl"],
          courses: []
          // List<CourseModel>.from(json["courses"].map((x) => CourseModel.fromJson(x))),
          );

  Map<String, dynamic> toJson() => {
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "id": id,
        "orgId": orgId,
        "title": title,
        "description": description,
        "imageUrl": imageUrl,
        "courses": []
        // List<CourseModel>.from(courses.map((x) => x.toJson())),
      };
}
