
import 'package:coachera/features/home/data/model/notification_model.dart';

import '../../../../core/constants/routes.dart';
import '../../../../core/helpers/http/http_service.dart';

abstract class NotificationRemoteDataSource {
  Future<int> fetchUnreadCount();

  Future<List<NotificationModel>> fetchNotifications();

  Future<void> markNotificationsRead(int ids);
}

class NotificationRemoteDataSourceImpl extends NotificationRemoteDataSource {
  final HttpService http;

  NotificationRemoteDataSourceImpl({required this.http});

  @override
  Future<int> fetchUnreadCount() async {
    final response = await http
        .handleApiCall(() async => await http.get(Endpoint.unreadCount));
    return response.data;
  }

  @override
  Future<List<NotificationModel>> fetchNotifications() async {
    final response = await http
        .handleApiCall(() async => await http.get(Endpoint.notifications));
    final List<dynamic> notifications = response.data["content"];

    return notifications.map((e) => NotificationModel.fromJson(e)).toList();
  }

  @override
  Future<void> markNotificationsRead(int id) async {
    await http.handleApiCall(() async => await http.put(
        Endpoint.markNotificationsRead,
        queryParameters: {"notificationIds": id.toString()}));
  }
}
