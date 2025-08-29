part of 'notification_bloc.dart';

enum NotificationStatus {
  init,
  loading,
  error,
  success,
}

@immutable
class NotificationState {
  final NotificationStatus status;
  final Message? message;
  final int unreadNotification;
  final List<Notification> notification;

  const NotificationState({
    this.status = NotificationStatus.init,
    this.message,
    this.unreadNotification = 0,
    this.notification = const [],
  });

  NotificationState copyWith({
    NotificationStatus? status,
    Message? message,
    int? unreadNotification,
    List<Notification>? notification,
  }) =>
      NotificationState(
        status: status ?? this.status,
        message: message ?? this.message,
        unreadNotification: unreadNotification ?? this.unreadNotification,
        notification: notification ?? this.notification,
      );
}
