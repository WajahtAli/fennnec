import 'dart:developer';

import 'package:fennac_app/app/constants/media_query_constants.dart';
import 'package:fennac_app/app/theme/app_colors.dart';
import 'package:fennac_app/app/theme/text_styles.dart';
import 'package:fennac_app/core/di_container.dart';
import 'package:fennac_app/helpers/gradient_toast.dart';
import 'package:fennac_app/pages/kyc/presentation/bloc/cubit/kyc_prompt_cubit.dart';
import 'package:fennac_app/pages/kyc/presentation/widgets/audio_mode_widget.dart';
import 'package:fennac_app/reusable_widgets/toggle_widget.dart';
import 'package:fennac_app/widgets/custom_bottom_sheet.dart';
import 'package:fennac_app/widgets/custom_elevated_button.dart';
import 'package:fennac_app/widgets/custom_sized_box.dart';
import 'package:fennac_app/widgets/custom_text.dart';
import 'package:fennac_app/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

import '../../../../generated/assets.gen.dart';
import '../../../auth/presentation/bloc/cubit/create_account_cubit.dart';
import '../bloc/state/kyc_prompt_state.dart';

class CreatePromptBottomSheet extends StatefulWidget {
  final AudioPromptData? existingAudioData;
  final bool isEditMode;
  final bool isEditingPrompt;
  const CreatePromptBottomSheet({
    super.key,
    this.existingAudioData,
    this.isEditMode = false,
    this.isEditingPrompt = false,
  });

  static Future<void> show(
    BuildContext context, {
    AudioPromptData? promptData,
    bool isEditMode = false,
    bool isEditingPrompt = false,
  }) async {
    final cubit = Di().sl<KycPromptCubit>();
    cubit.showCreatePromptBottomSheet();
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,

      isDismissible: true,
      enableDrag: false,

      builder: (sheetContext) => BlocProvider.value(
        value: cubit,
        child: PopScope(
          canPop: false,
          onPopInvokedWithResult: (didPop, result) async {
            if (didPop) return;

            if (isEditingPrompt) {
              Navigator.of(sheetContext).pop();
              return;
            }

            final shouldClose = await _showExitDialog(sheetContext, promptData);

            if (shouldClose && sheetContext.mounted) {
              Navigator.of(sheetContext).pop();
            }
          },
          child: CreatePromptBottomSheet(
            existingAudioData: promptData,
            isEditMode: isEditMode,
            isEditingPrompt: isEditingPrompt,
          ),
        ),
      ),
    );

    cubit.hideCreatePromptBottomSheet();
  }

  static Future<bool> _showExitDialog(
    BuildContext context,
    AudioPromptData? existingAudioData,
  ) async {
    bool shouldClose = false;
    await CustomBottomSheet.show(
      context: context,
      title: 'Discard changes?',
      description: 'Your progress will be lost.',
      buttonText: 'Leave',
      secondaryButtonText: 'Stay',
      onButtonPressed: () {
        Di().sl<KycPromptCubit>().removePrompt(
          existingAudioData?.promptText ?? "",
        );
        shouldClose = true;
        Navigator.pop(context);
      },
      onSecondaryButtonPressed: () {
        Navigator.pop(context);
      },
      isHorizontalButton: true,
    );
    return shouldClose;
  }

  @override
  State<CreatePromptBottomSheet> createState() =>
      _CreatePromptBottomSheetState();
}

class _CreatePromptBottomSheetState extends State<CreatePromptBottomSheet> {
  final KycPromptCubit _kycPromptCubit = Di().sl<KycPromptCubit>();
  final CreateAccountCubit _createAccountCubit = Di().sl<CreateAccountCubit>();

