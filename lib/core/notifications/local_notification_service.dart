import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import '../../app/constants/app_constants.dart';

class LocalNotificationService {
  static final AwesomeNotifications _awesomeNotifications =
      AwesomeNotifications();

  static Future<void> init() async {
    await _awesomeNotifications.initialize(null, [
      NotificationChannel(
        channelKey: AppConstants.chatsChannelKey,
        channelName: 'Chats',
        channelDescription: 'Notifications for new chats',
        defaultColor: const Color(0xFF9D50DD),
        ledColor: Colors.white,
        channelShowBadge: true,
        importance: NotificationImportance.High,
      ),
      NotificationChannel(
        channelKey: AppConstants.messagesChannelKey,
        channelName: 'Messages',
        channelDescription: 'Notifications for new messages',
        defaultColor: const Color(0xFF9D50DD),
        ledColor: Colors.white,
        channelShowBadge: true,
        importance: NotificationImportance.High,
      ),
      NotificationChannel(
        channelKey: AppConstants.pokesChannelKey,
        channelName: 'Pokes',
        channelDescription: 'Notifications for pokes',
        defaultColor: const Color(0xFF9D50DD),
        ledColor: Colors.white,
        channelShowBadge: true,
        importance: NotificationImportance.High,
      ),
    ]);

    await requestPermission();
    _setListeners();
  }

  /// Request permissions if not already granted
  static Future<void> requestPermission() async {
    final isAllowed = await _awesomeNotifications.isNotificationAllowed();
    if (!isAllowed) {
      await _awesomeNotifications.requestPermissionToSendNotifications(
        permissions: [
          NotificationPermission.Alert,
          NotificationPermission.Badge,
          NotificationPermission.Sound,
          NotificationPermission.Vibration,
        ],
      );
    }
  }

  static void _setListeners() {
    _awesomeNotifications.setListeners(
      onActionReceivedMethod: LocalNotificationService.onActionReceivedMethod,
      onNotificationCreatedMethod:
          LocalNotificationService.onNotificationCreatedMethod,
      onNotificationDisplayedMethod:
          LocalNotificationService.onNotificationDisplayedMethod,
      onDismissActionReceivedMethod:
          LocalNotificationService.onDismissActionReceivedMethod,
    );
  }

  static Future<void> showNotification({
    required String title,
    required String body,
    String? channelKey,
    Map<String, dynamic>? payload,
  }) async {
    await _awesomeNotifications.createNotification(
      content: NotificationContent(
        id: DateTime.now().millisecondsSinceEpoch.remainder(100000),
        channelKey: channelKey ?? AppConstants.messagesChannelKey,
        title: title,
        body: body,
        payload: payload?.map((key, value) => MapEntry(key, value?.toString())),
        notificationLayout: payload?.containsKey('imageUrl') == true
            ? NotificationLayout.BigPicture
            : NotificationLayout.Default,
        backgroundColor: Colors.amber,
        bigPicture: payload?.containsKey('imageUrl') == true
            ? payload!['imageUrl']
            : null,
      ),
    );
  }

  @pragma("vm:entry-point")
  static Future<void> onNotificationCreatedMethod(
    ReceivedNotification receivedNotification,
  ) async {}

  @pragma("vm:entry-point")
  static Future<void> onNotificationDisplayedMethod(
    ReceivedNotification receivedNotification,
  ) async {}

  @pragma("vm:entry-point")
  static Future<void> onDismissActionReceivedMethod(
    ReceivedAction receivedAction,
  ) async {
    await _awesomeNotifications.cancel(receivedAction.id ?? 0);
  }

  @pragma("vm:entry-point")
  static Future<void> onActionReceivedMethod(
    ReceivedAction receivedAction,
  ) async {
    debugPrint("Action received: \${receivedAction.payload}");
  }
}
