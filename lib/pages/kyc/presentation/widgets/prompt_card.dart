import 'dart:developer';
import 'dart:ui';

import 'package:fennac_app/app/constants/media_query_constants.dart';
import 'package:fennac_app/app/theme/app_colors.dart';
import 'package:fennac_app/app/theme/text_styles.dart';
import 'package:fennac_app/core/di_container.dart';
import 'package:fennac_app/core/extensions/string_extension.dart';
import 'package:fennac_app/generated/assets.gen.dart';
import 'package:fennac_app/pages/kyc/presentation/bloc/cubit/kyc_prompt_cubit.dart';
import 'package:fennac_app/pages/kyc/presentation/widgets/create_prompt_bottom_sheet.dart';
import 'package:fennac_app/widgets/prompt_audio_row.dart';
import 'package:fennac_app/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PromptCard extends StatelessWidget {
  final String prompt;
  final bool isEditMode;
  final bool isPredefined;
  final Function(bool) setBackgroundBlurred;

  const PromptCard({
    super.key,
    required this.prompt,
    this.isEditMode = false,
    this.isPredefined = false,
    required this.setBackgroundBlurred,
  });

  @override
  Widget build(BuildContext context) {
    final kycPromptCubit = Di().sl<KycPromptCubit>();

    final isSelected = kycPromptCubit.isPromptSelected(prompt);
    final isMaxReached = kycPromptCubit.isMaxReached() && !isSelected;
    final canSelect = kycPromptCubit.canSelectMore() || isSelected;
    final promptData = kycPromptCubit.getPromptAnswer(prompt);

    // Only show user-submitted answer
    final subtitle = promptData?.promptAnswer;
    final showAudioRow = promptData?.promptAnswer?.isAudio ?? false;

    return Opacity(
      opacity: isMaxReached ? 0.4 : 1.0,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
          child: Container(
            height: isSelected && showAudioRow ? 128 : null,
            width: double.infinity,
            alignment: Alignment.center,
            margin: const EdgeInsets.symmetric(vertical: 8),
            decoration: BoxDecoration(
              color: isSelected
                  ? ColorPalette.primary
                  : isLightTheme(context)
                  ? ColorPalette.textGrey
                  : ColorPalette.secondary.withValues(alpha: 0.5),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: ColorPalette.primary.withValues(alpha: 0.15),
                  blurRadius: 5,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: isMaxReached
                    ? null
                    : () async {
                        setBackgroundBlurred(true);
                        // if promptData is null adding prompt in cubit
                        AudioPromptData? tempPromptData;
                        if (promptData == null) {
                          String id = DateTime.now().millisecondsSinceEpoch
                              .toString();
                          tempPromptData = AudioPromptData(
                            id: id,
                            oldId: id,
                            promptText: prompt,
                            isCustom: !isPredefined,
                          );
                          kycPromptCubit.addPrompt(tempPromptData);
                        } else {
                          tempPromptData = promptData;
                        }
                        log("tempPromptData: ${tempPromptData.toString()}");
                        await CreatePromptBottomSheet.show(
                          context,
                          promptData: tempPromptData,
                          isEditMode: isEditMode,
                          isEditingPrompt: promptData != null,
                        );
                        setBackgroundBlurred(false);
                      },
                onLongPress: isSelected
                    ? () {
                        _showDeselectDialog(context, prompt, kycPromptCubit);
                      }
                    : null,
                borderRadius: BorderRadius.circular(16),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        title: AppText(
                          text: prompt,
                          maxLines: 1,
                          style: AppTextStyles.body(context).copyWith(
                            color: isSelected
                                ? Colors.white
                                : isLightTheme(context)
                                ? Colors.black
                                : Colors.white,
                            fontWeight: canSelect
                                ? FontWeight.w500
                                : FontWeight.normal,
                          ),
                        ),
                        subtitle: showAudioRow == false && subtitle != null
                            ? Padding(
                                padding: const EdgeInsets.only(top: 4),
                                child: AppText(
                                  text: subtitle,
                                  style: AppTextStyles.bodySmall(context)
                                      .copyWith(
                                        color: isSelected
                                            ? Colors.white.withValues(
                                                alpha: 0.85,
                                              )
                                            : isLightTheme(context)
                                            ? Colors.black
                                            : Colors.white.withValues(
                                                alpha: 0.85,
                                              ),
                                        fontSize: 14,
                                      ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              )
                            : null,
                        trailing: promptData != null
                            ? SvgPicture.asset(
                                Assets.icons.edit3.path,
                                width: 20,
                                height: 20,
                                colorFilter: ColorFilter.mode(
                                  isSelected
                                      ? Colors.white.withValues(alpha: 0.6)
                                      : isLightTheme(context)
                                      ? Colors.black.withValues(alpha: 0.6)
                                      : Colors.white.withValues(alpha: 0.6),
                                  BlendMode.srcIn,
                                ),
                              )
                            : SvgPicture.asset(
                                Assets.icons.arrowRightChevron.path,
                                width: 24,
                                height: 24,
                                colorFilter: ColorFilter.mode(
                                  isSelected
                                      ? Colors.white.withValues(alpha: 0.6)
                                      : isLightTheme(context)
                                      ? Colors.black
                                      : Colors.white.withValues(alpha: 0.6),
                                  BlendMode.srcIn,
                                ),
                              ),
                      ),

                      if (showAudioRow == true)
                        PromptAudioRow(
                          audioPath: promptData?.promptAnswer ?? "",
                          duration: promptData?.duration ?? "",
                          waveformData: promptData?.waveformData ?? [],
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showDeselectDialog(
    BuildContext context,
    String prompt,
    KycPromptCubit cubit,
  ) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: isLightTheme(context)
              ? ColorPalette.textGrey
              : ColorPalette.secondary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: AppText(
            text: 'Deselect Prompt',
            style: AppTextStyles.h1(context).copyWith(
              color: isLightTheme(context) ? Colors.black : Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: AppText(
            text:
                'Do you want to deselect this prompt? Your answer will remain saved.',
            style: AppTextStyles.bodyLarge(context).copyWith(
              color: isLightTheme(context)
                  ? Colors.black.withValues(alpha: 0.8)
                  : Colors.white.withValues(alpha: 0.8),
              fontSize: 14,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: AppText(
                text: 'Cancel',
                style: AppTextStyles.bodyLarge(context).copyWith(
                  color: isLightTheme(context)
                      ? Colors.black.withValues(alpha: 0.7)
                      : Colors.white.withValues(alpha: 0.7),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                cubit.removePrompt(prompt);
                Navigator.of(context).pop();
              },
              child: AppText(
                text: 'Deselect',
                style: AppTextStyles.bodyLarge(context).copyWith(
                  color: ColorPalette.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
