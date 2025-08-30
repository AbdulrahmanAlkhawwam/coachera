import '../../../material/data/model/material_model.dart';

class Section {
  final DateTime createdAt;
  final DateTime updatedAt;
  final int id;
  final String title;
  final int moduleId;
  final int orderIndex;
  final List<MaterialModel> materials;

  Section({
    required this.createdAt,
    required this.updatedAt,
    required this.id,
    required this.title,
    required this.moduleId,
    required this.orderIndex,
    required this.materials,
  });
}
