import 'package:fennac_app/app/constants/app_constants.dart';
import 'package:fennac_app/app/constants/app_enums.dart';
import 'package:fennac_app/pages/call/domain/usecase/call_usecase.repository.dart';
import 'package:fennac_app/pages/call/presentation/bloc/state/call_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:agora_rtc_engine/agora_rtc_engine.dart';
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
  ClientRoleType role = ClientRoleType.clientRoleBroadcaster;
  String? _token;
  String? channelName;
  String? callId;
  bool _isEngineReady = false;
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
  }) {
    this.channelName = channelName;
    this.callId = callId;
    callType = mediaType == 'video' ? CallType.video : CallType.audio;
    emit(CallLoaded());
  }

  // 🔹 Step 1: Initialize Agora engine
  Future<void> initAgora(BuildContext context) async {
    users.clear();
    joined = false;
    loading = true;

    await [Permission.microphone, Permission.camera].request();

    engine = createAgoraRtcEngine();
    await engine.initialize(RtcEngineContext(appId: AppConstants.agoraAppId));
    _isEngineReady = true;

    // Attach event handlers
    _addEventHandlers(context);

    // Enable the proper media mode
    if (callType == CallType.video) {
      await engine.enableVideo();
      await engine.startPreview();
    } else {
      await engine.enableAudio();
    }

    debugPrint("user role is ${role.name}");

    await engine.setClientRole(role: role);

    // Use API token only if it is an Agora RTC token. Backend currently returns
    // LiveKit JWT for this endpoint, which Agora rejects as invalid token.
    final tokenToUse = _resolveAgoraToken();
    final channelToUse = channelName ?? 'test';

    debugPrint("🎯 Joining channel: $channelToUse");

    // Finally join
    await engine.joinChannel(
      token: tokenToUse,
      channelId: channelToUse,
      uid: _localUid,
      options: ChannelMediaOptions(clientRoleType: role),
    );
  }

  // 🔹 Step 2: Generate token (for demo)
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
    // Agora RTC tokens typically start with "007".
    // The backend response currently returns a JWT (LiveKit), so fallback.
    if (_token != null && _token!.startsWith('007')) {
      return _token!;
    }
    return _generateToken();
  }

  Future<void> toggleMute() async {
    muted = !muted;
    if (_isEngineReady) {
      await engine.muteLocalAudioStream(muted);
    }
    emit(CallLoaded());
  }

  Future<void> toggleSpeaker() async {
    speaker = !speaker;
    if (_isEngineReady) {
      await engine.setEnableSpeakerphone(speaker);
    }
    emit(CallLoaded());
  }

  Future<void> toggleCamera() async {
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
    if (_isEngineReady) {
      await engine.leaveChannel();
      await engine.release();
      _isEngineReady = false;
    }
    joined = false;
    users.clear();
    emit(CallLoaded());
  }

  // 🔹 Step 3: Agora event handlers
  void _addEventHandlers(BuildContext context) {
    emit(CallLoading());

    engine.registerEventHandler(
      RtcEngineEventHandler(
        onJoinChannelSuccess: (RtcConnection conn, int elapsed) {
          debugPrint("joined ${conn.channelId}.");
          joined = true;
          loading = false;
          emit(CallLoaded());
        },
        onUserJoined: (RtcConnection conn, int remoteUid, int elapsed) {
          debugPrint("joined $remoteUid");
          users.add(remoteUid);
          emit(CallLoaded());
        },
        onUserOffline:
            (RtcConnection conn, int remoteUid, UserOfflineReasonType reason) {
              users.remove(remoteUid);
              if (users.isEmpty) Navigator.pop(context);
            },
        onLeaveChannel: (RtcConnection conn, RtcStats stats) {
          joined = false;
          users.clear();
          Navigator.pop(context);
          // Navigator.of(context).pushReplacement(
          //   MaterialPageRoute(
          //     builder: (context) => const HomeMain(null, false),
          //   ),
          // );
        },
        onError: (ErrorCodeType code, String msg) {
          debugPrint('⚠️ Agora Error: $code | $msg');
        },
      ),
    );
  }
}
