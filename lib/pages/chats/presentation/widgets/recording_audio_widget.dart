import 'package:fennac_app/app/constants/media_query_constants.dart';
import 'package:fennac_app/app/theme/app_colors.dart';
import 'package:fennac_app/generated/assets.gen.dart';
import 'package:fennac_app/pages/chats/presentation/bloc/cubit/message_cubit.dart';
import 'package:fennac_app/widgets/prompt_audio_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../app/theme/text_styles.dart';
import '../../../../core/di_container.dart';
import '../../../kyc/presentation/bloc/cubit/kyc_prompt_cubit.dart';
import '../../../kyc/presentation/bloc/state/kyc_prompt_state.dart';
import '../../data/models/message_type_enum.dart';

class RecordingAudioWidget extends StatelessWidget {
  const RecordingAudioWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final recordingCubit = Di().sl<KycPromptCubit>();
    return BlocBuilder<KycPromptCubit, KycPromptState>(
      bloc: recordingCubit,
      builder: (context, state) {
        return Container(
          padding: const EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Text message button to switch to text mode
              GestureDetector(
                onTap: () {
                  Di().sl<MessageCubit>().toggleRecordingAudio(stop: true);
                  recordingCubit.deleteAudio();
                },
                child: Container(
                  height: 48,
                  width: 48,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: isLightTheme(context)
                        ? ColorPalette.textGrey
                        : ColorPalette.secondary,
                    shape: BoxShape.circle,
                  ),
                  child: SvgPicture.asset(
                    Assets.icons.messageCircle.path,
                    color: !isLightTheme(context) ? Colors.white : Colors.black,
                    height: 24,
                    width: 24,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              if (recordingCubit.isRecorded) ...[
                GestureDetector(
                  onTap: () {
                    Di().sl<MessageCubit>().toggleRecordingAudio(stop: true);

                    recordingCubit.deleteAudio();
                  },
                  child: Container(
                    height: 48,
                    width: 48,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: isLightTheme(context)
                          ? ColorPalette.textGrey
                          : ColorPalette.secondary,
                      shape: BoxShape.circle,
                    ),
                    child: SvgPicture.asset(
                      Assets.icons.trash.path,
                      color: !isLightTheme(context)
                          ? Colors.white
                          : Colors.black,
                      height: 24,
                      width: 24,
                    ),
                  ),
                ),
              ] else ...[
                Text(
                  recordingCubit.recordedDuration,
                  style: AppTextStyles.body(
                    context,
                  ).copyWith(color: Colors.white),
                ),
              ],
              const SizedBox(width: 8),
              if (recordingCubit.isRecorded) ...[
                Expanded(
                  child: PromptAudioRow(
                    audioPath: recordingCubit.recordingPath!,
                    waveformData: [...recordingCubit.recordedWaveformData],
                    backgroundColor: Colors.transparent,
                    duration: recordingCubit.recordedDuration,
                    playButtonColor: isLightTheme(context)
                        ? ColorPalette.textGrey
                        : ColorPalette.primary,
                    waveformColor: isLightTheme(context)
                        ? Colors.black
                        : Colors.white,
                  ),
                ),
              ] else ...[
                Expanded(
                  child: SingleChildScrollView(
                    controller: recordingCubit.scrollController,
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        recordingCubit.recordedWaveformData.isNotEmpty
                            ? recordingCubit.recordedWaveformData.length
                            : 100,
                        (index) {
                          double value =
                              recordingCubit.recordedWaveformData.isNotEmpty
                              ? recordingCubit.recordedWaveformData[index]
                                    .toDouble()
                              : 0;
                          return Container(
                            margin: const EdgeInsets.symmetric(horizontal: 2),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(2),
                              color: isLightTheme(context)
                                  ? Colors.black
                                  : Colors.white,
                            ),
                            width: 2,
                            height: value > 0 ? value : 1,
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ],

              const SizedBox(width: 8),
              GestureDetector(
                onTap: () {
                  if (recordingCubit.isRecorded) {
                    Di().sl<MessageCubit>().toggleRecordingAudio(stop: true);
                    Di().sl<MessageCubit>().sendMediaMessage(
                      mediaPath: [recordingCubit.recordingPath!],
                      type: MessageType.audio,
                      waveformData: recordingCubit.recordedWaveformData,
                      duration: recordingCubit.recordedDuration,
                    );
                    recordingCubit.resetRecording();
                    return;
                  }
                  if (recordingCubit.isRecording) {
                    recordingCubit.stopRecording();
                  } else {
                    recordingCubit.startRecording();
                  }
                },
                child: Container(
                  height: 48,
                  width: 48,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: recordingCubit.isRecording
                        ? Colors.red
                        : ColorPalette.primary,
                    shape: BoxShape.circle,
                  ),
                  child: SvgPicture.asset(
                    recordingCubit.isRecorded
                        ? Assets.icons.send.path
                        : recordingCubit.isRecording
                        ? Assets.icons.pause.path
                        : Assets.icons.mic.path,
                    colorFilter: const ColorFilter.mode(
                      Colors.white,
                      BlendMode.srcIn,
                    ),
                    height: 24,
                    width: 24,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
