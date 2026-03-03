import 'package:fennac_app/app/constants/app_enums.dart';
import 'package:fennac_app/app/constants/dummy_constants.dart';
import 'package:fennac_app/app/constants/media_query_constants.dart';
import 'package:fennac_app/app/theme/app_colors.dart';
import 'package:fennac_app/app/theme/app_emojis.dart';
import 'package:fennac_app/app/theme/text_styles.dart';
import 'package:fennac_app/bloc/cubit/wave_form_cubit.dart';
import 'package:fennac_app/core/di_container.dart';
import 'package:fennac_app/generated/assets.gen.dart';
import 'package:fennac_app/helpers/cached_network_image_helper.dart';
import 'package:fennac_app/helpers/gradient_toast.dart';
import 'package:fennac_app/pages/home/presentation/bloc/cubit/home_cubit.dart';
import 'package:fennac_app/pages/home/presentation/widgets/report_and_block_bottomsheet.dart';
import 'package:fennac_app/pages/home/presentation/blur_controller.dart';
import 'package:fennac_app/pages/home/presentation/widgets/send_poke_bottomsheet.dart';
import 'package:fennac_app/skeletons/group_gallery_skeleton.dart';
import 'package:fennac_app/widgets/prompt_audio_row.dart';
import 'package:fennac_app/widgets/custom_sized_box.dart';
import 'package:fennac_app/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fennac_app/core/extensions/string_extension.dart';
import 'package:fennac_app/reusable_widgets/custom_video_player.dart';

import '../../../../bloc/state/wave_form_state.dart';
import '../bloc/state/home_state.dart';

enum EditableCardType { image, audio, prompt, lifestyle, interest }

enum SelectedProfile { individual, group }

final HomeCubit _homeCubit = Di().sl<HomeCubit>();

class GroupGalleryWidget extends StatelessWidget {
  final VoidCallback onTapRight;
  final VoidCallback onTapLeft;
  final bool? isShowEditButton;
  final bool? isShowReportButton;
  final void Function(EditableCardType type)? onEditTap;

  const GroupGalleryWidget({
    super.key,
    required this.onTapRight,
    required this.onTapLeft,
    this.onEditTap,
    this.isShowEditButton = false,
    this.isShowReportButton = true,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      bloc: _homeCubit,
      builder: (context, state) {
        if (state is HomeLoading) {
          return const GroupGallerySkeleton();
        }
        if (_homeCubit.selectedProfile != null) {
          return _buildIndividualGallery(context);
        }
        return _buildGroupGallery(context);
      },
    );
  }

  Widget _buildGroupGallery(BuildContext context) {
    final group = _homeCubit.currentGroup;

    if (group == null) {
      return const SizedBox.shrink();
    }

    final images =
        group.photosVideos?.where((img) => img.isNotEmpty).toList() ?? [];

    final prompts =
        group.groupPrompts?.where((p) {
          return p.promptAnswer != null && p.promptAnswer!.isNotEmpty;
        }).toList() ??
        [];

    final List<dynamic> interleavedItems = [];
    int imageIndex = 0;
    int promptIndex = 0;

    while (imageIndex < images.length || promptIndex < prompts.length) {
      for (int i = 0; i < 2 && imageIndex < images.length; i++) {
        interleavedItems.add(images[imageIndex++]);
      }

      if (promptIndex < prompts.length) {
        interleavedItems.add(prompts[promptIndex++]);
      }

      if (imageIndex < images.length) {
        interleavedItems.add(images[imageIndex++]);
      }

      if (promptIndex < prompts.length) {
        interleavedItems.add(prompts[promptIndex++]);
      }
    }

    if (interleavedItems.isEmpty && DummyConstants.groupImages.isNotEmpty) {
      for (final dummy in DummyConstants.groupImages) {
        interleavedItems.add(dummy);
      }
    }

    return Column(
      children: [
        ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          itemCount: interleavedItems.length,
          itemBuilder: (context, index) {
            final item = interleavedItems[index];

            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Column(
                children: [
                  if (item is String) ...[
                    Stack(
                      children: [
                        item.isVideo
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(24),
                                child: CustomVideoPlayer(
                                  videoUrl: item,
                                  autoPlay: false,
                                  looping: true,
                                  showControls: true,
                                  aspectRatio: 1,
                                  height: 450,
                                  fit: BoxFit.cover,
                                ),
                              )
                            : (item.startsWith('assets/')
                                  ? ClipRRect(
                                      borderRadius: BorderRadius.circular(24),
                                      child: Image.asset(
                                        item,
                                        width: double.infinity,
                                        height: 450,
                                        fit: BoxFit.cover,
                                      ),
                                    )
                                  : CachedImageHelper(
                                      imageUrl: item,
                                      width: double.infinity,
                                      fit: BoxFit.cover,
                                      height: 450,
                                      radius: 24,
                                    )),
                        if (isShowEditButton == true)
                          Positioned(
                            top: 16,
                            right: 16,
                            child: InkWell(
                              onTap: () =>
                                  onEditTap?.call(EditableCardType.image),
                              child: _editIcon(),
                            ),
                          ),
                      ],
                    ),
                  ] else ...[
                    /// PROMPT
                    Stack(
                      children: [
                        if (item.type == 'audio')
                          _GroupAudioCard(
                            title: item.promptTitle,
                            audioPath: item.promptAnswer,
                          )
                        else
                          _GroupPromptCard(
                            prompt: item.promptTitle,
                            answer: item.promptAnswer,
                            isAudioPrompt: false,
                          ),
                        if (isShowEditButton == true)
                          Positioned(
                            top: 16,
                            right: 16,
                            child: InkWell(
                              onTap: () => onEditTap?.call(
                                item.type == 'audio'
                                    ? EditableCardType.audio
                                    : EditableCardType.prompt,
                              ),
                              child: _editIcon(),
                            ),
                          ),
                      ],
                    ),
                  ],
                ],
              ),
            );
          },
        ),

