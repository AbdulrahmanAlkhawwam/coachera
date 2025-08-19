import 'package:coachera/features/quiz/data/model/question_model.dart';
import 'package:coachera/features/quiz/domain/entities/quiz.dart';

class QuizModel extends Quiz {
  QuizModel({
    required super.createdAt,
    required super.updatedAt,
    required super.id,
    required super.materialId,
    required super.questions,
  });

  factory QuizModel.fromJson(Map<String, dynamic> json) => QuizModel(
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        id: json["id"],
        materialId: json["materialId"],
        questions: List<QuestionModel>.from(
            json["questions"].map((x) => QuestionModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "id": id,
        "materialId": materialId,
        "questions": List<dynamic>.from(questions.map((x) => x.toJson())),
      };
}
