import 'package:fennac_app/app/constants/app_constants.dart';
import 'package:fennac_app/app/constants/app_enums.dart';
import 'package:fennac_app/pages/call/presentation/bloc/state/call_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:agora_token_service/agora_token_service.dart';

class CallCubit extends Cubit<CallState> {
  CallCubit() : super(CallInitial());

  late RtcEngine engine;
  final users = <int>{};
  bool joined = false;
  bool muted = false;
  bool cameraOff = false;
  bool speaker = false;
  bool loading = true;
  CallType callType = CallType.audio;
  ClientRoleType role = ClientRoleType.clientRoleBroadcaster;
  String? _token;
  final int _localUid = DateTime.now().millisecondsSinceEpoch.remainder(
    1000000,
  );

  // 🔹 Step 1: Initialize Agora engine
  Future<void> initAgora(BuildContext context) async {
    await [Permission.microphone, Permission.camera].request();

    engine = createAgoraRtcEngine();
    await engine.initialize(RtcEngineContext(appId: AppConstants.agoraAppId));

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

    // Generate token
    _token = _generateToken();

    // Finally join
    await engine.joinChannel(
      token: _token ?? "",
      channelId: 'test',
      uid: _localUid,
      options: ChannelMediaOptions(clientRoleType: role),
    );
  }

  // 🔹 Step 2: Generate token (for demo)
  String _generateToken() {
    final token = RtcTokenBuilder.build(
      appId: AppConstants.agoraAppId,
      appCertificate: AppConstants.agoraAppCertificate,
      channelName: 'test',
      uid: "0",
      role: role == ClientRoleType.clientRoleAudience
          ? RtcRole.subscriber
          : RtcRole.publisher,
      expireTimestamp: DateTime.now().millisecondsSinceEpoch ~/ 1000 + 3600,
    );
    return token;
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