        if (isShowEditButton == false && isShowReportButton == true)
          _buildBottomActions(context),
      ],
    );
  }

  Widget _buildIndividualGallery(BuildContext context) {
    final selectedMember = _homeCubit.selectedProfile;

    if (selectedMember == null) {
      return const SizedBox.shrink();
    }

    final images =
        selectedMember.bestShorts?.where((img) => img.isNotEmpty).toList() ??
        [];

    final prompts =
        selectedMember.prompts?.where((p) {
          return p.promptAnswer != null && p.promptAnswer!.isNotEmpty;
        }).toList() ??
        [];

    final List<dynamic> interleavedItems = [];
    int imageIndex = 0;
    int promptIndex = 0;

    while (imageIndex < images.length || promptIndex < prompts.length) {
      for (int i = 0; i < 2 && imageIndex < images.length; i++) {
        interleavedItems.add(images[imageIndex++]);
      }

      if (promptIndex < prompts.length) {
        interleavedItems.add(prompts[promptIndex++]);
      }

      if (imageIndex < images.length) {
        interleavedItems.add(images[imageIndex++]);
      }

      if (promptIndex < prompts.length) {
        interleavedItems.add(prompts[promptIndex++]);
      }
    }

    if (interleavedItems.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      children: [
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.zero,
          itemCount: interleavedItems.length,
          itemBuilder: (context, index) {
            final item = interleavedItems[index];

            if (item is String) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Stack(
                  children: [
                    item.isVideo
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(24),
                            child: CustomVideoPlayer(
                              videoUrl: item,
                              autoPlay: false,
                              looping: true,
                              showControls: true,
                              aspectRatio: 1,
                              height: 450,
                              fit: BoxFit.cover,
                            ),
                          )
                        : CachedImageHelper(
                            imageUrl: item,
                            width: double.infinity,
                            fit: BoxFit.cover,
                            height: 450,
                            radius: 24,
                          ),

                    if (isShowEditButton == true)
                      Positioned(
                        top: 16,
                        right: 16,
                        child: InkWell(
                          onTap: () => onEditTap?.call(EditableCardType.image),
                          child: _editIcon(),
                        ),
                      ),

                    Positioned(
                      top: 16,
                      right: 16,
                      child: GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        onTap: () async {
                          await HomeBlurController.showWithBlur(
                            context: context,
                            builder: (context) => SendPokeBottomSheet(
                              pokeType: PokeType.image,
                              image: item,
                            ),
                          );
                        },
                        child: _pokeIcon(context),
                      ),
                    ),
                  ],
                ),
              );
            } else {
              final promptItem = item;
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Stack(
                  children: [
                    _GroupPromptCard(
                      prompt: promptItem.promptTitle,
                      answer: promptItem.promptAnswer,
                      isAudioPrompt: promptItem.type == 'audio',
                    ),

                    /// EDIT ICON FOR PROMPT
                    if (isShowEditButton == true)
                      Positioned(
                        top: 16,
                        right: 16,
                        child: InkWell(
                          onTap: () => onEditTap?.call(EditableCardType.prompt),
                          child: _editIcon(),
                        ),
                      ),

                    Positioned(
                      top: 16,
                      right: 16,
                      child: GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        onTap: () async {
                          await HomeBlurController.showWithBlur(
                            context: context,
                            builder: (context) => SendPokeBottomSheet(
                              pokeType: promptItem.type == 'audio'
                                  ? PokeType.audio
                                  : PokeType.text,
                              image: images.isNotEmpty ? images.first : null,
                              promptTitle: promptItem.promptTitle,
                              promptAnswer: promptItem.promptAnswer,
                            ),
                          );
                        },
                        child: _pokeIcon(context),
                      ),
                    ),
                  ],
                ),
              );
            }
          },
        ),
      ],
    );
  }

  Widget _buildBottomActions(BuildContext context) {
    return Column(
      children: [
        const CustomSizedBox(height: 32),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _actionButton(
              icon: Assets.icons.error.path,
              color: ColorPalette.error,
              onTap: onTapLeft,
            ),
            const CustomSizedBox(width: 32),
            _actionButton(
              icon: Assets.icons.checkGreen.path,
              color: ColorPalette.green,
              onTap: onTapRight,
              isPng: true,
            ),
          ],
        ),
        const CustomSizedBox(height: 80),
        InkWell(
          onTap: () {
            final groupId = _homeCubit.currentGroup?.id;
            if (groupId == null || groupId.isEmpty) {
              VxToast.show(message: 'Unable to report this group right now.');
              return;
            }
            HomeBlurController.showWithBlur(
              context: context,
              builder: (_) => ReportAndBlockBottomSheet(groupId: groupId),
            );
          },
          child: AppText(
            text: 'Report and block',
            style: AppTextStyles.bodyLarge(context),
          ),
        ),
        const CustomSizedBox(height: 80),
      ],
    );
  }

  Widget _pokeIcon(BuildContext context) {
    return Container(
      height: 32,
      width: 32,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: ColorPalette.primary,
        shape: BoxShape.circle,
      ),
      child: Text(AppEmojis.pointingRight, style: AppTextStyles.h4(context)),
    );
  }

  Widget _actionButton({
    required String icon,
    required Color color,
    final bool? isPng,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 66,
        width: 66,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color.withValues(alpha: .1),
        ),
        child: isPng == true
            ? Image.asset(icon, height: 42, width: 42, color: color)
            : SvgPicture.asset(
                icon,
                height: 42,
                width: 42,
                colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
              ),
      ),
    );
  }

  Widget _editIcon() {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: ColorPalette.primary,
      ),
      child: SvgPicture.asset(
        Assets.icons.edit.path,
        color: ColorPalette.white,
      ),
    );
  }
}

