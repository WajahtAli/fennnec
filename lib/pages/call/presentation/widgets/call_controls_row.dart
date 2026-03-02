import 'package:fennac_app/app/theme/app_colors.dart';
import 'package:fennac_app/generated/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CallControlsRow extends StatefulWidget {
  final VoidCallback onEndCall;

  const CallControlsRow({super.key, required this.onEndCall});

  @override
  State<CallControlsRow> createState() => _CallControlsRowState();
}

class _CallControlsRowState extends State<CallControlsRow> {
  bool isMicOn = true;
  bool isSpeakerOn = false;
  bool isVideoOn = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildControlButton(
          icon: Assets.icons.mic.path,
          iconOff: Assets.icons.micTurnOff.path,
          isActive: isMicOn,
          activeColor: ColorPalette.primary,
          inactiveColor: ColorPalette.secondary,
          onTap: () => setState(() => isMicOn = !isMicOn),
        ),
        _buildControlButton(
          icon: Assets.icons.speaker.path,
          iconOff: Assets.icons.volumeX.path,
          isActive: isSpeakerOn,
          activeColor: ColorPalette.primary,
          inactiveColor: ColorPalette.secondary,
          onTap: () => setState(() => isSpeakerOn = !isSpeakerOn),
        ),
        _buildControlButton(
          icon: Assets.icons.video.path,
          iconOff: Assets.icons.videoCut.path,
          isActive: isVideoOn,
          activeColor: ColorPalette.primary,
          inactiveColor: ColorPalette.secondary,
          onTap: () => setState(() => isVideoOn = !isVideoOn),
        ),
        // End Call Button
        GestureDetector(
          onTap: widget.onEndCall,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 20),
            decoration: BoxDecoration(
              color: ColorPalette.error,
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(
                  color: ColorPalette.error.withValues(alpha: 0.3),
                  blurRadius: 12,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: Text(
              'End Call',
              style: TextStyle(
                color: ColorPalette.white,
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildControlButton({
    required String icon,
    required String iconOff,
    required bool isActive,
    required Color activeColor,
    Color? inactiveColor,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          color: isActive
              ? activeColor
              : (inactiveColor ?? ColorPalette.secondary),
          shape: BoxShape.circle,
        ),
        child: Center(
          child: SvgPicture.asset(
            isActive ? icon : iconOff,
            colorFilter: ColorFilter.mode(ColorPalette.white, BlendMode.srcIn),
            width: 24,
            height: 24,
          ),
        ),
      ),
    );
  }
}
