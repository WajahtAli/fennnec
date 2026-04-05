import 'package:auto_route/auto_route.dart';
import 'package:fennac_app/app/constants/app_enums.dart';
import 'package:fennac_app/core/di_container.dart';
import 'package:fennac_app/pages/call/presentation/bloc/cubit/call_cubit.dart';
import 'package:fennac_app/pages/call/presentation/bloc/state/call_state.dart';
import 'package:fennac_app/pages/call/presentation/widgets/call_action_buttons.dart';
import 'package:fennac_app/pages/call/presentation/widgets/call_header_widget.dart';
import 'package:fennac_app/widgets/movable_background.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../widgets/self_video_widget.dart';
import '../widgets/video_call_camera_view.dart';

@RoutePage()
class AudioCallScreen extends StatefulWidget {
  const AudioCallScreen({super.key});

  @override
  State<AudioCallScreen> createState() => _AudioCallScreenState();
}

class _AudioCallScreenState extends State<AudioCallScreen> {
  final CallCubit _callCubit = Di().sl<CallCubit>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _callCubit.initAgora();
    });
  }

  @override
  void dispose() {
    _callCubit.handleCallScreenDisposed();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MovableBackground(
        backgroundType: MovableBackgroundType.dark,
        child: BlocBuilder<CallCubit, CallState>(
          bloc: _callCubit,
          builder: (context, state) {
            final isSystemPipActive = _callCubit.isSystemPipActive;
            return Stack(
              children: [
                if (_callCubit.callType == CallType.video) ...[
                  Positioned.fill(child: VideoCallCameraView()),
                  if (!isSystemPipActive)
                    AnimatedPositioned(
                      duration: _callCubit.isSelfViewDragging
                          ? Duration.zero
                          : const Duration(milliseconds: 300),
                      curve: Curves.easeOutBack,
                      top: _callCubit.selfViewTop,
                      left: _callCubit.selfViewLeft,
                      child: SafeArea(
                        child: GestureDetector(
                          onPanStart: (details) {
                            _callCubit.updateSelfViewPosition(
                              left: _callCubit.selfViewLeft,
                              top: _callCubit.selfViewTop,
                              isDragging: true,
                            );
                          },
                          onPanUpdate: (details) {
                            _callCubit.updateSelfViewPosition(
                              left: _callCubit.selfViewLeft + details.delta.dx,
                              top: _callCubit.selfViewTop + details.delta.dy,
                              isDragging: true,
                            );
                          },
                          onPanEnd: (details) {
                            _callCubit.snapToNearestCorner(
                              screenSize: MediaQuery.of(context).size,
                              widgetWidth: 100.w,
                              widgetHeight: 140.h,
                              safeAreaPadding: MediaQuery.of(context).padding,
                            );
                          },
                          child: const SelfVideoWidget(),
                        ),
                      ),
                    ),
                ],
                SafeArea(
                  child: Column(
                    children: [
                      if (!isSystemPipActive) ...[
                        const SizedBox(height: 24),
                        CallHeaderWidget(),
                      ],
                      SizedBox(height: 200.h),
                      if (_callCubit.callType == CallType.audio) ...[
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
                              child: Image.network(
                                _callCubit.imageUrl ?? "",
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ],
                      const Spacer(),
                      if (!isSystemPipActive) ...[
                        CallActionButtons(),
                        SizedBox(height: 20.h),
                      ],
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
