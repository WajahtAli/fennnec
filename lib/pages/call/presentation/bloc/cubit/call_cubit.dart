import 'dart:async';
import 'dart:developer';
import 'package:auto_route/auto_route.dart';
import 'package:fennac_app/app/app.dart';
import 'package:fennac_app/app/constants/app_constants.dart';
import 'package:fennac_app/app/constants/app_enums.dart';
import 'package:fennac_app/pages/call/domain/usecase/call_usecase.repository.dart';
import 'package:fennac_app/pages/call/presentation/bloc/state/call_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter_callkit_incoming/flutter_callkit_incoming.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:agora_token_service/agora_token_service.dart';

class CallCubit extends Cubit<CallState> {
  final CallUsecase _callUsecase;

  CallCubit(this._callUsecase) : super(CallInitial());

  late RtcEngine engine;
  final users = <int>{};
  bool joined = false;
  bool muted = false;
  bool cameraOff = false;
  bool speaker = false;
  bool loading = true;
  bool isStartingCall = false;
  CallType callType = CallType.audio;
  bool get isStartingAudioCall => isStartingCall && callType == CallType.audio;
  bool get isStartingVideoCall => isStartingCall && callType == CallType.video;
  ClientRoleType role = ClientRoleType.clientRoleBroadcaster;
  String? _token;
  String? channelName;
  String? callId;
  String? callkitId;
  String? imageUrl;
  Duration callDuration = Duration.zero;
  Timer? _durationTimer;
  bool _isEngineReady = false;
  bool _isEndingCall = false;
  bool _hasPoppedAfterLeave = false;
  final int _localUid = DateTime.now().millisecondsSinceEpoch.remainder(
    1000000,
  );

  Future<Map<String, dynamic>?> startCall({
    required String mediaType,
    required String callType,
    required List<String> participantIds,
  }) async {
    this.callType = mediaType == 'video' ? CallType.video : CallType.audio;
    isStartingCall = true;
    emit(CallLoading());

    try {
      final response = await _callUsecase.startCall(
        mediaType: mediaType,
        callType: callType,
        participantIds: participantIds,
      );
      isStartingCall = false;

      // Extract call data from API response
      final data = response['data'] as Map<String, dynamic>?;
      final callRecord = data?['callRecord'] as Map<String, dynamic>?;
      final token = data?['token'] as String?;

      if (callRecord != null) {
        channelName = callRecord['channelName'] as String?;
        callId = callRecord['_id'] as String?;
        _token = token;
      }

      emit(CallLoaded());
      return response;
    } catch (e) {
      isStartingCall = false;
      emit(CallError(e.toString()));
      return null;
    }
  }

  void setIncomingCallData({
    required String channelName,
    required String callId,
    required String mediaType,
    required String imageUrl,
    String? callkitId,
  }) {
    emit(CallLoading());
    this.channelName = channelName;
    this.callId = callId;
    this.callkitId = callkitId;
    this.imageUrl = imageUrl;
    callType = mediaType == 'video' ? CallType.video : CallType.audio;
    role = ClientRoleType.clientRoleBroadcaster;
    emit(CallLoaded());
  }

  bool _isValidUuid(String value) {
    final uuidRegex = RegExp(
      r'^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$',
    );
    return uuidRegex.hasMatch(value);
  }

  Future<void> initAgora(BuildContext context) async {
    log(
      "Initializing Agora with channel: $channelName, callId: $callId, mediaType: ${callType.name}",
    );
    emit(CallLoading());
    users.clear();
    joined = false;
    loading = true;
    _hasPoppedAfterLeave = false;

    await [Permission.microphone, Permission.camera].request();

    engine = createAgoraRtcEngine();
    await engine.initialize(RtcEngineContext(appId: AppConstants.agoraAppId));
    _isEngineReady = true;

    _addEventHandlers(context);

    if (callType == CallType.video) {
      await engine.enableVideo();
      await engine.startPreview();
    } else {
      await engine.enableAudio();
    }

    debugPrint("🎯 User role set to: ${role.name}");

    await engine.setClientRole(role: role);

    final tokenToUse = _resolveAgoraToken();
    final channelToUse = channelName ?? 'test';

    debugPrint("🎯 Joining channel: $channelToUse as $role");

    await engine.joinChannel(
      token: tokenToUse,
      channelId: channelToUse,
      uid: _localUid,
      options: ChannelMediaOptions(clientRoleType: role),
    );
    emit(CallLoaded());
  }

