import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../app/theme/text_styles.dart';
import '../../../../core/di_container.dart';
import '../bloc/cubit/call_cubit.dart';
import '../bloc/state/call_state.dart';

class SelfVideoWidget extends StatefulWidget {
  const SelfVideoWidget({super.key});

  @override
  State<SelfVideoWidget> createState() => _SelfVideoWidgetState();
}

class _SelfVideoWidgetState extends State<SelfVideoWidget> {
  late final CallCubit _callCubit;
  VideoViewController? _controller;

  @override
  void initState() {
    super.initState();
    _callCubit = Di().sl<CallCubit>();
  }

  void _initController() {
    if (!_callCubit.isEngineReady || _controller != null) return;
    _controller = VideoViewController(
      rtcEngine: _callCubit.engine,
      canvas: const VideoCanvas(
        uid: 0,
        renderMode: RenderModeType.renderModeHidden,
      ),
    );
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CallCubit, CallState>(
      bloc: _callCubit,
      builder: (context, state) {
        _initController();

        return Container(
          width: 100.w,
          height: 140.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.r),
            color: Colors.black,
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
                // Video preview — only when camera is on
                if (_callCubit.isEngineReady &&
                    !_callCubit.cameraOff &&
                    _controller != null)
                  Positioned.fill(
                    child: AgoraVideoView(controller: _controller!),
                  )
                else
                  Positioned.fill(
                    child: Container(
                      color: Colors.black87,
                      alignment: Alignment.center,
                      child: Icon(
                        Icons.videocam_off_rounded,
                        color: Colors.white38,
                        size: 28.sp,
                      ),
                    ),
                  ),

                // Camera switch button — top right
                if (!_callCubit.cameraOff)
                  Positioned(
                    top: 6.h,
                    right: 6.w,
                    child: GestureDetector(
                      onTap: _callCubit.switchCamera,
                      child: Container(
                        width: 28.w,
                        height: 28.w,
                        decoration: BoxDecoration(
                          color: Colors.black.withValues(alpha: 0.45),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.switch_camera_rounded,
                          color: Colors.white,
                          size: 16.sp,
                        ),
                      ),
                    ),
                  ),

                // "You" label — bottom center
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
        );
      },
    );
  }
}
