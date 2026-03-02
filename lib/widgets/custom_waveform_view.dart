import 'package:fennac_app/app/constants/media_query_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:math' as math;

import '../app/theme/app_colors.dart';
import '../bloc/cubit/audio_player_cubit.dart';
import '../bloc/state/audio_player_state.dart';

class WaveformView extends StatefulWidget {
  final List<double> waveform;
  final Color? waveformColor;

  const WaveformView({super.key, this.waveform = const [], this.waveformColor});

  @override
  State<WaveformView> createState() => _WaveformViewState();
}

class _WaveformViewState extends State<WaveformView>
    with SingleTickerProviderStateMixin {
  double? _dragProgress;
  late final AnimationController _controller;

  @override
  initState() {
    if (widget.waveform.isEmpty) {
      // context.read<AudioPlayerCubit>().extractWaveForms();
      context.read<AudioPlayerCubit>().addWaveformData(
        List.generate(100, (index) => 0.2 * math.Random().nextDouble()),
      );
    }
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AudioPlayerCubit, AudioPlayerState>(
      builder: (_, state) {
        final realProgress = state.duration.inMilliseconds == 0
            ? 0.0
            : state.position.inMilliseconds / state.duration.inMilliseconds;

        final progress = _dragProgress ?? realProgress;
        return LayoutBuilder(
          builder: (context, constraints) {
            final barCount = widget.waveform.isEmpty
                ? state.waveformData?.length ?? 0
                : widget.waveform.length;
            const maxVisibleBars = 70;
            final visibleBars = (barCount) > maxVisibleBars
                ? maxVisibleBars
                : barCount;
            final barWidth = constraints.maxWidth / (visibleBars);

            void updateDrag(Offset localPos) {
              final dx = localPos.dx.clamp(0, constraints.maxWidth);
              setState(() {
                _dragProgress = dx / constraints.maxWidth;
              });
            }

            // If no waveform yet, show a smooth loading skeleton
            if (visibleBars == 0) {
              final placeholderBars = maxVisibleBars;
              final maxH = constraints.maxHeight;
              final color =
                  (widget.waveformColor ??
                          (isLightTheme(context) ? Colors.black : Colors.white))
                      .withValues(alpha: 0.7);
              return AnimatedBuilder(
                animation: _controller,
                builder: (context, _) {
                  final phase = _controller.value * 2 * 3.1415926; // 0..2π
                  return Row(
                    children: List.generate(placeholderBars, (index) {
                      final t = (index / placeholderBars) * 2 * 3.1415926;
                      final h =
                          (0.1 + 0.5 * (0.5 + 0.5 * math.sin(t + phase))) *
                          maxH;
                      return SizedBox(
                        width: constraints.maxWidth / placeholderBars,
                        child: Center(
                          child: Container(
                            width:
                                (constraints.maxWidth / placeholderBars) * 0.5,
                            height: h,
                            decoration: BoxDecoration(
                              color: color,
                              borderRadius: BorderRadius.circular(1.5),
                            ),
                          ),
                        ),
                      );
                    }),
                  );
                },
              );
            }

            return GestureDetector(
              behavior: HitTestBehavior.translucent,
              onHorizontalDragStart: (_) {},
              onHorizontalDragUpdate: (details) =>
                  updateDrag(details.localPosition),
              onHorizontalDragEnd: (_) async {
                final cubit = context.read<AudioPlayerCubit>();
                final target = _dragProgress ?? realProgress;

                await cubit.seek(target);

                setState(() => _dragProgress = null);
              },
              onTapDown: (details) async {
                final cubit = context.read<AudioPlayerCubit>();
                final dx = details.localPosition.dx.clamp(
                  0,
                  constraints.maxWidth,
                );
                await cubit.seek(dx / constraints.maxWidth);
              },
              child: Row(
                children: List.generate((visibleBars), (index) {
                  final waveformIndex = (index * (barCount) / (visibleBars))
                      .floor()
                      .clamp(0, (barCount) - 1);
                  final playedBars = (progress * (visibleBars)).floor();
                  final isPlayed = index <= playedBars;

                  return SizedBox(
                    width: barWidth,
                    child: Center(
                      child: Container(
                        width: barWidth * 0.5,
                        height:
                            (widget.waveform.isEmpty
                                ? state.waveformData
                                : widget.waveform)?[waveformIndex] ??
                            0,
                        decoration: BoxDecoration(
                          color: isPlayed
                              ? ColorPalette.primary
                              : (widget.waveformColor ??
                                    (isLightTheme(context)
                                        ? Colors.black
                                        : Colors.white)),
                          borderRadius: BorderRadius.circular(1.5),
                        ),
                      ),
                    ),
                  );
                }),
              ),
            );
          },
        );
      },
    );
  }
}
