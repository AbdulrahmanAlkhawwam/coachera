class Notification {
  final DateTime createdAt;
  final DateTime updatedAt;
  final int id;
  final String type;
  final String title;
  final String content;
  final String actionUrl;
  final bool read;
  final DateTime sentAt;
  final dynamic readAt;
  final int recipientId;

  Notification({
    required this.createdAt,
    required this.updatedAt,
    required this.id,
    required this.type,
    required this.title,
    required this.content,
    required this.actionUrl,
    required this.read,
    required this.sentAt,
    required this.readAt,
    required this.recipientId,
  });
}
