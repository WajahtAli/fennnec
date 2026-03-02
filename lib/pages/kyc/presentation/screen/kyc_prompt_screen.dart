import 'dart:ui';
import 'package:auto_route/auto_route.dart';
import 'package:fennac_app/pages/create_group/presentation/bloc/cubit/create_group_cubit.dart';
import 'package:fennac_app/app/constants/media_query_constants.dart';
import 'package:fennac_app/app/theme/app_colors.dart';
import 'package:fennac_app/app/theme/text_styles.dart';
import 'package:fennac_app/core/di_container.dart';
import 'package:fennac_app/pages/kyc/presentation/bloc/cubit/kyc_prompt_cubit.dart';
import 'package:fennac_app/pages/kyc/presentation/bloc/state/kyc_prompt_state.dart';
import 'package:fennac_app/widgets/custom_text.dart';
import 'package:fennac_app/widgets/movable_background.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fennac_app/pages/kyc/presentation/widgets/kyc_prompt_header.dart';
import 'package:fennac_app/pages/kyc/presentation/widgets/custom_prompts_list.dart';
import 'package:fennac_app/pages/kyc/presentation/widgets/create_custom_prompt_button.dart';
import 'package:fennac_app/pages/kyc/presentation/widgets/predefined_prompts_list.dart';
import 'package:fennac_app/pages/kyc/presentation/widgets/kyc_prompt_actions.dart';

@RoutePage()
class KycPromptScreen extends StatefulWidget {
  final bool showSkipButton;
  final String? title;
  final String? subtitle;
  final bool? isEditMode;
  const KycPromptScreen({
    super.key,
    required this.showSkipButton,
    this.title,
    this.subtitle,
    this.isEditMode = false,
  });

  @override
  State<KycPromptScreen> createState() => _KycPromptScreenState();
}

class _KycPromptScreenState extends State<KycPromptScreen> {
  final _kycPromptCubit = Di().sl<KycPromptCubit>();
  final _createGroupCubit = Di().sl<CreateGroupCubit>();

  final ValueNotifier<bool> _isBackgroundBlurred = ValueNotifier<bool>(false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: isLightTheme(context)
          ? Colors.white
          : Colors.transparent,
      body: ValueListenableBuilder<bool>(
        valueListenable: _isBackgroundBlurred,
        builder: (context, isBlurred, child) {
          return Stack(
            children: [
              MovableBackground(
                backgroundType: MovableBackgroundType.medium,
                child: SafeArea(
                  child: BlocBuilder<KycPromptCubit, KycPromptState>(
                    bloc: _kycPromptCubit,
                    builder: (context, state) {
                      return Column(
                        children: [
                          Expanded(
                            child: SingleChildScrollView(
                              physics: const BouncingScrollPhysics(),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 24,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    KycPromptHeader(
                                      isEditMode: widget.isEditMode ?? false,
                                      showSkipButton: widget.showSkipButton,
                                      title: widget.title,
                                      subtitle: widget.subtitle,
                                    ),

                                    CustomPromptsList(
                                      kycPromptCubit: _kycPromptCubit,
                                      isEditMode: widget.isEditMode ?? false,
                                      setBackgroundBlurred: (value) {
                                        if (mounted) {
                                          _isBackgroundBlurred.value = value;
                                        }
                                      },
                                    ),

                                    CreateCustomPromptButton(
                                      kycPromptCubit: _kycPromptCubit,
                                      isEditMode: widget.isEditMode ?? false,
                                      backgroundBlurNotifier:
                                          _isBackgroundBlurred,
                                      onMaxPromptsReached: () {
                                        _showMaxPromptsDialog(context);
                                      },
                                    ),

                                    PredefinedPromptsList(
                                      isEditMode: widget.isEditMode ?? false,
                                      setBackgroundBlurred: (value) {
                                        if (mounted) {
                                          _isBackgroundBlurred.value = value;
                                        }
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
              if (isBlurred)
                Positioned.fill(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                    child: Container(
                      color: Colors.black.withValues(alpha: 0.1),
                    ),
                  ),
                ),
            ],
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: KycPromptActions(
        showSkipButton: widget.showSkipButton,
        isEditMode: widget.isEditMode ?? false,
        createGroupCubit: _createGroupCubit,
        backgroundBlurNotifier: _isBackgroundBlurred,
      ),
    );
  }

  void _showMaxPromptsDialog(BuildContext context) {
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
            text: 'Maximum Prompts Reached',
            style: AppTextStyles.h1(context).copyWith(
              color: isLightTheme(context) ? Colors.black : Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: AppText(
            text:
                'You can select only 4 prompts. Please deselect one to add another.',
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
                text: 'OK',
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
