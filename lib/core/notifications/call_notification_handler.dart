import 'dart:developer';
import 'package:auto_route/auto_route.dart';
import 'package:fennac_app/app/app.dart';
import 'package:fennac_app/core/di_container.dart';
import 'package:fennac_app/pages/call/presentation/bloc/cubit/call_cubit.dart';
import 'package:fennac_app/routes/routes_imports.gr.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_callkit_incoming/entities/android_params.dart';
import 'package:flutter_callkit_incoming/entities/call_event.dart';
import 'package:flutter_callkit_incoming/entities/call_kit_params.dart';
import 'package:flutter_callkit_incoming/entities/ios_params.dart';
import 'package:flutter_callkit_incoming/entities/notification_params.dart';
import 'package:flutter_callkit_incoming/flutter_callkit_incoming.dart';
import 'package:uuid/uuid.dart';

class CallNotificationHandler {
  static final CallNotificationHandler _instance =
      CallNotificationHandler._internal();
  factory CallNotificationHandler() => _instance;
  CallNotificationHandler._internal();

  void init() {
    FlutterCallkitIncoming.onEvent.listen(_onCallEvent);
  }

  static Future<void> handleCallNotification(RemoteMessage message) async {
    final data = message.data;
    final callId = data['callRecordId'] ?? const Uuid().v4();
    final callerName = message.notification?.title ?? "Incoming Call";
    final callerNumber = data['callerId'] ?? "";
    final mediaType = data['mediaType'] ?? "audio";

    final params = CallKitParams(
      id: callId,
      nameCaller: callerName,
      appName: 'Fennac',
      avatar: 'https://i.pravatar.cc/100',
      handle: callerNumber,
      type: mediaType == 'video' ? 1 : 0,
      duration: 30000,
      textAccept: 'Accept',
      textDecline: 'Decline',
      missedCallNotification: const NotificationParams(
        showNotification: true,
        isShowCallback: true,
        subtitle: 'Missed call',
        callbackText: 'Call back',
      ),
      extra: <String, dynamic>{
        'channelName': data['channelName'],
        'callRecordId': data['callRecordId'],
        'mediaType': mediaType,
      },
      headers: <String, dynamic>{'Content-Type': 'application/json'},
      android: const AndroidParams(
        isCustomNotification: true,
        isShowLogo: false,
        ringtonePath: 'system_ringtone_default',
        backgroundColor: '#0955fa',
        backgroundUrl: 'https://i.pravatar.cc/500',
        actionColor: '#4CAF50',
        textColor: '#ffffff',
      ),
      ios: const IOSParams(
        iconName: 'AppIcon',
        handleType: 'generic',
        supportsVideo: true,
        maximumCallGroups: 2,
        maximumCallsPerCallGroup: 1,
        audioSessionMode: 'default',
        audioSessionActive: true,
        audioSessionPreferredSampleRate: 44100.0,
        audioSessionPreferredIOBufferDuration: 0.005,
        supportsDTMF: true,
        supportsHolding: true,
        supportsGrouping: true,
        supportsUngrouping: true,
        ringtonePath: 'system_ringtone_default',
      ),
    );

    await FlutterCallkitIncoming.showCallkitIncoming(params);
  }

  void _onCallEvent(CallEvent? event) {
    if (event == null) return;

    switch (event.event) {
      case Event.actionCallAccept:
        log('Call Accepted: ${event.body}');
        _handleCallAccept(event.body);
        break;
      case Event.actionCallDecline:
        log('Call Declined: ${event.body}');
        break;
      case Event.actionCallEnded:
        log('Call Ended: ${event.body}');
        break;
      case Event.actionCallTimeout:
        log('Call Timeout: ${event.body}');
        break;
      default:
        break;
    }
  }

  void _handleCallAccept(dynamic body) {
    final extra = body['extra'];
    if (extra == null) return;

    final channelName = extra['channelName'] as String?;
    final callId = extra['callRecordId'] as String?;
    final mediaType = extra['mediaType'] as String?;

    if (channelName != null && callId != null && mediaType != null) {
      final callCubit = Di().sl<CallCubit>();
      callCubit.setIncomingCallData(
        channelName: channelName,
        callId: callId,
        mediaType: mediaType,
      );

      if (navigatorKey.currentState != null) {
        if (mediaType == 'video') {
          navigatorKey.currentContext!.pushRoute(VideoCallRoute());
        } else {
          navigatorKey.currentContext!.pushRoute(AudioCallRoute());
        }
      }
    }
  }
}
