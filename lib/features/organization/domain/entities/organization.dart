class Organization {
  final DateTime createdAt;
  final DateTime updatedAt;
  final int id;
  final int userId;
  final String orgName;
  final String orgDescription;

  Organization({
    required this.createdAt,
    required this.updatedAt,
    required this.id,
    required this.userId,
    required this.orgName,
    required this.orgDescription,
  });
}