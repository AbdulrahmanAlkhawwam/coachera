

import '../../data/model/question_model.dart';

class Quiz {
  final DateTime createdAt;
  final DateTime updatedAt;
  final int id;
  final int materialId;
  final List<QuestionModel> questions;

  Quiz({
    required this.createdAt,
    required this.updatedAt,
    required this.id,
    required this.materialId,
    required this.questions,
  });
}
