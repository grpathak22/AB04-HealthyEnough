import 'package:firebase_messaging/firebase_messaging.dart';

// Future<void> handleBackgroundMessage(RemoteMessage message) async {
//   print('Title: ${message.notification?.title}');
//   print('Body: ${message.notification?.body}');
//   print('Payload: ${message.data}');
// }

class FirebaseNotificaitons {
  final _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> initNotifications() async {
    await _firebaseMessaging.requestPermission();
    final FCMToken = await _firebaseMessaging.getToken();
    print('Token: $FCMToken');

    // FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
  }
}
