part of 'notification_bloc.dart';

@immutable
sealed class NotificationEvent {}

class GetUnreadNotification extends NotificationEvent{}

class GetMyNotifications extends NotificationEvent{}

class MarkNotification extends NotificationEvent{
  final int id;
  MarkNotification({required this.id});
}
