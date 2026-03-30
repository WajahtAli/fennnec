import 'dart:developer';
import 'package:auto_route/auto_route.dart';
import 'package:fennac_app/app/app.dart';
import 'package:fennac_app/app/theme/app_colors.dart';
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
import 'package:hexcolor/hexcolor.dart';
import 'package:uuid/uuid.dart';

class CallNotificationHandler {
  static final CallNotificationHandler _instance =
      CallNotificationHandler._internal();
  factory CallNotificationHandler() => _instance;
  CallNotificationHandler._internal();

  bool _isNavigating = false;

  void init() {
    FlutterCallkitIncoming.onEvent.listen(_onCallEvent);
    _checkInitialCallAccept();
  }

  static Future<void> handleCallNotification(RemoteMessage message) async {
    final data = message.data;
    final callId = data['callRecordId'] ?? const Uuid().v4();
    final callerName = message.notification?.title ?? "Incoming Call";
    final callerNumber = data['callerId'] ?? "";
    final mediaType = data['mediaType'] ?? "audio";
    final imageUrl = data['imageUrl'] ?? "";

    final params = CallKitParams(
      id: callId,
      nameCaller: callerName,
      appName: 'Fennac',
      avatar: imageUrl,
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
        'imageUrl': imageUrl,
      },
      headers: <String, dynamic>{'Content-Type': 'application/json'},
      android: AndroidParams(
        isCustomNotification: true,
        isShowLogo: false,
        ringtonePath: 'system_ringtone_default',
        backgroundColor: ColorPalette.primary.toHex(),
        backgroundUrl: imageUrl,
        logoUrl: imageUrl,
        actionColor: '#4CAF50',
        textColor: '#ffffff',
      ),
      ios: IOSParams(
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
        log('Call Accepted Event: ${event.body}');
        _handleCallAccept(event.body);
        break;
      case Event.actionCallDecline:
        log('Call Declined: ${event.body}');
        _isNavigating = false;
        FlutterCallkitIncoming.endAllCalls();
        break;
      case Event.actionCallEnded:
        log('Call Ended: ${event.body}');
        _isNavigating = false;
        FlutterCallkitIncoming.endAllCalls();
        break;
      case Event.actionCallTimeout:
        log('Call Timeout: ${event.body}');
        _isNavigating = false;
        FlutterCallkitIncoming.endAllCalls();
        break;
      default:
        break;
    }
  }

  Future<void> _checkInitialCallAccept() async {
    final calls = await FlutterCallkitIncoming.activeCalls();
    if (calls is List && calls.isNotEmpty) {
      log('Initial active calls found: $calls');
      for (var call in calls) {
        if (call['accepted'] == true) {
          log('Handling initial accepted call: $call');
          _handleCallAccept(call);
          break;
        }
      }
    }
  }

  Future<void> _handleCallAccept(dynamic body) async {
    if (_isNavigating) return;
    _isNavigating = true;

    final extra = body['extra'];
    if (extra == null) {
      _isNavigating = false;
      return;
    }

    final channelName = extra['channelName'] as String?;
    final callId = extra['callRecordId'] as String?;
    final mediaType = extra['mediaType'] as String?;
    final imageUrl = extra['imageUrl'] as String?;

    if (channelName != null && callId != null && mediaType != null) {
      int retryCount = 0;
      while (navigatorKey.currentContext == null && retryCount < 50) {
        log('Waiting for navigatorKey.currentContext... retry $retryCount');
        await Future.delayed(const Duration(milliseconds: 200));
        retryCount++;
      }

      if (navigatorKey.currentContext != null) {
        final callCubit = Di().sl<CallCubit>();
        callCubit.setIncomingCallData(
          channelName: channelName,
          callId: callId,
          mediaType: mediaType,
          imageUrl: imageUrl ?? "",
        );

        if (mediaType == 'video') {
          navigatorKey.currentContext!.pushRoute(VideoCallRoute());
        } else {
          navigatorKey.currentContext!.pushRoute(AudioCallRoute());
        }
      } else {
        log('Navigator context never became ready.');
      }
    }

    await Future.delayed(const Duration(seconds: 2));
    _isNavigating = false;
  }
}
