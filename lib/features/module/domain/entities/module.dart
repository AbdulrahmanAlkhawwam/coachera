import '../../../course/data/model/section_model.dart';

class Module {
  final dynamic createdAt;
  final dynamic updatedAt;
  final int id;
  final String title;
  final int courseId;
  final int orderIndex;
  final List<SectionModel> sections;

  Module({
    required this.createdAt,
    required this.updatedAt,
    required this.id,
    required this.title,
    required this.courseId,
    required this.orderIndex,
    required this.sections,
  });
}
