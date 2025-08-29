import '../../domain/entities/user.dart';

class UserModel extends User {
  UserModel({
    required super.createdAt,
    required super.updatedAt,
    required super.id,
    required super.userId,
    required super.firstName,
    required super.lastName,
    required super.birthDate,
    required super.gender,
    required super.education,
    required super.wallet,
    required super.phoneNumber,
    required super.address,
    required super.certificateIds,
    required super.skills,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        id: json["id"],
        userId: json["userId"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        birthDate: DateTime.parse(json["birthDate"]),
        gender: json["gender"],
        education: json["education"],
        wallet: json["wallet"]?.toDouble(),
        phoneNumber: json["phoneNumber"],
        address: json["address"],
        certificateIds: json['certificateIds'] == null
            ? []
            : List<dynamic>.from(json["certificateIds"]?.map((x) => x)),
        skills: json['skills'] == null
            ? []
            : List<dynamic>.from(json["skills"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "id": id,
        "userId": userId,
        "firstName": firstName,
        "lastName": lastName,
        "birthDate":
            "${birthDate.year.toString().padLeft(4, '0')}-${birthDate.month.toString().padLeft(2, '0')}-${birthDate.day.toString().padLeft(2, '0')}",
        "gender": gender,
        "education": education,
        "wallet": wallet,
        "phoneNumber": phoneNumber,
        "address": address,
        "certificateIds": List<dynamic>.from(certificateIds.map((x) => x)),
        "skills": List<dynamic>.from(skills.map((x) => x)),
      };
}