/// ===================== AUDIO CARD =====================
class _GroupAudioCard extends StatelessWidget {
  final String? title;
  final String? audioPath;

  const _GroupAudioCard({this.title, this.audioPath});

  @override
  Widget build(BuildContext context) {
    final hasAudio = audioPath != null && audioPath!.isNotEmpty;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: isDarkTheme(context)
            ? LinearGradient(
                colors: [
                  Colors.black.withValues(alpha: .2),
                  ColorPalette.black.withValues(alpha: .2),
                ],
              )
            : null,
        color: isLightTheme(context) ? ColorPalette.textGrey : null,
        borderRadius: BorderRadius.circular(28),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title ?? 'If our group had a theme song...',
            style: AppTextStyles.bodyLarge(context),
          ),
          const SizedBox(height: 14),

          if (hasAudio)
            BlocBuilder<WaveformCubit, WaveformState>(
              bloc: Di().sl<WaveformCubit>(),
              builder: (context, state) {
                return PromptAudioRow(
                  audioPath: audioPath!,
                  height: 64,
                  backgroundColor: isLightTheme(context)
                      ? ColorPalette.secondary.withValues(alpha: 0.1)
                      : ColorPalette.secondary,
                  playButtonColor: ColorPalette.primary,
                  waveformColor: isDarkTheme(context)
                      ? Colors.white
                      : Colors.black,
                  borderRadius: BorderRadius.circular(40),
                );
              },
            )
          else
            /// Placeholder to keep UI consistent
            Container(
              height: 64,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: ColorPalette.secondary,
                borderRadius: BorderRadius.circular(40),
              ),
              child: AppText(
                text: 'No audio added yet',
                style: AppTextStyles.description(
                  context,
                ).copyWith(color: ColorPalette.white),
              ),
            ),
        ],
      ),
    );
  }
}

/// ===================== PROMPT CARD =====================
class _GroupPromptCard extends StatelessWidget {
  final String? prompt;
  final String? answer;
  final bool? isAudioPrompt;

  const _GroupPromptCard({
    this.prompt,
    this.answer,
    this.isAudioPrompt = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: isDarkTheme(context)
            ? LinearGradient(
                colors: [
                  Colors.black.withValues(alpha: .2),
                  ColorPalette.black.withValues(alpha: .2),
                ],
              )
            : null,
        color: isLightTheme(context) ? ColorPalette.textGrey : null,
        borderRadius: BorderRadius.circular(28),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText(
            text: prompt ?? "Our group's guilty pleasure...",
            style: AppTextStyles.subHeading(context),
          ),
          const SizedBox(height: 14),

          if (isAudioPrompt ?? false)
            PromptAudioRow(
              audioPath: answer ?? '',
              duration: '',
              waveformData: [],
            )
          else
            AppText(
              text: answer ?? '',
              style: AppTextStyles.h3(
                context,
              ).copyWith(fontWeight: FontWeight.bold),
            ),
        ],
      ),
    );
  }
}
