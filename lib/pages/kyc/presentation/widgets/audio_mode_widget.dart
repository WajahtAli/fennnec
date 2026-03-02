import 'package:fennac_app/app/constants/media_query_constants.dart';
import 'package:fennac_app/app/theme/app_colors.dart';
import 'package:fennac_app/bloc/state/audio_player_state.dart';
import 'package:fennac_app/core/di_container.dart';
import 'package:fennac_app/generated/assets.gen.dart';
import 'package:fennac_app/pages/kyc/presentation/bloc/cubit/kyc_prompt_cubit.dart';
import 'package:fennac_app/pages/kyc/presentation/bloc/state/kyc_prompt_state.dart';
import 'package:fennac_app/widgets/prompt_audio_row.dart';
import 'package:fennac_app/widgets/custom_sized_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../bloc/cubit/audio_player_cubit.dart';

class AudioModeWidget extends StatefulWidget {
  final AudioPromptData? existingAudioData;
  const AudioModeWidget({super.key, this.existingAudioData});

  @override
  State<AudioModeWidget> createState() => _AudioModeWidgetState();
}

class _AudioModeWidgetState extends State<AudioModeWidget> {
  late final ScrollController scrollController;

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<KycPromptCubit, KycPromptState>(
      bloc: _kycPromptCubit,
      builder: (context, state) {
        if (_kycPromptCubit.isRecorded) {
          return _buildPreviewUI(context, widget.existingAudioData);
        }

        return _buildRecordingUI(context);
      },
    );
  }

  /// Build UI for recorded audio preview
  Widget _buildPreviewUI(BuildContext context, AudioPromptData? audioData) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 80.h,
          child: Center(
            child: _buildWaveformPreview(context, widget.existingAudioData),
          ),
        ),
        const CustomSizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            PlayButton(audioData: widget.existingAudioData!),
            const CustomSizedBox(width: 24),
            _buildDeleteButton(context),
          ],
        ),
      ],
    );
  }

  /// Build UI for active recording
  Widget _buildRecordingUI(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 32.h,
          child: BlocBuilder<KycPromptCubit, KycPromptState>(
            bloc: _kycPromptCubit,
            builder: (context, state) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                if (scrollController.hasClients) {
                  scrollController.animateTo(
                    scrollController.position.maxScrollExtent,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeOut,
                  );
                }
              });
              return SingleChildScrollView(
                controller: scrollController,
                scrollDirection: Axis.horizontal,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: _kycPromptCubit.recordedWaveformData.map((sample) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 1),
                      child: Container(
                        width: 3,
                        height: sample,
                        decoration: BoxDecoration(
                          color: isLightTheme(context)
                              ? Colors.black
                              : Colors.white,
                          borderRadius: BorderRadius.circular(1.5),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              );
            },
          ),
        ),
        const CustomSizedBox(height: 16),
        _buildRecordButton(context),
      ],
    );
  }

  /// Record/Stop button (mic icon or stop icon)
  Widget _buildRecordButton(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        if (_kycPromptCubit.isRecording) {
          await _kycPromptCubit.stopRecording();
        } else {
          await _kycPromptCubit.startRecording();
        }
      },
      child: Container(
        width: 96,
        height: 96,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: _kycPromptCubit.isRecording
              ? Colors.red
              : ColorPalette.primary,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color:
                  (_kycPromptCubit.isRecording
                          ? Colors.red
                          : ColorPalette.primary)
                      .withValues(alpha: 0.5),
              blurRadius: 30,
              spreadRadius: 10,
            ),
          ],
        ),
        child: _kycPromptCubit.isRecording
            ? const Icon(Icons.stop, color: Colors.white, size: 40)
            : SvgPicture.asset(
                Assets.icons.mic.path,
                width: 32,
                height: 32,
                colorFilter: ColorFilter.mode(
                  ColorPalette.white,
                  BlendMode.srcIn,
                ),
              ),
      ),
    );
  }

  /// Delete button
  Widget _buildDeleteButton(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _kycPromptCubit.deleteAudio();
      },
      child: Container(
        width: 48,
        height: 48,
        alignment: Alignment.center,
        child: SvgPicture.asset(
          Assets.icons.trash.path,
          width: 24,
          height: 24,
          colorFilter: ColorFilter.mode(
            isLightTheme(context) ? Colors.black : ColorPalette.white,
            BlendMode.srcIn,
          ),
        ),
      ),
    );
  }

  /// Waveform display for recorded audio
  Widget _buildWaveformPreview(
    BuildContext context,
    AudioPromptData? audioData,
  ) {
    if (audioData?.waveformData?.isEmpty ??
        true && audioData?.promptAnswer == null) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: List.generate(40, (i) {
          final heights = [25.0, 35.0, 45.0, 30.0, 40.0, 50.0];
          return Container(
            width: 3,
            height: heights[i % heights.length],
            margin: const EdgeInsets.symmetric(horizontal: 1.5),
            decoration: BoxDecoration(
              color: isLightTheme(context)
                  ? Colors.black.withValues(alpha: 0.3)
                  : Colors.white.withValues(alpha: 0.3),
              borderRadius: BorderRadius.circular(2),
            ),
          );
        }),
      );
    }

    return PromptAudioRow(
      audioPath: audioData?.promptAnswer ?? "",
      waveformData: audioData?.waveformData ?? [],
      duration: audioData?.duration ?? "",
      height: 80,
      backgroundColor: Colors.transparent,
      playButtonColor: ColorPalette.primary,
      waveformColor: isLightTheme(context) ? Colors.black : Colors.white,
    );
  }

  /// Re-record button for preview mode
  Widget _buildReRecordButton(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        _kycPromptCubit.deleteAudio();
        await _kycPromptCubit.startRecording();
      },
      child: Container(
        width: 96,
        height: 96,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: ColorPalette.primary,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: ColorPalette.primary.withValues(alpha: 0.5),
              blurRadius: 30,
              spreadRadius: 10,
            ),
          ],
        ),
        child: SvgPicture.asset(
          Assets.icons.mic.path,
          width: 32,
          height: 32,
          colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
        ),
      ),
    );
  }
}

class PlayButton extends StatelessWidget {
  final AudioPromptData audioData;
  const PlayButton({super.key, required this.audioData});

  @override
  Widget build(BuildContext context) {
    /// Play/Stop button for preview
    return BlocProvider(
      create: (context) =>
          AudioPlayerCubit()..setSource(audioData.promptAnswer ?? ""),
      child: BlocBuilder<AudioPlayerCubit, AudioPlayerState>(
        builder: (context, state) {
          return GestureDetector(
            onTap: () async {
              context.read<AudioPlayerCubit>().toggle();
            },
            child: Container(
              width: 96.h,
              height: 96.h,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: ColorPalette.primary,
                shape: BoxShape.circle,
              ),
              child: state.status == AudioStatus.playing
                  ? const Icon(Icons.stop, color: Colors.white, size: 32)
                  : SvgPicture.asset(
                      Assets.icons.play.path,
                      colorFilter: ColorFilter.mode(
                        ColorPalette.white,
                        BlendMode.srcIn,
                      ),
                    ),
            ),
          );
        },
      ),
    );
  }
}

final _kycPromptCubit = Di().sl<KycPromptCubit>();
