import 'package:firebase_core/firebase_core.dart';
import 'package:fennac_app/firebase_options.dart';
import 'package:flutter/material.dart';

import '../di_container.dart';
import '../../pages/buy_poke/data/datasource/iap_service.dart';
import '../notifications/local_notification_service.dart';
import '../notifications/push_notification_service.dart';
import '../sockets/sockets_service.dart';

class AppInitalizer {
  static Future init() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Di().init();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    SocketService.connect();
    // Notifications Pipeline
    await LocalNotificationService.init();
    await PushNotificationService.init();

    await IAPService.init();
  }
}