  bool get _isCustom => widget.existingAudioData?.isCustom ?? false;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _promptController = TextEditingController();
  final TextEditingController _answerController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.existingAudioData != null) {
      _kycPromptCubit.initializePromptState(prompt: widget.existingAudioData!);
      _promptController.text = widget.existingAudioData?.promptText ?? '';
      _answerController.text = widget.existingAudioData?.promptAnswer ?? '';
    }
  }

  bool isLoading = false;

  Future<void> _handleDone() async {
    setState(() {
      isLoading = true;
    });
    try {
      if (_formKey.currentState?.validate() ?? false) {
        AudioPromptData? audioPromptData = _kycPromptCubit.promptToEdit
            ?.copyWith(
              promptText: _promptController.text,
              promptAnswer:
                  _kycPromptCubit.recordingPath ?? _answerController.text,
            );

        log("test ${widget.isEditMode} :: ${widget.isEditingPrompt}");

        // Upload audio if in audio mode and have a local recording
        if (_kycPromptCubit.isAudioMode &&
            _kycPromptCubit.recordingPath != null &&
            _kycPromptCubit.recordingPath!.isNotEmpty &&
            !(_kycPromptCubit.recordingPath?.startsWith('http') ?? false)) {
          String url = await _createAccountCubit.uploadMedia(
            filePath: _kycPromptCubit.recordingPath ?? "",
          );
          if (url.isNotEmpty) {
            audioPromptData = audioPromptData?.copyWith(promptAnswer: url);
            debugPrint("Audio URL: $url");
          } else {
            VxToast.show(message: "Failed to upload audio");
            setState(() {
              isLoading = false;
            });
            return;
          }
        }

        _kycPromptCubit.updatePrompt(audioPromptData!);

        if (widget.isEditingPrompt == true) {
          await _createAccountCubit.updatePrompt(
            id: audioPromptData.id ?? "",
            promptTitle: audioPromptData.promptText ?? "",
            promptAnswer: audioPromptData.promptAnswer ?? "",
            context: context,
          );
        } else {
          await _createAccountCubit.customPrompts(
            promptTitle: audioPromptData.promptText ?? "",
            promptAnswer: audioPromptData.promptAnswer ?? "",
            context: context,
            type: _kycPromptCubit.isAudioMode ? "audio" : "text",
          );
        }
        log("promptId: ${_createAccountCubit.promptId}");

        if (_createAccountCubit.promptId.isNotEmpty) {
          audioPromptData = audioPromptData.copyWith(
            id: _createAccountCubit.promptId,
            oldId: audioPromptData.id,
          );
          _kycPromptCubit.updatePrompt(audioPromptData);
        }
        _createAccountCubit.promptId = "";
        await _createAccountCubit.loadProfile();
        VxToast.show(
          message: 'Prompt submitted successfully',
          icon: Assets.icons.checkGreen.path,
        );
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      VxToast.show(
        message: 'Failed to submit prompt',
        icon: Assets.icons.checkGreen.path,
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Container(
        height: _isCustom
            ? getHeight(context) * 0.65
            : getHeight(context) * 0.6,
        decoration: BoxDecoration(
          gradient: isLightTheme(context)
              ? null
              : LinearGradient(
                  colors: [ColorPalette.secondary, ColorPalette.black],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
          color: isLightTheme(context) ? Colors.white : null,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: SafeArea(
          child: BlocBuilder<KycPromptCubit, KycPromptState>(
            bloc: _kycPromptCubit,
            builder: (context, state) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      // Handle bar
                      CustomSizedBox(height: 12),
                      Center(
                        child: Container(
                          width: 40,
                          height: 4,
                          decoration: BoxDecoration(
                            color: isLightTheme(context)
                                ? Colors.black.withValues(alpha: 0.2)
                                : Colors.white24,
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                      ),
                      CustomSizedBox(height: 32),
                      // Prompt Text
                      AppText(
                        text: _kycPromptCubit.promptToEdit?.promptText ?? '',
                        textAlign: TextAlign.center,
                        style: AppTextStyles.h3(context).copyWith(
                          color: isLightTheme(context)
                              ? Colors.black
                              : Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      if (_isCustom) ...[
                        CustomSizedBox(height: 24),
                        CustomLabelTextField(
                          label: 'Your prompt',
                          controller: _promptController,
                          hintText: 'Type here..',
                          labelColor: isLightTheme(context)
                              ? Colors.black
                              : Colors.white,
                          filled: false,
                          validator: (value) {
                            if (_isCustom &&
                                (value == null || value.trim().isEmpty)) {
                              return 'Please enter your prompt';
                            }
                            return null;
                          },
                        ),
                      ],
                      CustomSizedBox(height: 32),
                      // Text/Audio Toggle
                      Container(
                        height: 36,
                        width: 370,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: isLightTheme(context)
                              ? ColorPalette.textGrey
                              : ColorPalette.cardBlack,
                          border: Border.all(
                            color: isLightTheme(context)
                                ? Colors.black.withValues(alpha: 0.2)
                                : ColorPalette.grey,
                            width: 1.5,
                          ),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Expanded(
                              child: ToggleWidget(
                                label: 'Text',
                                isSelected: !_kycPromptCubit.isAudioMode,
                                onTap: () {
                                  _kycPromptCubit.toggleAudioMode();
                                },
                              ),
                            ),
                            Expanded(
                              child: ToggleWidget(
                                label: 'Audio',
                                isSelected: _kycPromptCubit.isAudioMode,
                                onTap: () {
                                  _kycPromptCubit.toggleAudioMode();
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      CustomSizedBox(height: 40),
                      Expanded(
                        child: _kycPromptCubit.isAudioMode
                            ? AudioModeWidget(
                                existingAudioData: _kycPromptCubit.promptToEdit,
                              )
                            : _buildTextMode(),
                      ),
                      CustomSizedBox(height: 20),
                      // Done Button
                      CustomElevatedButton(
                        icon: isLoading
                            ? SizedBox(
                                width: 20,
                                height: 20,
                                child: Lottie.asset(
                                  Assets.animations.loadingSpinner,
                                  fit: BoxFit.cover,
                                ),
                              )
                            : null,
                        onTap: isLoading ? () {} : _handleDone,
                        text: isLoading ? '' : 'Done',
                        width: double.infinity,
                      ),
                      CustomSizedBox(height: 24),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildTextMode() {
    return CustomLabelTextField(
      label: 'Your answer',
      controller: _answerController,
      scrollController: ScrollController(),
      hintText: 'Type your answer here...',
      labelColor: isLightTheme(context) ? Colors.black : Colors.white,
      filled: false,
      maxLines: 4,
      minLines: 3,
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'Please enter your answer';
        }
        return null;
      },
    );
  }
}
