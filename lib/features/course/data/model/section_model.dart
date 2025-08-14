import 'package:coachera/features/course/data/model/material_model.dart';

import '../../domain/entities/material.dart';
import '../../domain/entities/section.dart';

class SectionModel extends Section {
  SectionModel({
    required super.createdAt,
    required super.updatedAt,
    required super.id,
    required super.title,
    required super.moduleId,
    required super.orderIndex,
    required super.materials,
  });

  factory SectionModel.fromJson(Map<String, dynamic> json) => SectionModel(
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        id: json["id"],
        title: json["title"],
        moduleId: json["moduleId"],
        orderIndex: json["orderIndex"],
        materials: List<MaterialModel>.from(
            json["materials"].map((x) => MaterialModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "id": id,
        "title": title,
        "moduleId": moduleId,
        "orderIndex": orderIndex,
        "materials": List<dynamic>.from(materials.map((x) => x.toJson())),
      };
}
