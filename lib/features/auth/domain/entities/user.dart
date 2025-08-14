class User {
  final DateTime createdAt;
  final DateTime updatedAt;
  final int id;
  final int userId;
  final String firstName;
  final String lastName;
  final DateTime birthDate;
  final String gender;
  final String education;
  final double wallet;
  final String phoneNumber;
  final String address;
  final List<dynamic> certificateIds;
  final List<dynamic> skills;

  User({
    required this.createdAt,
    required this.updatedAt,
    required this.id,
    required this.userId,
    required this.firstName,
    required this.lastName,
    required this.birthDate,
    required this.gender,
    required this.education,
    required this.wallet,
    required this.phoneNumber,
    required this.address,
    required this.certificateIds,
    required this.skills,
  });
}
