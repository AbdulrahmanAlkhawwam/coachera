class LearningPath {
  final DateTime createdAt;
  final DateTime updatedAt;
  final int id;
  final int orgId;
  final String title;
  final String description;
  final String imageUrl;
  final List<String> courses;

  LearningPath({
    required this.createdAt,
    required this.updatedAt,
    required this.id,
    required this.orgId,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.courses,
  });
}
