class Instructor {
  final DateTime createdAt;
  final DateTime updatedAt;
  final int id;
  final int userId;
  final String name;
  final String bio;

  Instructor({
    required this.createdAt,
    required this.updatedAt,
    required this.id,
    required this.userId,
    required this.name,
    required this.bio,
  });
}
