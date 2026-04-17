import 'dart:developer';

import 'package:fennac_app/app/constants/media_query_constants.dart';
import 'package:fennac_app/app/theme/app_colors.dart';
import 'package:fennac_app/app/theme/app_emojis.dart';
import 'package:fennac_app/app/theme/text_styles.dart';
import 'package:fennac_app/core/di_container.dart';
import 'package:fennac_app/core/extensions/string_extension.dart';
import 'package:fennac_app/generated/assets.gen.dart';
import 'package:fennac_app/pages/auth/data/model/prompt_model.dart';
import 'package:fennac_app/pages/auth/presentation/bloc/cubit/login_cubit.dart';
import 'package:fennac_app/pages/edit_profile/presentation/widgets/profile_section_wrapper.dart';
import 'package:fennac_app/pages/home/data/models/groups_model.dart';
import 'package:fennac_app/pages/home/presentation/bloc/cubit/home_cubit.dart';
import 'package:fennac_app/reusable_widgets/custom_video_player.dart';
import 'package:fennac_app/widgets/prompt_audio_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fennac_app/reusable_widgets/dynamic_ratio_image_widget.dart';

import '../../../../app/constants/app_enums.dart';
import '../../../../utils/validators.dart';
import '../../../../widgets/app_inkwell.dart';
import '../../../home/presentation/blur_controller.dart';
import '../../../home/presentation/widgets/group_gallery_widget.dart';
import '../../../home/presentation/widgets/send_poke_bottomsheet.dart';

class InterleavedMediaSection extends StatelessWidget {
  final List<String> bestShorts;
  final List<Prompt> prompts;
  final VoidCallback onImageEditTap;
  final bool isNeedEdit;
  final String? userId;
  final Function(Prompt, bool) onPromptEditTap;

  const InterleavedMediaSection({
    super.key,
    required this.bestShorts,
    required this.prompts,
    this.isNeedEdit = true,
    this.userId,
    required this.onImageEditTap,
    required this.onPromptEditTap,
  });

