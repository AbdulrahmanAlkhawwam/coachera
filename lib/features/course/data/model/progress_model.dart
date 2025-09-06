import 'dart:ffi';

import '../../domain/entities/completionState.dart';
import '../../domain/entities/progress.dart';
import 'course_model.dart';

class ProgressModel extends Progress {
  ProgressModel({
    required super.enrollmentId,
    required super.course,
    required super.courseCompletion,
    required super.materialCompletions,
    required super.progress,
  });

  factory ProgressModel.fromJson(Map<String, dynamic> json) => ProgressModel(
        enrollmentId: json["enrollmentId"],
        course: CourseModel.fromJson(json["course"]),
        courseCompletion: json["courseCompletion"],
        materialCompletions: List<MaterialCompletionModel>.from(
            json["materialCompletions"]
                .map((x) => MaterialCompletionModel.fromJson(x))),
        progress: double.parse(json["progress"].toString()),
      );

  Map<String, dynamic> toJson() => {
        "enrollmentId": enrollmentId,
        "course": course.toJson(),
        "courseCompletion": courseCompletion,
        "materialCompletions": List<MaterialCompletionModel>.from(
            materialCompletions.map((x) => x.toJson())),
        "progress": progress,
      };
}

class MaterialCompletionModel extends MaterialCompletion {
  MaterialCompletionModel({
    // required super.createdAt,
    // required super.updatedAt,
    // required super.id,
    required super.enrollmentId,
    required super.materialId,
    required super.completed,
    // required super.completionState,
    // required super.completionDate,
    // required super.triggerType,
  });

  factory MaterialCompletionModel.fromJson(Map<String, dynamic> json) {
    return MaterialCompletionModel(
      // createdAt: DateTime.parse(json["createdAt"]),
      // updatedAt: DateTime.parse(json["updatedAt"]),
      // id: json["id"],
      enrollmentId: json["enrollmentId"],
      materialId: json["materialId"],
      completed: json["completed"],
      // completionState: completionStateValues.map[json["completionState"]]!,
      // completionDate: DateTime.parse(json["completionDate"]),
      // triggerType: triggerTypeValues.map[json["triggerType"]]!,
    );
  }

  Map<String, dynamic> toJson() => {
        // "createdAt": createdAt.toIso8601String(),
        // "updatedAt": updatedAt.toIso8601String(),
        // "id": id,
        "enrollmentId": enrollmentId,
        "materialId": materialId,
        "completed": completed,
        // "completionState": completionStateValues.reverse[completionState],
        // "completionDate": completionDate.toIso8601String(),
        // "triggerType": triggerTypeValues.reverse[triggerType],
      };
}
