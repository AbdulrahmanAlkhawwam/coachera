import 'package:firebase_messaging/firebase_messaging.dart';

/// NotificationService مسؤول عن التعامل مع إشعارات Firebase
class NotificationService {
  static final NotificationService _instance = NotificationService._internal();
  factory NotificationService() => _instance;
  NotificationService._internal();

  static final FirebaseMessaging _firebaseMessaging =
      FirebaseMessaging.instance;

  /// تهيئة الإشعارات
  Future<void> init() async {
    // طلب صلاحية استلام الإشعارات (مهم لـ iOS)
    NotificationSettings settings = await _firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );
    print("🔐 Permission status: ${settings.authorizationStatus}");

    // جلب الـ FCM Token
    String? token = await _firebaseMessaging.getToken();
    print("📱 FCM Token: $token");

    // الإستماع لإشعارات foreground
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print("📩 Foreground notification: ${message.notification?.title}");
      print("📄 Body: ${message.notification?.body}");
    });

    // الإستماع عند فتح الإشعار (من الخلفية أو terminated)
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print("🔗 Notification clicked: ${message.data}");
    });

    // التعامل مع الرسائل في الخلفية
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  }
}

/// لازم يكون top-level function (برا الكلاس) للتعامل مع background notifications
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("🌙 Background message received: ${message.messageId}");
}
