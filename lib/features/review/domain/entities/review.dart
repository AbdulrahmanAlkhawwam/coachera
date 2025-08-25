class Review {
  final DateTime createdAt;
  final DateTime updatedAt;
  final int id;
  final int courseId;
  final double rating;
  final String comment;

  Review({
    required this.id,
    required this.courseId,
    required this.rating,
    required this.comment,
    required this.createdAt,
    required this.updatedAt,
  });
}
