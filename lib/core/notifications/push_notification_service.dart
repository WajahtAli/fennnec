import 'dart:developer';

import 'package:fennac_app/core/di_container.dart';
import 'package:fennac_app/pages/auth/presentation/bloc/cubit/create_account_cubit.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'local_notification_service.dart';
import 'call_notification_handler.dart';
import '../../app/constants/app_constants.dart';
import 'voip_bridge.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  log(
    'Background message received: ${message.notification?.title}, ${message.notification?.body}',
  );
  if (message.data['type'] == 'call_incoming') {
    await CallNotificationHandler.handleCallNotification(message);
  } else {
    await LocalNotificationService.init();
  }
}

class PushNotificationService {
  static final FirebaseMessaging _firebaseMessaging =
      FirebaseMessaging.instance;

  static Future<void> init() async {
    CallNotificationHandler().init();

    VoipBridge.init(
      onAccept: (data) {
        log('Call accepted with data: $data');
        CallNotificationHandler().handleBridgeAccept(data);
      },
      onDecline: (_) {},
    );

    await _firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
      provisional: false,
      announcement: true,
    );

    // Wait for APNS token on iOS before calling getToken
    String? token;
    bool gotToken = false;
    try {
      token = await _firebaseMessaging.getToken();
      gotToken = token != null && token.isNotEmpty;
    } catch (e) {
      debugPrint('FCM getToken error (may be APNS not ready yet): $e');
    }

    if (!gotToken) {
      // Listen for token refresh (APNS registration)
      _firebaseMessaging.onTokenRefresh.listen((newToken) {
        debugPrint('FCM Token (onTokenRefresh): $newToken');
        Di().sl<CreateAccountCubit>().updateProfile(fcmToken: newToken);
      });
    } else {
      debugPrint('FCM Token: $token');
      Di().sl<CreateAccountCubit>().updateProfile(fcmToken: token!);
    }

    FirebaseMessaging.onMessage.listen(_onForegroundMessage);

    FirebaseMessaging.onMessageOpenedApp.listen(_onMessageOpenedApp);

    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    await _checkInitialMessage();
  }

  static void _onForegroundMessage(RemoteMessage message) {
    log(
      'Foreground message received: ${message.toMap()}, ${message.notification?.body}',
    );

    if (message.data['type'] == 'call_incoming') {
      CallNotificationHandler.handleCallNotification(message);
    } else if (message.notification != null) {
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
    log('Opened app from background message: ${message.data}');
  }

  static Future<void> _checkInitialMessage() async {
    final RemoteMessage? initialMessage = await _firebaseMessaging
        .getInitialMessage();
    if (initialMessage != null) {
      log('Opened app from terminated state: ${initialMessage.data}');
    }
  }
}
