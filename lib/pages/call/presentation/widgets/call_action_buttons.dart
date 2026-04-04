import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../app/constants/app_enums.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/text_styles.dart';
import '../../../../core/di_container.dart';
import '../../../../generated/assets.gen.dart';
import '../bloc/cubit/call_cubit.dart';

class CallActionButtons extends StatelessWidget {
  const CallActionButtons({super.key});

  @override
  Widget build(BuildContext context) {
    final CallCubit callCubit = Di().sl<CallCubit>();

    return BlocBuilder(
      bloc: callCubit,
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildControlButton(
              icon: Assets.icons.mic.path,
              icon1: Assets.icons.micTurnOff.path,
              isActive: !callCubit.muted,
              activeColor: ColorPalette.primary,
              inactiveColor: ColorPalette.secondary,
              onTap: callCubit.toggleMute,
            ),
            SizedBox(width: 16.w),
            _buildControlButton(
              icon: Assets.icons.speaker.path,
              icon1: Assets.icons.volumeX.path,
              isActive: callCubit.speaker,
              activeColor: ColorPalette.primary,
              inactiveColor: ColorPalette.secondary,
              onTap: callCubit.toggleSpeaker,
            ),
            SizedBox(width: 16.w),
            _buildControlButton(
              icon: Assets.icons.video.path,
              icon1: Assets.icons.videoCut.path,
              isActive: !callCubit.cameraOff,
              activeColor: ColorPalette.primary,
              inactiveColor: ColorPalette.secondary,
              onTap: () {
                if (callCubit.callType == CallType.audio) {
                  callCubit.switchToVideoCall();
                } else {
                  callCubit.switchToAudioCall();
                }
              },
            ),
            SizedBox(width: 16.w),
            GestureDetector(
              onTap: () {
                callCubit.endCall();
              },
              child: Container(
                width: 114.w,
                height: 56,
                decoration: BoxDecoration(
                  color: const Color(0xFFFF4D5E),
                  borderRadius: BorderRadius.circular(32.r),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFFFF4D5E).withValues(alpha: 0.35),
                      blurRadius: 24,
                      offset: const Offset(0, 12),
                    ),
                  ],
                ),
                alignment: Alignment.center,
                child: Text('End Call', style: AppTextStyles.button(context)),
              ),
            ),
          ],
        );
      },
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
}
