import 'package:auto_route/auto_route.dart';
import 'package:fennac_app/app/theme/app_colors.dart';
import 'package:fennac_app/app/theme/text_styles.dart';
import 'package:fennac_app/core/di_container.dart';
import 'package:fennac_app/generated/assets.gen.dart';
import 'package:fennac_app/pages/call/presentation/bloc/cubit/call_cubit.dart';
import 'package:fennac_app/pages/call/presentation/bloc/state/call_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

@RoutePage()
class VideoCallScreen extends StatefulWidget {
  const VideoCallScreen({super.key});

  @override
  State<VideoCallScreen> createState() => _VideoCallScreenState();
}

class _VideoCallScreenState extends State<VideoCallScreen> {
  Duration callDuration = const Duration(minutes: 17, seconds: 42);
  final CallCubit _callCubit = Di().sl<CallCubit>();

  @override
  void initState() {
    super.initState();
    // Initialize Agora with channel and token from API
    _callCubit.initAgora(context);
  }

  @override
  void dispose() {
    _callCubit.endCall();
    super.dispose();
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return '$minutes:$seconds';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<CallCubit, CallState>(
        bloc: _callCubit,
        builder: (context, state) {
          final remoteUid = _callCubit.users.isNotEmpty
              ? _callCubit.users.first
              : null;
          final showRemoteView = remoteUid != null;
          final showLocalMainView = remoteUid == null && !_callCubit.cameraOff;

          return Stack(
            children: [
              Positioned.fill(
                child: showRemoteView
                    ? AgoraVideoView(
                        controller: VideoViewController.remote(
                          rtcEngine: _callCubit.engine,
                          canvas: VideoCanvas(uid: remoteUid),
                          connection: RtcConnection(
                            channelId: _callCubit.channelName ?? 'test',
                          ),
                        ),
                      )
                    : showLocalMainView
                    ? AgoraVideoView(
                        controller: VideoViewController(
                          rtcEngine: _callCubit.engine,
                          canvas: const VideoCanvas(uid: 0),
                        ),
                      )
                    : Container(
                        color: Colors.black87,
                        alignment: Alignment.center,
                        child: Text(
                          'Camera is off',
                          style: AppTextStyles.body(
                            context,
                          ).copyWith(color: Colors.white70),
                        ),
                      ),
              ),

              if (!showRemoteView)
                Positioned(
                  top: 110.h,
                  left: 16.w,
                  right: 16.w,
                  child: Center(
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10.w,
                        vertical: 6.h,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.45),
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Text(
                        'Waiting for participant...',
                        style: AppTextStyles.bodySmall(
                          context,
                        ).copyWith(color: Colors.white),
                      ),
                    ),
                  ),
                ),

              // Gradient overlay for better visibility
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.black.withValues(alpha: 0.3),
                        Colors.transparent,
                        Colors.black.withValues(alpha: 0.6),
                      ],
                      stops: const [0.0, 0.5, 1.0],
                    ),
                  ),
                ),
              ),

              SafeArea(
                child: Column(
                  children: [
                    // Top bar with back button and time
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 8.h,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Back button
                          GestureDetector(
                            onTap: () {
                              _callCubit.endCall();
                              context.router.pop();
                            },
                            child: Container(
                              width: 40.w,
                              height: 40.w,
                              decoration: BoxDecoration(
                                color: Colors.black.withValues(alpha: 0.3),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.keyboard_arrow_down,
                                color: Colors.white,
                                size: 24.sp,
                              ),
                            ),
                          ),
                          // Time display
                          Text(
                            _formatDuration(callDuration),
                            style: AppTextStyles.h4(context).copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          // Placeholder for alignment
                          SizedBox(width: 40.w),
                        ],
                      ),
                    ),

                    const Spacer(),

                    // Bottom controls
                    Padding(
                      padding: EdgeInsets.only(
                        left: 24.w,
                        right: 24.w,
                        bottom: 32.h,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildControlButton(
                            icon: Assets.icons.mic.path,
                            iconOff: Assets.icons.micTurnOff.path,
                            isActive: !_callCubit.muted,
                            onTap: _callCubit.toggleMute,
                          ),
                          SizedBox(width: 16.w),
                          _buildControlButton(
                            icon: Assets.icons.speaker.path,
                            iconOff: Assets.icons.volumeX.path,
                            isActive: _callCubit.speaker,
                            onTap: _callCubit.toggleSpeaker,
                          ),
                          SizedBox(width: 16.w),
                          _buildControlButton(
                            icon: Assets.icons.video.path,
                            iconOff: Assets.icons.videoCut.path,
                            isActive: !_callCubit.cameraOff,
                            onTap: _callCubit.toggleCamera,
                          ),
                          SizedBox(width: 16.w),
                          // End Call button
                          GestureDetector(
                            onTap: () {
                              _callCubit.endCall();
                              context.router.pop();
                            },
                            child: Container(
                              width: 114.w,
                              height: 56.h,
                              decoration: BoxDecoration(
                                color: const Color(0xFFFF4D5E),
                                borderRadius: BorderRadius.circular(32.r),
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color(
                                      0xFFFF4D5E,
                                    ).withValues(alpha: 0.35),
                                    blurRadius: 24,
                                    offset: const Offset(0, 12),
                                  ),
                                ],
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                'End Call',
                                style: AppTextStyles.button(context).copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // Small self-view in top right
              if (showRemoteView)
                Positioned(
                  top: 60.h,
                  right: 16.w,
                  child: Container(
                    width: 100.w,
                    height: 140.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16.r),
                      border: Border.all(
                        color: Colors.white.withValues(alpha: 0.5),
                        width: 2,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.3),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(14.r),
                      child: Stack(
                        children: [
                          Positioned.fill(
                            child: AgoraVideoView(
                              controller: VideoViewController(
                                rtcEngine: _callCubit.engine,
                                canvas: const VideoCanvas(uid: 0),
                              ),
                            ),
                          ),
                          // "You" label
                          Positioned(
                            bottom: 8.h,
                            left: 0,
                            right: 0,
                            child: Center(
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 8.w,
                                  vertical: 4.h,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.black.withValues(alpha: 0.5),
                                  borderRadius: BorderRadius.circular(8.r),
                                ),
                                child: Text(
                                  'You',
                                  style: AppTextStyles.bodySmall(context)
                                      .copyWith(
                                        color: Colors.white,
                                        fontSize: 11.sp,
                                        fontWeight: FontWeight.w500,
                                      ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildControlButton({
    required String icon,
    required String iconOff,
    required bool isActive,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 56.w,
        height: 56.h,
        decoration: BoxDecoration(
          color: isActive ? ColorPalette.primary : ColorPalette.secondary,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: (isActive ? ColorPalette.primary : ColorPalette.secondary)
                  .withValues(alpha: 0.3),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Center(
          child: SvgPicture.asset(
            isActive ? icon : iconOff,
            colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
            width: 24.w,
            height: 24.w,
          ),
        ),
      ),
    );
  }
}
