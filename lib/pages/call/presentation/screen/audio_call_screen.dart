import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:auto_route/auto_route.dart';
import 'package:fennac_app/app/theme/app_colors.dart';
import 'package:fennac_app/app/theme/text_styles.dart';
import 'package:fennac_app/core/di_container.dart';
import 'package:fennac_app/generated/assets.gen.dart';
import 'package:fennac_app/pages/call/presentation/bloc/cubit/call_cubit.dart';
import 'package:fennac_app/widgets/custom_sized_box.dart';
import 'package:fennac_app/widgets/custom_text.dart';
import 'package:fennac_app/widgets/movable_background.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

@RoutePage()
class AudioCallScreen extends StatefulWidget {
  const AudioCallScreen({super.key});

  @override
  State<AudioCallScreen> createState() => _AudioCallScreenState();
}

class _AudioCallScreenState extends State<AudioCallScreen> {
  Duration callDuration = const Duration(minutes: 17, seconds: 42);
  bool isMicOn = true;
  bool isSpeakerOn = false;
  bool isVideoOn = false;
  final CallCubit _callCubit = Di().sl<CallCubit>();

  @override
  void initState() {
    super.initState();
    // Start timer to update call duration
    // In a real app, you'd use a proper timer or stream
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
      body: MovableBackground(
        backgroundType: MovableBackgroundType.dark,
        child: SafeArea(
          child: Stack(
            children: [
              Column(
                children: [
                  const SizedBox(height: 24),
                  // Call duration and chevron
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            context.router.pop();
                            context.router.pop();
                          },
                          child: Container(
                            width: 32.w,
                            height: 32.w,
                            decoration: BoxDecoration(
                              color: Colors.black.withValues(alpha: 0.3),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.keyboard_arrow_down,
                              color: Colors.white,
                              size: 20.sp,
                            ),
                          ),
                        ),
                        AppText(
                          text: _formatDuration(callDuration),
                          style: AppTextStyles.body(
                            context,
                          ).copyWith(color: Colors.white, fontSize: 16.sp),
                        ),
                        CustomSizedBox(width: 30),
                      ],
                    ),
                  ),
                  SizedBox(height: 200.h),
                  // Profile picture
                  Center(
                    child: Container(
                      width: 120.w,
                      height: 120.w,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.white.withValues(alpha: 0.2),
                          width: 2,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.35),
                            blurRadius: 16,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: ClipOval(
                        child: Image.asset(
                          Assets.images.girlsGroup.path,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 12.h),
                  // Name
                  AppText(
                    text: 'Anna',
                    style: AppTextStyles.body(
                      context,
                    ).copyWith(color: ColorPalette.textSecondary),
                  ),
                  const Spacer(),
                  SizedBox(height: 120.h),
                ],
              ),

              // Control buttons at bottom
              Positioned(
                left: 24.w,
                right: 24.w,
                bottom: 32.h,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // Microphone button (active - purple)
                    _buildControlButton(
                      icon: Assets.icons.mic.path,
                      icon1: Assets.icons.micTurnOff.path,
                      isActive: isMicOn,
                      activeColor: ColorPalette.primary,
                      inactiveColor: ColorPalette.secondary,
                      onTap: () {
                        setState(() {
                          isMicOn = !isMicOn;
                        });
                      },
                    ),
                    SizedBox(width: 16.w),
                    // Speaker button (muted - dark purple)
                    _buildControlButton(
                      icon: Assets.icons.speaker.path,
                      icon1: Assets.icons.volumeX.path,
                      isActive: isSpeakerOn,
                      activeColor: ColorPalette.primary,
                      inactiveColor: ColorPalette.secondary,
                      onTap: () {
                        setState(() {
                          isSpeakerOn = !isSpeakerOn;
                        });
                      },
                    ),
                    SizedBox(width: 16.w),
                    // Video button (off - dark purple)
                    _buildControlButton(
                      icon: Assets.icons.video.path,
                      icon1: Assets.icons.videoCut.path,
                      isActive: isVideoOn,
                      activeColor: ColorPalette.primary,
                      inactiveColor: ColorPalette.secondary,
                      onTap: () {
                        setState(() {
                          isVideoOn = !isVideoOn;
                        });
                      },
                    ),
                    SizedBox(width: 16.w),
                    // End Call button (red, larger)
                    GestureDetector(
                      onTap: () {
                        context.router.pop();
                        context.router.pop();
                      },
                      child: Container(
                        width: 114.w,
                        height: 56,
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
                          style: AppTextStyles.button(context),
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
    );
  }

  Widget _buildControlButton({
    required String icon,
    required String icon1,
    required bool isActive,
    required Color activeColor,
    Color? inactiveColor,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 56.w,
        height: 56.w,
        decoration: BoxDecoration(
          color: isActive
              ? activeColor
              : (inactiveColor ?? ColorPalette.secondary),
          shape: BoxShape.circle,
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            SvgPicture.asset(
              isActive ? icon : icon1,
              colorFilter: const ColorFilter.mode(
                Colors.white,
                BlendMode.srcIn,
              ),
              width: 24.w,
              height: 24.w,
            ),
          ],
        ),
      ),
    );
  }

  // 🔹 Step 4: Build UI for local and remote views
  List<Widget> _buildVideoViews() {
    final List<Widget> views = [];

    // Local view (broadcaster)
    if (_callCubit.role == ClientRoleType.clientRoleBroadcaster) {
      views.add(
        AgoraVideoView(
          controller: VideoViewController(
            rtcEngine: _callCubit.engine,
            canvas: VideoCanvas(uid: 0),
          ),
        ),
      );
    }

    // Remote users
    for (var uid in _callCubit.users) {
      views.add(
        AgoraVideoView(
          controller: VideoViewController.remote(
            rtcEngine: _callCubit.engine,
            canvas: VideoCanvas(uid: uid),
            connection: RtcConnection(channelId: 'test'),
          ),
        ),
      );
    }
    return views;
  }
}
