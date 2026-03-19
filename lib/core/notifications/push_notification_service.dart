import 'package:fennac_app/core/di_container.dart';
import 'package:fennac_app/pages/auth/presentation/bloc/cubit/create_account_cubit.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'local_notification_service.dart';
import '../../app/constants/app_constants.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  debugPrint(
    'Background message received: \${message.notification?.title}, \${message.notification?.body}',
  );
  await LocalNotificationService.init();
}

class PushNotificationService {
  static final FirebaseMessaging _firebaseMessaging =
      FirebaseMessaging.instance;

  static Future<void> init() async {
    await _firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
      provisional: false,
    );

    final String? token = await _firebaseMessaging.getToken();
    debugPrint('FCM Token: $token');

    if (token != null) {
      Di().sl<CreateAccountCubit>().updateProfile(fcmToken: token);
    }

    FirebaseMessaging.onMessage.listen(_onForegroundMessage);

    FirebaseMessaging.onMessageOpenedApp.listen(_onMessageOpenedApp);

    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    await _checkInitialMessage();
  }

  static void _onForegroundMessage(RemoteMessage message) {
    debugPrint(
      'Foreground message received: \${message.notification?.title}, \${message.notification?.body}',
    );

    if (message.notification != null) {
      LocalNotificationService.showNotification(
        title: message.notification!.title ?? '',
        body: message.notification!.body ?? '',
        channelKey:
            message.data['channel_key'] ?? AppConstants.messagesChannelKey,
        payload: message.data,
      );
    }
  }

  static void _onMessageOpenedApp(RemoteMessage message) {
    debugPrint('Opened app from background message: \${message.data}');
  }

  static Future<void> _checkInitialMessage() async {
    final RemoteMessage? initialMessage = await _firebaseMessaging
        .getInitialMessage();
    if (initialMessage != null) {
      debugPrint('Opened app from terminated state: \${initialMessage.data}');
    }
  }
}
