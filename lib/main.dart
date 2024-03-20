import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:healthy_enough/helper/local_notifications.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

void main() async {
  runApp(MyApp());

  _initializeFirebase();
  // await Permission.notification.isDenied.then((value) {
  //   if (value) {
  //     Permission.notification.request();
  //   }
  // });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Splash Screen Test',
      home: SplashScreen(),
    );
  }
}

_initializeFirebase() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // final localNotifications = await LocalNotifications();
  // await localNotifications
  //     .initializeNotifications(flutterLocalNotificationsPlugin);

  // await localNotifications.scheduleNotification(
  //     scheduledNotificationDateTime: DateTime.parse('2024-03-20 12:54:04Z'));
}
