import 'package:coachera/features/quiz/domain/entities/question.dart';

class QuestionModel extends Question {
  QuestionModel({
    // required super.createdAt,
    // required super.updatedAt,
    required super.id,
    // required super.quizId,
    required super.content,
    required super.firstAnswer,
    required super.secondAnswer,
    required super.thirdAnswer,
    required super.forthAnswer,
  });

  factory QuestionModel.fromJson(Map<String, dynamic> json) => QuestionModel(
        // createdAt: DateTime.parse(json["createdAt"]),
        // updatedAt: DateTime.parse(json["updatedAt"]),
        id: json["id"],
        // quizId: json["quizId"],
        content: json["content"],
        firstAnswer: json["answer1"],
        secondAnswer: json["answer2"],
        thirdAnswer: json["answer3"],
        forthAnswer: json["answer4"],
      );

  Map<String, dynamic> toJson() => {
        // "createdAt": createdAt.toIso8601String(),
        // "updatedAt": updatedAt.toIso8601String(),
        "id": id,
        // "quizId": quizId,
        "content": content,
        "answer1": firstAnswer,
        "answer2": secondAnswer,
        "answer3": thirdAnswer,
        "answer4": forthAnswer,
      };
}
