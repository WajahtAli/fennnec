import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:fennac_app/core/di_container.dart';
import 'package:fennac_app/pages/call/presentation/bloc/cubit/call_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/state/call_state.dart';

class VideoCallCameraView extends StatefulWidget {
  const VideoCallCameraView({super.key});

  @override
  State<VideoCallCameraView> createState() => _VideoCallCameraViewState();
}

class _VideoCallCameraViewState extends State<VideoCallCameraView> {
  late final CallCubit _callCubit;
  VideoViewController? _localController;

  @override
  void initState() {
    super.initState();
    _callCubit = Di().sl<CallCubit>();
  }

  void _initLocalController() {
    if (!_callCubit.isEngineReady || _localController != null) return;
    _localController = VideoViewController(
      rtcEngine: _callCubit.engine,
      canvas: const VideoCanvas(
        uid: 0,
        renderMode: RenderModeType.renderModeHidden,
      ),
    );
  }

  @override
  void dispose() {
    _localController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CallCubit, CallState>(
      bloc: _callCubit,
      builder: (context, state) {
        _initLocalController();
        final users = _callCubit.users;

        if (users.isEmpty) {
          if (!_callCubit.isEngineReady ||
              _callCubit.cameraOff ||
              _localController == null) {
            return Container(color: Colors.black87);
          }

          return AgoraVideoView(controller: _localController!);
        }

        if (users.length == 1) {
          return _buildVideo(users.first, _callCubit);
        }

        if (users.length == 2) {
          return Column(
            children: users.map((uid) {
              return Expanded(child: _buildVideo(uid, _callCubit));
            }).toList(),
          );
        }

        return GridView.builder(
          itemCount: users.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 5,
            mainAxisSpacing: 5,
            childAspectRatio: 1,
          ),
          itemBuilder: (context, index) {
            return _buildVideo(users.elementAt(index), _callCubit);
          },
        );
      },
    );
  }

  Widget _buildVideo(int uid, CallCubit callCubit) {
    return AgoraVideoView(
      controller: VideoViewController.remote(
        rtcEngine: callCubit.engine,
        canvas: VideoCanvas(uid: uid),
        connection: RtcConnection(channelId: callCubit.channelName ?? 'test'),
      ),
    );
  }
}
