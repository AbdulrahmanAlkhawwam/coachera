import '../../domain/entities/enrollment.dart';

class EnrollmentModel extends Enrollment {
  EnrollmentModel({
    required super.createdAt,
    required super.updatedAt,
    required super.id,
    required super.courseId,
    required super.studentId,
    required super.courseCompletion,
    required super.materialCompletions,
  });

  factory EnrollmentModel.fromJson(Map<String, dynamic> json) =>
      EnrollmentModel(
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        id: json["id"],
        courseId: json["courseId"],
        studentId: json["studentId"],
        courseCompletion:
            CourseCompletionModel.fromJson(json["courseCompletion"]),
        materialCompletions:
            List<dynamic>.from(json["materialCompletions"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "id": id,
        "courseId": courseId,
        "studentId": studentId,
        "courseCompletion": courseCompletion.toJson(),
        "materialCompletions":
            List<dynamic>.from(materialCompletions.map((x) => x)),
      };
}

class CourseCompletionModel extends CourseCompletion {
  CourseCompletionModel({
    required super.createdAt,
    required super.updatedAt,
    required super.id,
    required super.enrollmentId,
    required super.progress,
    required super.completed,
    required super.completionDate,
  });

  factory CourseCompletionModel.fromJson(Map<String, dynamic> json) =>
      CourseCompletionModel(
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        id: json["id"],
        enrollmentId: json["enrollmentId"],
        progress: json["progress"],
        completed: json["completed"],
        completionDate: json["completionDate"],
      );

  Map<String, dynamic> toJson() => {
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "id": id,
        "enrollmentId": enrollmentId,
        "progress": progress,
        "completed": completed,
        "completionDate": completionDate,
      };
}
