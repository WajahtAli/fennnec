import 'dart:math' as math;

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../app/constants/app_enums.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/text_styles.dart';
import '../../../../core/di_container.dart';
import '../bloc/cubit/call_cubit.dart';
import '../bloc/state/call_state.dart';

class CallPipOverlay extends StatefulWidget {
  const CallPipOverlay({super.key});

  @override
  State<CallPipOverlay> createState() => _CallPipOverlayState();
}

class _CallPipOverlayState extends State<CallPipOverlay> {
  static const double _cardWidth = 140;
  static const double _cardHeight = 196;

  late final CallCubit _callCubit;
  VideoViewController? _localController;
  Offset _offset = const Offset(16, 110);

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
    return IgnorePointer(
      ignoring: false,
      child: Material(
        color: Colors.transparent,
        child: BlocBuilder<CallCubit, CallState>(
          bloc: _callCubit,
          builder: (context, state) {
            _initLocalController();

            final media = MediaQuery.of(context);
            final safeTop = media.padding.top + 12;
            final maxLeft = math.max(12.0, media.size.width - _cardWidth - 12);
            final maxTop = math.max(
              safeTop,
              media.size.height - _cardHeight - media.padding.bottom - 24,
            );

            final left = _offset.dx.clamp(12.0, maxLeft);
            final top = _offset.dy.clamp(safeTop, maxTop);

            return Stack(
              children: [
                Positioned(
                  left: left,
                  top: top,
                  child: GestureDetector(
                    onTap: _callCubit.restoreCallFromPip,
                    onPanUpdate: (details) {
                      setState(() {
                        _offset = Offset(
                          (_offset.dx + details.delta.dx).clamp(12.0, maxLeft),
                          (_offset.dy + details.delta.dy).clamp(
                            safeTop,
                            maxTop,
                          ),
                        );
                      });
                    },
                    child: Container(
                      width: _cardWidth,
                      height: _cardHeight,
                      decoration: BoxDecoration(
                        color: ColorPalette.black,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: Colors.white.withValues(alpha: 0.12),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.35),
                            blurRadius: 20,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Column(
                          children: [
                            Expanded(child: _buildPreview()),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 8,
                              ),
                              color: Colors.black.withValues(alpha: 0.88),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      _callCubit.callStatusLabel,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: AppTextStyles.bodySmall(context)
                                          .copyWith(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600,
                                          ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: _callCubit.endCall,
                                    child: Container(
                                      width: 26,
                                      height: 26,
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFFF4D5E),
                                        borderRadius: BorderRadius.circular(13),
                                      ),
                                      child: const Icon(
                                        Icons.call_end_rounded,
                                        color: Colors.white,
                                        size: 15,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildPreview() {
    if (_callCubit.callType == CallType.video) {
      final remoteUid = _callCubit.users.isNotEmpty
          ? _callCubit.users.first
          : null;

      if (remoteUid != null) {
        return AgoraVideoView(
          controller: VideoViewController.remote(
            rtcEngine: _callCubit.engine,
            canvas: VideoCanvas(uid: remoteUid),
            connection: RtcConnection(
              channelId: _callCubit.channelName ?? 'test',
            ),
          ),
        );
      }

      if (!_callCubit.cameraOff && _localController != null) {
        return AgoraVideoView(controller: _localController!);
      }
    }

    return Container(
      color: Colors.black87,
      alignment: Alignment.center,
      child: _callCubit.imageUrl?.isNotEmpty == true
          ? Image.network(
              _callCubit.imageUrl!,
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.cover,
            )
          : Icon(
              _callCubit.callType == CallType.video
                  ? Icons.videocam_off_rounded
                  : Icons.call_rounded,
              color: Colors.white54,
              size: 34,
            ),
    );
  }
}
