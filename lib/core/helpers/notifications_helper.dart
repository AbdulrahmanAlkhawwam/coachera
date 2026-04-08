// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
//
// import '../../firebase_options.dart';
//
// abstract class NotificationsHelper {
//   Future<String?> getDeviceToken();
//   Future<void> deleteDeviceToken();
// }
//
// class NotificationsHelperImpl implements NotificationsHelper {
//   static bool isInitialized = false;
//
//   NotificationsHelperImpl._();
//
//   static final NotificationsHelperImpl instance = NotificationsHelperImpl._();
//
//   final FirebaseMessaging _messaging = FirebaseMessaging.instance;
//
//   static NotificationsHelperImpl get initializedInstance {
//     assert(isInitialized);
//     return NotificationsHelperImpl._();
//   }
//
//   @override
//   Future<String?> getDeviceToken() async {
//     try {
//       return await FirebaseMessaging.instance.getToken();
//     } catch (e) {
//       return null;
//     }
//   }
//
//   @override
//   Future<void> deleteDeviceToken() async {
//     FirebaseMessaging.instance.deleteToken().catchError((e) {});
//   }
//
//   final FlutterLocalNotificationsPlugin _local =
//       FlutterLocalNotificationsPlugin();
//
//   late AndroidNotificationChannel _channel;
//   late GlobalKey<NavigatorState> navigatorKey;
//
//   Future<void> init(GlobalKey<NavigatorState> navKey) async {
//     navigatorKey = navKey;
//
//     FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
//
//     await _messaging.requestPermission(
//       alert: true,
//       badge: true,
//       sound: true,
//     );
//
//     await _messaging.setForegroundNotificationPresentationOptions(
//       alert: true,
//       badge: true,
//       sound: true,
//     );
//
//     _channel = const AndroidNotificationChannel(
//       'coachera_channel',
//       'Coachera Notifications',
//       description: 'Important notifications for Coachera',
//       importance: Importance.high,
//     );
//
//     await _local
//         .resolvePlatformSpecificImplementation<
//             AndroidFlutterLocalNotificationsPlugin>()
//         ?.createNotificationChannel(_channel);
//
//     final token = await _messaging.getToken();
//     debugPrint("🔥 FCM Token: $token");
//
//     FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//       _showLocalNotification(message);
//     });
//
//     FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
//       _handleNavigation(message);
//     });
//
//     final initialMessage = await _messaging.getInitialMessage();
//     if (initialMessage != null) {
//       _handleNavigation(initialMessage);
//     }
//     isInitialized = true;
//   }
//
//   Future<void> _showLocalNotification(RemoteMessage message) async {
//     final notification = message.notification;
//     if (notification == null) return;
//
//     await _local.show(
//       notification.hashCode,
//       notification.title,
//       notification.body,
//       NotificationDetails(
//         android: AndroidNotificationDetails(
//           _channel.id,
//           _channel.name,
//           channelDescription: _channel.description,
//           importance: Importance.high,
//           priority: Priority.high,
//           icon: '@mipmap/ic_launcher',
//         ),
//         iOS: const DarwinNotificationDetails(),
//       ),
//       payload: message.data['route'],
//     );
//   }
//
//   void _handleNavigation(RemoteMessage message) {
//     final route = message.data['route'];
//     if (route != null && route.isNotEmpty) {
//       navigatorKey.currentState?.pushNamed(route);
//     }
//   }
// }
//
// @pragma('vm:entry-point')
// Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
//   debugPrint("📩 Background message: ${message.messageId}");
// }
