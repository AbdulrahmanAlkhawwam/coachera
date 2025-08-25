import '../../domain/entities/material_type.dart';
import '../../../quiz/data/model/quiz_model.dart';
import '../../domain/entities/material.dart';

class MaterialModel extends Material {
  MaterialModel({
    required super.createdAt,
    required super.updatedAt,
    required super.id,
    required super.title,
    required super.sectionId,
    required super.orderIndex,
    required super.type,
    required super.videoUrl,
    required super.article,
    required super.quiz,
  });

  factory MaterialModel.fromJson(Map<String, dynamic> json) => MaterialModel(
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        id: json["id"],
        title: json["title"],
        sectionId: json["sectionId"],
        orderIndex: json["orderIndex"],
        type: materialTypeValues.map[json["type"]]!,
        videoUrl: json["videoUrl"],
        article: json["article"],
        quiz: json["quiz"] == null ? null : QuizModel.fromJson(json["quiz"]),
      );

  Map<String, dynamic> toJson() => {
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "id": id,
        "title": title,
        "sectionId": sectionId,
        "orderIndex": orderIndex,
        "type": materialTypeValues.reverse[type],
        "videoUrl": videoUrl,
        "article": article,
        "quiz": quiz?.toJson(),
      };
}

enum MaterialType { ARTICLE, QUIZ, VIDEO }