  @override
  Widget build(BuildContext context) {
    final mediaItems = bestShorts.length > 1
        ? bestShorts.sublist(1)
        : <String>[];

    if (mediaItems.isEmpty && prompts.isEmpty) {
      return ProfileSectionWrapper(
        title: 'Gallery',
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 24),
          child: Center(
            child: Text(
              "No media or prompts added yet.",
              style: AppTextStyles.h4(context),
            ),
          ),
        ),
      );
    }
    final validPrompts = prompts.where((p) {
      return p.promptAnswer != null && p.promptAnswer!.isNotEmpty;
    }).toList();

    final List<dynamic> interleavedItems = [];
    int imageIndex = 0;
    int promptIndex = 0;

    while (imageIndex < mediaItems.length ||
        promptIndex < validPrompts.length) {
      for (int i = 0; i < 1 && imageIndex < mediaItems.length; i++) {
        interleavedItems.add(mediaItems[imageIndex++]);
      }

      if (promptIndex < validPrompts.length) {
        interleavedItems.add(validPrompts[promptIndex++]);
      }

      if (imageIndex < mediaItems.length) {
        interleavedItems.add(mediaItems[imageIndex++]);
      }

      if (promptIndex < validPrompts.length) {
        interleavedItems.add(validPrompts[promptIndex++]);
      }
    }

    return ProfileSectionWrapper(
      title: 'Gallery',
      child: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: interleavedItems.length,
        padding: EdgeInsets.zero,
        itemBuilder: (context, index) {
          final item = interleavedItems[index];
          log("item $item prompts ${prompts.length}");

          if (item is String) {
            return _ImageItem(
              imagePath: item,
              targetId: item,
              onPokeTap: (type) {},
              onEditTap: onImageEditTap,
              isNeedEdit: isNeedEdit,
              userId: userId,
            );
          } else if (prompts.length == 0) {
            return Text(
              'Add more media or prompts to your gallery',
              style: AppTextStyles.h4(context),
            );
          } else if (item is Prompt) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: _PromptCard(
                prompt: item,
                onEditTap: () => onPromptEditTap(item, true),
                isNeedEdit: isNeedEdit,
                userId: userId,
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}

class _ImageItem extends StatelessWidget {
  final String imagePath;
  final VoidCallback onEditTap;
  final void Function(EditableCardType type)? onPokeTap;
  final String? targetId;
  final bool isNeedEdit;
  final String? userId;

  const _ImageItem({
    required this.imagePath,
    required this.onEditTap,
    this.targetId,
    this.onPokeTap,
    required this.isNeedEdit,
    this.userId,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Container(
              decoration: BoxDecoration(
                color: isDarkTheme(context)
                    ? Colors.grey[800]
                    : Colors.grey[300],
                borderRadius: BorderRadius.circular(16),
              ),
              child: (imagePath.isVideo)
                  ? CustomVideoPlayer(
                      videoUrl: imagePath,
                      autoPlay: false,
                      looping: true,
                      showControls: true,
                      height: 400,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    )
                  : DynamicRatioImageWidget(
                      imageUrl: imagePath,
                      height: 400,
                      borderRadius: 16,
                    ),
            ),
          ),
          if (isNeedEdit)
            Positioned(
              top: 12,
              right: 12,
              child: GestureDetector(
                onTap: onEditTap,
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: ColorPalette.primary,
                    shape: BoxShape.circle,
                  ),
                  child: SvgPicture.asset(
                    Assets.icons.edit.path,
                    height: 16,
                    width: 16,
                    colorFilter: const ColorFilter.mode(
                      Colors.white,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ),
            ),
          if (userId != null)
            Positioned(
              top: 16,
              right: 16,
              child: AppInkWell(
                onTap: () => onPokeTap?.call(EditableCardType.image),
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: ColorPalette.primary,
                  ),
                  child: SvgPicture.asset(
                    Assets.icons.edit.path,
                    color: ColorPalette.white,
                  ),
                ),
              ),
            ),
          Positioned(
            top: 16,
            right: 16,
            child: GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () async {
                final user = Di().sl<LoginCubit>().individualProfileData?.user;
                Di().sl<HomeCubit>().selectedProfile = Member(
                  name: user?.firstName,
                  age: validateInt(calculateAge(user?.dob.toString() ?? "")),
                );
                await HomeBlurController.showWithBlur(
                  context: context,
                  builder: (context) => SendPokeBottomSheet(
                    pokeType: PokeType.image,
                    image: imagePath,

                    // targetId: targetId,
                  ),
                );
              },
              child: Container(
                height: 32,
                width: 32,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: ColorPalette.primary,
                  shape: BoxShape.circle,
                ),
                child: Text(
                  AppEmojis.pointingRight,
                  style: AppTextStyles.h4(context),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PromptCard extends StatelessWidget {
  final Prompt prompt;
  final VoidCallback onEditTap;
  final bool isNeedEdit;
  final String? userId;

  const _PromptCard({
    required this.prompt,
    required this.onEditTap,
    required this.isNeedEdit,
    this.userId,
  });

  @override
  Widget build(BuildContext context) {
    final String promptTitle = prompt.promptTitle?.toString() ?? '';
    final String promptAnswer = prompt.promptAnswer?.toString() ?? '';

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
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(promptTitle, style: AppTextStyles.subHeading(context)),
              const SizedBox(height: 14),
              if (promptAnswer.isAudio)
                PromptAudioRow(
                  audioPath: promptAnswer,
                  duration: prompt.duration.toString(),
                  waveformData: prompt.waves ?? [],
                )
              else
                Text(
                  promptAnswer,
                  style: AppTextStyles.h3(
                    context,
                  ).copyWith(fontWeight: FontWeight.bold),
                ),
            ],
          ),

          if (isNeedEdit)
            Positioned(
              top: 0,
              right: 0,
              child: GestureDetector(
                onTap: onEditTap,
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: ColorPalette.primary,
                    shape: BoxShape.circle,
                  ),
                  child: SvgPicture.asset(
                    Assets.icons.edit.path,
                    height: 16,
                    width: 16,
                    colorFilter: const ColorFilter.mode(
                      Colors.white,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ),
            ),
          if (userId != null)
            Positioned(
              top: 0,
              right: 0,
              child: GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: () async {
                  log(
                    "Tapped poke on prompt ${prompt.id} with answer $promptAnswer",
                  );
                  final user = Di()
                      .sl<LoginCubit>()
                      .individualProfileData
                      ?.user;
                  Di().sl<HomeCubit>().selectedProfile = Member(
                    id: user?.id,
                    name: user?.firstName,
                    age: validateInt(calculateAge(user?.dob.toString() ?? "")),
                  );

                  await HomeBlurController.showWithBlur(
                    context: context,
                    builder: (context) => SendPokeBottomSheet(
                      pokeType: promptAnswer.isAudio
                          ? PokeType.audio
                          : PokeType.text,
                      targetId: prompt.id,
                      promptTitle: prompt.promptTitle,
                      promptAnswer: prompt.promptAnswer,
                    ),
                  );
                },
                child: Container(
                  height: 32,
                  width: 32,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: ColorPalette.primary,
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    AppEmojis.pointingRight,
                    style: AppTextStyles.h4(context),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
