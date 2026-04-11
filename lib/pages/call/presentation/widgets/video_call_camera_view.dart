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
        final users = _callCubit.users.toList(growable: false);

        if (users.isEmpty) {
          if (!_callCubit.isEngineReady ||
              !_callCubit.isLocalVideoActive ||
              _localController == null) {
            return _buildVideoFallback(
              message: _callCubit.isVideoCallActive
                  ? 'Waiting for video...'
                  : 'Connecting call...',
            );
          }

          return AgoraVideoView(controller: _localController!);
        }

        if (users.length == 1) {
          return _buildParticipantView(users.first, _callCubit);
        }

        if (users.length == 2) {
          return Column(
            children: users.map((uid) {
              return Expanded(child: _buildParticipantView(uid, _callCubit));
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
            return _buildParticipantView(users[index], _callCubit);
          },
        );
      },
    );
  }

  Widget _buildParticipantView(int uid, CallCubit callCubit) {
    final isMuted = callCubit.remoteAudioState[uid] == false;
    final isRemoteVideoActive = callCubit.remoteVideoState[uid] == true;

    return Stack(
      children: [
        Positioned.fill(
          child: isRemoteVideoActive
              ? AgoraVideoView(
                  controller: VideoViewController.remote(
                    rtcEngine: callCubit.engine,
                    canvas: VideoCanvas(uid: uid),
                    connection: RtcConnection(
                      channelId: callCubit.channelName ?? 'test',
                    ),
                  ),
                )
              : _buildVideoFallback(message: 'Camera is off'),
        ),
        if (isMuted)
          Positioned(
            bottom: 12,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.5),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.mic_off_rounded, color: Colors.white, size: 14),
                    SizedBox(width: 4),
                    Text(
                      'Muted',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildVideoFallback({required String message}) {
    final imageUrl = _callCubit.imageUrl;

    return Stack(
      fit: StackFit.expand,
      children: [
        if (imageUrl?.isNotEmpty == true)
          Image.network(
            imageUrl!,
            fit: BoxFit.cover,
            errorBuilder: (_, _, _) => Container(color: Colors.black87),
          )
        else
          Container(color: Colors.black87),
        Container(color: Colors.black.withValues(alpha: 0.5)),
        Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.videocam_off_rounded,
                color: Colors.white70,
                size: 34,
              ),
              const SizedBox(height: 12),
              Text(
                message,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
