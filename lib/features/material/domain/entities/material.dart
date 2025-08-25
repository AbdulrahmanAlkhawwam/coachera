import '../../../quiz/data/model/quiz_model.dart';
import 'material_type.dart';

class Material {
  final DateTime createdAt;
  final DateTime updatedAt;
  final int id;
  final String title;
  final int sectionId;
  final int orderIndex;
  final MaterialType type;
  final dynamic videoUrl;
  final String? article;
  final QuizModel? quiz;

  Material({
    required this.createdAt,
    required this.updatedAt,
    required this.id,
    required this.title,
    required this.sectionId,
    required this.orderIndex,
    required this.type,
    required this.videoUrl,
    required this.article,
    required this.quiz,
  });
}
