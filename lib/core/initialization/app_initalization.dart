import 'package:fennac_app/helpers/notification_helper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fennac_app/firebase_options.dart';
import 'package:flutter/material.dart';

import '../di_container.dart';

class AppInitalizer {
  static Future init() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Di().init();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    NotificationHelper().init();

    // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  }
}

// @pragma("vm:entry-point")
// Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   debugPrint(
//     'Foreground message received: ${message.notification?.title}, ${message.notification?.body} : ${message.data}',
//   );
//   NotificationHelper().createNotification(
//     title: message.notification?.title ?? "",
//     body: message.notification?.body ?? "",
//     payload: message.data,
//   );
// }