  String _generateToken() {
    final activeChannelName = channelName ?? 'test';
    final token = RtcTokenBuilder.build(
      appId: AppConstants.agoraAppId,
      appCertificate: AppConstants.agoraAppCertificate,
      channelName: activeChannelName,
      uid: _localUid.toString(),
      role: role == ClientRoleType.clientRoleAudience
          ? RtcRole.subscriber
          : RtcRole.publisher,
      expireTimestamp: DateTime.now().millisecondsSinceEpoch ~/ 1000 + 3600,
    );
    return token;
  }

  String _resolveAgoraToken() {
    if (_token != null && _token!.startsWith('007')) {
      return _token!;
    }
    return _generateToken();
  }

  Future<void> toggleMute() async {
    emit(CallLoading());
    muted = !muted;
    await FlutterCallkitIncoming.muteCall(callId ?? "", isMuted: muted);

    if (_isEngineReady) {
      await engine.muteLocalAudioStream(muted);
    }
    emit(CallLoaded());
  }

  Future<void> toggleSpeaker() async {
    emit(CallLoading());

    speaker = !speaker;
    if (_isEngineReady) {
      await engine.setEnableSpeakerphone(speaker);
    }
    emit(CallLoaded());
  }

  Future<void> toggleCamera() async {
    emit(CallLoading());

    cameraOff = !cameraOff;
    if (_isEngineReady) {
      await engine.muteLocalVideoStream(cameraOff);
      if (callType == CallType.video) {
        if (cameraOff) {
          await engine.stopPreview();
        } else {
          await engine.enableVideo();
          await engine.startPreview();
        }
      }
    }
    emit(CallLoaded());
  }

  Future<void> endCall() async {
    if (_isEndingCall) return;
    _isEndingCall = true;
    emit(CallLoading());

    _stopTimer();

    if (callId != null) {
      try {
        await _callUsecase.endCall(callRecordId: callId!);
      } catch (_) {}
    }

    if (_isEngineReady) {
      FlutterCallkitIncoming.endAllCalls();
      await engine.leaveChannel();
      await engine.release();
      _isEngineReady = false;
    }
    joined = false;
    users.clear();
    emit(CallLoaded());
    _isEndingCall = false;
  }

  void _popCallScreen() {
    if (_hasPoppedAfterLeave) return;

    final context = navigatorKey.currentContext;
    if (context == null || !context.mounted) return;

    final router = context.router;
    if (router.canPop()) {
      _hasPoppedAfterLeave = true;
      router.pop();
    }
  }

  void _addEventHandlers(BuildContext context) {
    engine.registerEventHandler(
      RtcEngineEventHandler(
        onJoinChannelSuccess: (RtcConnection conn, int elapsed) {
          emit(CallLoading());

          debugPrint("✅ Local user joined channel: ${conn.channelId}");
          joined = true;
          loading = false;
          _startTimer();
          emit(CallLoaded());
        },
        onUserJoined: (RtcConnection conn, int remoteUid, int elapsed) async {
          emit(CallLoading());
          final callkitConnectionId = callkitId;
          if (callkitConnectionId != null &&
              _isValidUuid(callkitConnectionId)) {
            await FlutterCallkitIncoming.setCallConnected(callkitConnectionId);
          }
          debugPrint("👤 Remote user joined: $remoteUid");
          users.add(remoteUid);
          emit(CallLoaded());
        },
        onUserOffline:
            (RtcConnection conn, int remoteUid, UserOfflineReasonType reason) {
              emit(CallLoading());

              debugPrint("👤 Remote user offline: $remoteUid");
              users.remove(remoteUid);
              emit(CallLoaded());
              if (users.isEmpty) {
                endCall();
              }
            },
        onLeaveChannel: (RtcConnection conn, RtcStats stats) {
          emit(CallLoading());
          debugPrint("🚪 Left channel: ${conn.channelId}");
          joined = false;
          users.clear();
          _stopTimer();
          emit(CallLoaded());
          _popCallScreen();
        },
        onError: (ErrorCodeType code, String msg) {
          debugPrint('⚠️ Agora Error: $code | $msg');
          emit(CallError('Agora Error ($code): $msg'));
        },
      ),
    );
  }

  void _startTimer() {
    emit(CallLoading());
    _durationTimer?.cancel();
    callDuration = Duration.zero;
    _durationTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      emit(CallLoading());

      callDuration = Duration(seconds: timer.tick);
      emit(CallLoaded());
    });
  }

  void _stopTimer() {
    emit(CallLoading());

    _durationTimer?.cancel();
    _durationTimer = null;
    callDuration = Duration.zero;
    emit(CallLoaded());
  }
}
