
import '../../domain/entities/instructor.dart';

class InstructorModel extends Instructor {
  InstructorModel({
    required super.createdAt,
    required super.updatedAt,
    required super.id,
    required super.userId,
    required super.name,
    required super.bio,
  });

  factory InstructorModel.fromJson(Map<String, dynamic> json) =>
      InstructorModel(
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        id: json["id"],
        userId: json["userId"],
        name: json["name"],
        bio: json["bio"],
      );

  Map<String, dynamic> toJson() => {
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "id": id,
        "userId": userId,
        "name": name,
        "bio": bio,
      };
}
