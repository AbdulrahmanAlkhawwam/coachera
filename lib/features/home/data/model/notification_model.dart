import '../../domain/entities/notification.dart';

class NotificationModel extends Notification {
  NotificationModel({
    required super.createdAt,
    required super.updatedAt,
    required super.id,
    required super.type,
    required super.title,
    required super.content,
    required super.actionUrl,
    required super.read,
    required super.sentAt,
    required super.readAt,
    required super.recipientId,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      NotificationModel(
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        id: json["id"],
        type: json["type"],
        title: json["title"],
        content: json["content"],
        actionUrl: json["actionUrl"],
        read: json["read"],
        sentAt: DateTime.parse(json["sentAt"]),
        readAt: json["readAt"],
        recipientId: json["recipientId"],
      );

  Map<String, dynamic> toJson() => {
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "id": id,
        "type": type,
        "title": title,
        "content": content,
        "actionUrl": actionUrl,
        "read": read,
        "sentAt": sentAt.toIso8601String(),
        "readAt": readAt,
        "recipientId": recipientId,
      };
}
