import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:awesome_notifications/awesome_notifications.dart';

import '../app/constants/app_constants.dart';

class NotificationHelper {
  FirebaseMessaging? firebaseMessaging = FirebaseMessaging.instance;

  Future<void> init() async {
    await AwesomeNotifications().isNotificationAllowed().then((
      isAllowed,
    ) async {
      if (!isAllowed) {
        await AwesomeNotifications().requestPermissionToSendNotifications(
          permissions: [
            NotificationPermission.Alert,
            NotificationPermission.Badge,
            NotificationPermission.Sound,
            NotificationPermission.Vibration,
          ],
        );
      }
      //  await FcmTokenHelper().getToken();
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (message.notification == null) {
        return;
      }
      debugPrint(
        'Foreground message received: ${message.notification?.title}, ${message.notification?.body} : ${message.data}',
      );
      createNotification(
        title: message.notification?.title ?? "",
        body: message.notification?.body ?? "",
        payload: message.data,
      );
    });

    await AwesomeNotifications().initialize(null, [
      NotificationChannel(
        channelKey: 'booking_channel',
        channelName: 'Booking Notifications',
        channelDescription: 'Notification channel for booking updates',
        defaultColor: const Color(0xFF9D50DD),
        ledColor: Colors.white,
        channelShowBadge: true,
        importance: NotificationImportance.High,
      ),
    ]);
    listen();
  }

  // schedule notification
  static Future<void> createSchedularNotification({
    required String title,
    required String body,
    required DateTime time,
    Map<String, dynamic>? payload,
  }) async {
    await AwesomeNotifications().createNotification(
      schedule: NotificationCalendar(
        // Removing year, month, and day allows the notification to repeat daily at the specified time
        hour: time.hour,
        minute: time.minute,
        second: time.second,
        millisecond: time.millisecond,
        repeats: true,
        preciseAlarm: true,
        allowWhileIdle: true,
        timeZone: AwesomeNotifications.localTimeZoneIdentifier,
      ),
      content: NotificationContent(
        id: DateTime.now().millisecondsSinceEpoch.remainder(100000),
        channelKey: 'booking_channel',
        title: title,
        body: body,
        payload: payload?.map((key, value) => MapEntry(key, value?.toString())),
        notificationLayout: payload?.containsKey("image_url") ?? false
            ? NotificationLayout.BigPicture
            : NotificationLayout.Default,
        backgroundColor: Colors.amber,
        bigPicture: payload?.containsKey("image_url") ?? false
            ? payload!["image_url"]
            : null,
        showWhen: true,
        locked: false,
      ),
      actionButtons: [
        NotificationActionButton(
          key: AppConstants.remindMeLater,
          label: 'Remind Me Later',
          actionType: ActionType.Default,
        ),
        NotificationActionButton(
          key: AppConstants.turnOffScheduler,
          label: 'Turn Off',
          actionType: ActionType.DismissAction,
        ),
      ],
    );
  }

  // create a notification
  Future<void> createNotification({
    required String title,
    required String body,
    Map<String, dynamic>? payload,
  }) async {
    debugPrint('Foreground message received: $title, $body : $payload');
    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: DateTime.now().millisecondsSinceEpoch.remainder(100000),
        channelKey: 'booking_channel',
        title: title,
        body: body,
        payload: payload?.map((key, value) => MapEntry(key, value?.toString())),
        notificationLayout: payload?.containsKey("image_url") ?? false
            ? NotificationLayout.BigPicture
            : NotificationLayout.Default,
        backgroundColor: Colors.amber,
        bigPicture: payload?.containsKey("image_url") ?? false
            ? payload!["image_url"]
            : null,
      ),
    );
  }

  void listen() {
    AwesomeNotifications().setListeners(
      onActionReceivedMethod: (ReceivedAction receivedAction) {
        return onActionReceivedMethod(receivedAction);
      },
      onNotificationCreatedMethod: (ReceivedNotification receivedNotification) {
        return onNotificationCreatedMethod(receivedNotification);
      },
      onNotificationDisplayedMethod:
          (ReceivedNotification receivedNotification) {
            return onNotificationDisplayedMethod(receivedNotification);
          },
      onDismissActionReceivedMethod: (ReceivedAction receivedAction) {
        return onDismissActionReceivedMethod(receivedAction);
      },
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
    await AwesomeNotifications().cancel(receivedAction.id ?? 0);
  }

  @pragma("vm:entry-point")
  static Future<void> onActionReceivedMethod(
    ReceivedAction receivedAction,
  ) async {
    debugPrint("Action received: ${receivedAction.payload}");
    if (receivedAction.buttonKeyPressed == AppConstants.remindMeLater) {
      // add reminder logic for 15 minutes
      await createSchedularNotification(
        title: receivedAction.title ?? "",
        body: receivedAction.body ?? "",
        time: DateTime.now().add(
          const Duration(minutes: AppConstants.notificationIntervalInMins),
        ),
        payload: receivedAction.payload,
      );
    } else if (receivedAction.buttonKeyPressed ==
        AppConstants.turnOffScheduler) {
      await AwesomeNotifications().cancelAllSchedules();
    }
  }
}
