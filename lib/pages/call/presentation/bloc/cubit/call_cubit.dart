import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:auto_route/auto_route.dart';
import 'package:fennac_app/app/app.dart';
import 'package:fennac_app/app/constants/app_constants.dart';
import 'package:fennac_app/app/constants/app_enums.dart';
import 'package:fennac_app/pages/call/domain/usecase/call_usecase.repository.dart';
import 'package:fennac_app/pages/call/presentation/helpers/call_pip_overlay_controller.dart';
import 'package:fennac_app/pages/call/presentation/bloc/state/call_state.dart';
import 'package:fennac_app/routes/routes_imports.gr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter_callkit_incoming/flutter_callkit_incoming.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:agora_token_service/agora_token_service.dart';
import 'package:pip/pip.dart';

import '../../../../../core/notifications/call_notification_handler.dart';

class CallCubit extends Cubit<CallState> {
  final CallUsecase _callUsecase;
  final Pip _pip = Pip();

  CallCubit(this._callUsecase) : super(CallInitial()) {
    unawaited(
      _pip.registerStateChangedObserver(
        PipStateChangedObserver(
          onPipStateChanged: _handleSystemPipStateChanged,
        ),
      ),
    );
  }

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
  bool get isEngineReady => _isEngineReady;
  bool isCallMinimized = false;
  bool isSystemPipActive = false;
  bool _isEndingCall = false;
  bool _hasPoppedAfterLeave = false;
  final int localUid = DateTime.now().millisecondsSinceEpoch.remainder(1000000);
  bool get hasOngoingCall => _isEngineReady || callId != null || joined;
  String get callStatusLabel {
    final isCallConnecting = !joined && loading;
    final isCallRinging = joined && !loading && users.isEmpty;
    if (users.isNotEmpty) {
      return _formatDuration(callDuration);
    }
    if (isCallConnecting) {
      return 'Connecting...';
    }
    if (isCallRinging) {
      return 'Ringing...';
    }
    return 'Call';
  }

