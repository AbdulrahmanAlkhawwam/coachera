import '../../../course/data/model/section_model.dart';
import '../../domain/entities/module.dart';

class ModuleModel extends Module {
  ModuleModel({
    required super.createdAt,
    required super.updatedAt,
    required super.id,
    required super.title,
    required super.courseId,
    required super.orderIndex,
    required super.sections,
  });

  factory ModuleModel.fromJson(Map<String, dynamic> json) => ModuleModel(
        createdAt: json["createdAt"],
        updatedAt: json["updatedAt"],
        id: json["id"],
        title: json["title"],
        courseId: json["courseId"],
        orderIndex: json["orderIndex"],
        sections: List<SectionModel>.from(
            json["sections"].map((x) => SectionModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "createdAt": createdAt,
        "updatedAt": updatedAt,
        "id": id,
        "title": title,
        "courseId": courseId,
        "orderIndex": orderIndex,
        "sections": List<SectionModel>.from(
            sections.map((section) => section.toJson())),
      };
}
