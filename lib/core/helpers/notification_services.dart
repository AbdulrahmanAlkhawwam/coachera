import 'package:firebase_messaging/firebase_messaging.dart';

class NotificationService {
  static final NotificationService _instance = NotificationService._internal();
  factory NotificationService() => _instance;
  NotificationService._internal();

  void init() {
    _listenForeground();
    _listenBackground();
    _listenOnOpenedApp();
  }

  void _listenForeground() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Foreground message received: ${message.notification?.title}');
      // TODO: show local notification or update UI
    });
  }

  void _listenBackground() {
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  }

  void _listenOnOpenedApp() {
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('Notification clicked!');
      // TODO: navigate to notification screen
    });
  }
}

// Background handler must be a top-level function
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print('Background message received: ${message.messageId}');
}


// import 'package:firebase_messaging/firebase_messaging.dart';
//
// class NotificationService {
//   static final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
//
//   /// تهيئة الإشعارات
//   static Future<void> init() async {
//     // طلب صلاحية استلام الإشعارات (iOS)
//     NotificationSettings settings = await _firebaseMessaging.requestPermission(
//       alert: true,
//       badge: true,
//       sound: true,
//     );
//
//     print('User granted permission: ${settings.authorizationStatus}');
//
//     // الحصول على الـ Token (تستخدمه من أجل إرسال الإشعارات من Firebase Console أو Server)
//     String? token = await _firebaseMessaging.getToken();
//     print("FCM Token: $token");
//
//     // الإستماع للإشعارات لما التطبيق مفتوح
//     FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//       print("📩 Notification received: ${message.notification?.title}");
//       print("📄 Body: ${message.notification?.body}");
//     });
//
//     // إذا المستخدم فتح الإشعار من الخلفية
//     FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
//       print("🔗 Notification clicked: ${message.data}");
//     });
//   }
// }
