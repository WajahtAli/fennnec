import 'package:auto_route/auto_route.dart';
import 'package:fennac_app/app/theme/app_colors.dart';
import 'package:fennac_app/app/theme/text_styles.dart';
import 'package:fennac_app/generated/assets.gen.dart';
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
  bool isMicOn = true;
  bool isSpeakerOn = true;
  bool isVideoOn = true;

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return '$minutes:$seconds';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Main video feed (full screen)
          Positioned.fill(
            child: Image.asset(
              Assets.images.girlsGroup.path,
              fit: BoxFit.cover,
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
                        onTap: () => context.router.pop(),
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
                      // Microphone button
                      _buildControlButton(
                        icon: Assets.icons.mic.path,
                        iconOff: Assets.icons.micTurnOff.path,
                        isActive: isMicOn,
                        onTap: () {
                          setState(() {
                            isMicOn = !isMicOn;
                          });
                        },
                      ),
                      SizedBox(width: 16.w),
                      // Speaker/Volume button
                      _buildControlButton(
                        icon: Assets.icons.speaker.path,
                        iconOff: Assets.icons.volumeX.path,
                        isActive: isSpeakerOn,
                        onTap: () {
                          setState(() {
                            isSpeakerOn = !isSpeakerOn;
                          });
                        },
                      ),
                      SizedBox(width: 16.w),
                      // Video button
                      _buildControlButton(
                        icon: Assets.icons.video.path,
                        iconOff: Assets.icons.videoCut.path,
                        isActive: isVideoOn,
                        onTap: () {
                          setState(() {
                            isVideoOn = !isVideoOn;
                          });
                        },
                      ),
                      SizedBox(width: 16.w),
                      // End Call button
                      GestureDetector(
                        onTap: () {
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
                      child: Image.asset(
                        Assets.images.girlsGroup.path,
                        fit: BoxFit.cover,
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
                            style: AppTextStyles.bodySmall(context).copyWith(
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