  Future<Map<String, dynamic>?> startCall({
    required String mediaType,
    required String callType,
    required List<String> participantIds,
    String? callerImageUrl,
  }) async {
    this.callType = mediaType == 'video' ? CallType.video : CallType.audio;
    cameraOff = this.callType == CallType.audio;
    imageUrl = callerImageUrl;
    isCallMinimized = false;
    isSystemPipActive = false;
    CallPipOverlayController.hide();
    isStartingCall = true;
    emit(CallLoading());

    try {
      final response = await _callUsecase.startCall(
        mediaType: mediaType,
        callType: callType,
        participantIds: participantIds,
      );
      isStartingCall = false;

      final data = response['data'] as Map<String, dynamic>?;
      final callRecord = data?['callRecord'] as Map<String, dynamic>?;
      final token = data?['token'] as String?;

      if (callRecord != null) {
        channelName = callRecord['channelName'] as String?;
        callId = callRecord['_id'] as String?;
        _token = token;
      }

      emit(CallLoaded());
      CallNotificationHandler.showOutgoingCallNotification(
        callId: callId ?? '',
        channelName: channelName ?? '',
        callerName: 'Outgoing ${this.callType.name} call',
        mediaType: mediaType,
        imageUrl: callerImageUrl,
      );
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
    cameraOff = callType == CallType.audio;
    isCallMinimized = false;
    isSystemPipActive = false;
    CallPipOverlayController.hide();
    role = ClientRoleType.clientRoleBroadcaster;
    emit(CallLoaded());
  }

  bool _isValidUuid(String value) {
    final uuidRegex = RegExp(
      r'^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$',
    );
    return uuidRegex.hasMatch(value);
  }

  Future<void> initAgora() async {
    if (_isEngineReady) {
      loading = false;
      emit(CallLoaded());
      return;
    }

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

    _addEventHandlers();

    if (callType == CallType.video) {
      cameraOff = false;
      await engine.enableVideo();
      await engine.startPreview();
      await engine.muteLocalVideoStream(false);
    } else {
      cameraOff = true;
      await engine.muteLocalVideoStream(true);
      await engine.stopPreview();
      await engine.disableVideo();
    }

    debugPrint("🎯 User role set to: ${role.name}");

    await engine.setClientRole(role: role);

    final tokenToUse = _resolveAgoraToken();
    final channelToUse = channelName ?? 'test';

    debugPrint("🎯 Joining channel: $channelToUse as $role");

    await engine.joinChannel(
      token: tokenToUse,
      channelId: channelToUse,
      uid: localUid,
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
      uid: localUid.toString(),
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

      if (!cameraOff) {
        await engine.startPreview();
      } else {
        await engine.stopPreview();
      }
    }

    emit(CallLoaded());
  }

  Future<void> switchToVideoCall() async {
    if (callType == CallType.video) return;

    emit(CallLoading());

    callType = CallType.video;
    cameraOff = false;

    if (_isEngineReady) {
      await engine.enableVideo();
      await engine.startPreview();
      await engine.muteLocalVideoStream(false);
    }

    emit(CallLoaded());
  }

  Future<void> switchToAudioCall() async {
    if (callType == CallType.audio) return;

    emit(CallLoading());

    callType = CallType.audio;
    cameraOff = true;

    if (_isEngineReady) {
      await engine.muteLocalVideoStream(true);
      await engine.stopPreview();
      await engine.disableVideo();
    }

    emit(CallLoaded());
  }

  bool isFrontCamera = true;

  Future<void> switchCamera() async {
    if (!_isEngineReady || callType != CallType.video || cameraOff) return;
    emit(CallLoading());
    isFrontCamera = !isFrontCamera;
    await engine.switchCamera();
    emit(CallLoaded());
  }

  Future<void> endCall() async {
    if (_isEndingCall) return;
    _isEndingCall = true;
    isCallMinimized = false;
    isSystemPipActive = false;
    CallPipOverlayController.hide();
    emit(CallLoading());

    _stopTimer();

    try {
      await _pip.stop();
    } catch (_) {}

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

  bool isLocalVideoEnabled = false;
  bool isRemoteVideoEnabled = false;

  Future<bool> minimizeCallToPip() async {
    if (!hasOngoingCall || _isEndingCall) return false;

    if (Platform.isAndroid) {
      final isSupported = await _pip.isSupported();

      if (isSupported) {
        final setupSucceeded = await _pip.setup(
          PipOptions(
            aspectRatioX: 9,
            aspectRatioY: 16,
            seamlessResizeEnabled: true,
          ),
        );

        final enteredSystemPip = setupSucceeded ? await _pip.start() : false;

        if (enteredSystemPip) {
          isSystemPipActive = true;
          isCallMinimized = false;
          CallPipOverlayController.hide();
          emit(CallLoaded());
          return false;
        }
      }
    }

    isCallMinimized = true;
    isSystemPipActive = false;
    CallPipOverlayController.show();
    emit(CallLoaded());
    return true;
  }

  void restoreCallFromPip() {
    if (!isCallMinimized) return;
    isCallMinimized = false;
    isSystemPipActive = false;
    CallPipOverlayController.hide();
    emit(CallLoaded());

    final context = navigatorKey.currentContext;
    if (context == null) return;

    context.pushRoute(const AudioCallRoute());
  }

  void handleCallScreenDisposed() {
    if (isCallMinimized || _isEndingCall) return;
    unawaited(endCall());
  }

  void _handleSystemPipStateChanged(PipState state, String? error) {
    if (state == PipState.pipStateStarted) {
      isSystemPipActive = true;
      isCallMinimized = false;
      CallPipOverlayController.hide();
      emit(CallLoaded());
      return;
    }

    if (state == PipState.pipStateStopped || state == PipState.pipStateFailed) {
      isSystemPipActive = false;
    }

    emit(CallLoaded());
  }

  void _addEventHandlers() {
    engine.registerEventHandler(
      RtcEngineEventHandler(
        onJoinChannelSuccess: (RtcConnection conn, int elapsed) {
          emit(CallLoading());
          debugPrint("✅ Local user joined channel: ${conn.channelId}");
          resetCallActions();
          joined = true;
          loading = false;
          emit(CallLoaded());
        },
        onUserJoined: (RtcConnection conn, int remoteUid, int elapsed) async {
          emit(CallLoading());
          final callkitConnectionId = callkitId;
          if (callkitConnectionId != null &&
              _isValidUuid(callkitConnectionId)) {
            await FlutterCallkitIncoming.setCallConnected(callkitConnectionId);
          }
          _startTimer();
          debugPrint("👤 Remote user joined: $remoteUid");
          users.add(remoteUid);
          emit(CallLoaded());
        },
        onRemoteVideoStateChanged:
            (connection, remoteUid, state, reason, elapsed) async {
              final isVideoActive =
                  state == RemoteVideoState.remoteVideoStateStarting ||
                  state == RemoteVideoState.remoteVideoStateDecoding;

              isRemoteVideoEnabled = isVideoActive;

              if (isVideoActive && callType == CallType.audio) {
                debugPrint("📹 Remote enabled video → upgrading call");
                await switchToVideoCall();
              }

              if (!isVideoActive && callType == CallType.video) {
                debugPrint("📵 Remote disabled video → switching to audio");
                await switchToAudioCall();
              }
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

  // reset call actions
  void resetCallActions() {
    emit(CallLoading());
    muted = false;
    cameraOff = callType == CallType.audio;
    speaker = false;
    emit(CallLoaded());
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return '$minutes:$seconds';
  }

  double selfViewTop = 80;
  double selfViewLeft = 250;
  bool isSelfViewDragging = false;

  void updateSelfViewPosition({
    required double left,
    required double top,
    required bool isDragging,
  }) {
    emit(CallLoading());
    selfViewLeft = left;
    selfViewTop = top;
    isSelfViewDragging = isDragging;
    emit(CallLoaded());
  }

  void snapToNearestCorner({
    required Size screenSize,
    required double widgetWidth,
    required double widgetHeight,
    required EdgeInsets safeAreaPadding,
  }) {
    emit(CallLoading());
    isSelfViewDragging = false;

    final double leftLimit = safeAreaPadding.left + 16;
    final double rightLimit =
        screenSize.width - widgetWidth - safeAreaPadding.right - 16;
    final double topLimit = safeAreaPadding.top + 80;
    final double bottomLimit =
        screenSize.height - widgetHeight - safeAreaPadding.bottom - 120;

    final bool isOnLeftSide = selfViewLeft < (screenSize.width / 2);
    final bool isOnTopSide = selfViewTop < (screenSize.height / 2);

    if (isOnLeftSide) {
      selfViewLeft = leftLimit;
    } else {
      selfViewLeft = rightLimit;
    }

    if (isOnTopSide) {
      selfViewTop = topLimit;
    } else {
      selfViewTop = bottomLimit;
    }

    emit(CallLoaded());
  }
}
