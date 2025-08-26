import '../../domain/entities/organization.dart';

class OrganizationModel extends Organization {
  OrganizationModel({
    required super.createdAt,
    required super.updatedAt,
    required super.id,
    required super.userId,
    required super.orgName,
    required super.orgDescription,
  });

  factory OrganizationModel.fromJson(Map<String, dynamic> json) =>
      OrganizationModel(
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        id: json["id"],
        userId: json["userId"],
        orgName: json["orgName"],
        orgDescription: json["orgDescription"],
      );

  Map<String, dynamic> toJson() => {
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "id": id,
        "userId": userId,
        "orgName": orgName,
        "orgDescription": orgDescription,
      };
}
