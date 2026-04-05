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

  static const Uuid _uuid = Uuid();

  bool _isNavigating = false;

  void init() {
    FlutterCallkitIncoming.onEvent.listen(_onCallEvent);
    _checkInitialCallAccept();
  }

  static Future<void> handleCallNotification(RemoteMessage message) async {
    final data = message.data;
    final callId = data['callRecordId'] ?? const Uuid().v4();
    final callkitId = _uuid.v4();
    final callerName =
        message.notification?.body ?? data['senderName'] ?? "Incoming Call";
    final callerNumber = (data['callerId'] as String? ?? '').isNotEmpty
        ? data['callerId'] as String
        : callerName;
    final mediaType = data['mediaType'] ?? "audio";
    final imageUrl = data['imageUrl'] ?? "";

    final params = CallKitParams(
      id: callkitId,
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
        isShowCallback: false,
        subtitle: 'Missed call',
        callbackText: 'Call back',
      ),
      extra: <String, dynamic>{
        'callkitId': callkitId,
        'channelName': data['channelName'],
        'callRecordId': callId,
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
        iconName: 'CallKitLogo',
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

  Future<void> handleBridgeAccept(Map<String, dynamic> body) async {
    await _handleCallAccept(body);
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
        Di().sl<CallCubit>().callId = event.body['callRecordId'];
        Di().sl<CallCubit>().endCall();
        FlutterCallkitIncoming.endAllCalls();
        break;
      case Event.actionCallEnded:
        log('Call Ended: ${event.body}');
        _isNavigating = false;
        Di().sl<CallCubit>().endCall();
        FlutterCallkitIncoming.endAllCalls();
        break;
      case Event.actionCallTimeout:
        log('Call Timeout: ${event.body}');
        _isNavigating = false;
        Di().sl<CallCubit>().callId = event.body['callRecordId'];
        Di().sl<CallCubit>().endCall();
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

    final normalizedBody = _asStringDynamicMap(body) ?? <String, dynamic>{};
    final extra = _extractPayload(normalizedBody);
    if (extra == null) {
      log('Call accept payload missing required data: $body');
      _isNavigating = false;
      return;
    }

    final channelName = _pickString(extra, const ['channelName']);
    final callId = _pickString(extra, const ['callRecordId', 'callId', '_id']);
    final mediaType = _pickString(extra, const ['mediaType', 'type']);
    final imageUrl = _pickString(extra, const ['imageUrl', 'avatar']) ?? '';
    final callkitId = _pickString(normalizedBody, const [
      'id',
      'uuid',
      'callkitId',
    ]);

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
          imageUrl: imageUrl,
          callkitId: callkitId,
        );

        // if (mediaType == 'video') {
        //   navigatorKey.currentContext!.pushRoute(VideoCallRoute());
        // } else {
        navigatorKey.currentContext!.pushRoute(AudioCallRoute());
        // }
      } else {
        log('Navigator context never became ready.');
      }
    }

    await Future.delayed(const Duration(seconds: 2));
    _isNavigating = false;
  }

  Map<String, dynamic>? _extractPayload(Map<String, dynamic> body) {
    final extraMap = _asStringDynamicMap(body['extra']);
    if (extraMap != null &&
        _pickString(extraMap, const ['channelName']) != null &&
        _pickString(extraMap, const ['callRecordId', 'callId', '_id']) !=
            null) {
      return extraMap;
    }

    final dataMap = _asStringDynamicMap(body['data']);
    if (dataMap != null) {
      return dataMap;
    }

    if (_pickString(body, const ['channelName']) != null &&
        _pickString(body, const ['callRecordId', 'callId', '_id']) != null) {
      return body;
    }

    return null;
  }

  Map<String, dynamic>? _asStringDynamicMap(dynamic value) {
    if (value is Map) {
      return Map<String, dynamic>.from(value);
    }
    return null;
  }

  String? _pickString(Map<String, dynamic> map, List<String> keys) {
    for (final key in keys) {
      final value = map[key];
      if (value == null) continue;
      final normalized = value.toString();
      if (normalized.isNotEmpty) return normalized;
    }
    return null;
  }

  // if the user started the call show the outgoing call notification
  static Future<void> showOutgoingCallNotification({
    required String callId,
    required String channelName,
    required String callerName,
    required String mediaType,
    String? imageUrl,
  }) async {
    final callkitId = _uuid.v4();
    final params = CallKitParams(
      id: callkitId,
      nameCaller: callerName,
      appName: 'Fennac',
      avatar: imageUrl,
      handle: callerName,
      type: mediaType == 'video' ? 1 : 0,
      duration: 30000,
      textAccept: 'Accept',
      textDecline: 'Decline',
      missedCallNotification: const NotificationParams(
        showNotification: true,
        isShowCallback: false,
        subtitle: 'Missed call',
        callbackText: 'Call back',
      ),
      extra: <String, dynamic>{
        'callkitId': callkitId,
        'channelName': channelName,
        'callRecordId': callId,
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
        iconName: 'CallKitLogo',
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
    await FlutterCallkitIncoming.startCall(params);
  }
}
