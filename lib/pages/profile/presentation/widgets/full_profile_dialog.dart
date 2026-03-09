import 'package:fennac_app/app/constants/media_query_constants.dart';
import 'package:fennac_app/app/theme/app_colors.dart';
import 'package:fennac_app/app/theme/app_emojis.dart';
import 'package:fennac_app/app/theme/text_styles.dart';
import 'package:fennac_app/core/di_container.dart';
import 'package:fennac_app/core/extensions/string_extension.dart';
import 'package:fennac_app/generated/assets.gen.dart';
import 'package:fennac_app/pages/auth/presentation/bloc/cubit/login_cubit.dart';
import 'package:fennac_app/pages/home/presentation/widgets/group_gallery_widget.dart';
import 'package:fennac_app/pages/home/presentation/widgets/hero_section.dart';
import 'package:fennac_app/pages/profile/presentation/widgets/profile_avatar.dart';
import 'package:fennac_app/pages/profile/presentation/widgets/profile_chip.dart';
import 'package:fennac_app/utils/validators.dart';
import 'package:fennac_app/widgets/custom_sized_box.dart';
import 'package:fennac_app/widgets/prompt_audio_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../edit_profile/presentation/widgets/interleaved_media_section.dart';

class FullProfileDialog extends StatefulWidget {
  final bool isEditProfile;
  final ScrollController? scrollController;

  const FullProfileDialog({
    super.key,
    this.isEditProfile = false,
    this.scrollController,
  });

  @override
  State<FullProfileDialog> createState() => _FullProfileDialogState();
}

class _FullProfileDialogState extends State<FullProfileDialog> {
  final LoginCubit _loginCubit = Di().sl<LoginCubit>();

  @override
  void initState() {
    super.initState();
    Future.microtask(() => _loginCubit.getSelfInfo());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, dynamic>(
      bloc: _loginCubit,
      builder: (context, state) {
        final user = _loginCubit.userData?.user;
        return ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(32),
            topRight: Radius.circular(32),
          ),
          child: Container(
            decoration: BoxDecoration(
              gradient: isDarkTheme(context)
                  ? LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Color(0xFF16003F), Color(0xFF111111)],
                    )
                  : null,
              color: isLightTheme(context) ? Colors.white : null,
            ),
            child: SafeArea(
              top: false,
              child: ListView(
                controller: widget.scrollController,
                padding: EdgeInsets.zero,
                children: [
                  CustomSizedBox(height: 16),
                  if (widget.isEditProfile && user != null ||
                      (user?.bestShorts?.isNotEmpty ?? false)) ...[
                    CircleAvatar(
                      radius: 60,
                      child: ProfileAvatar(
                        imageUrl: (user?.bestShorts?.isNotEmpty ?? false)
                            ? user!.bestShorts!.first
                            : '',
                        size: 120,
                      ),
                    ),
                    const SizedBox(height: 24),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '${user?.firstName ?? ''} ${user?.lastName ?? ''}${user?.dob != null ? ', ${calculateAge(user?.dob.toString() ?? "")}' : ''}',
                            style: AppTextStyles.h3(
                              context,
                            ).copyWith(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(width: 8),
                          SvgPicture.asset(
                            Assets.icons.verified.path,
                            height: 20,
                            width: 20,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      alignment: WrapAlignment.center,
                      children: [
                        ProfileChip(
                          label:
                              _loginCubit
                                      .userData
                                      ?.user
                                      ?.sexualOrientation
                                      ?.isNotEmpty ??
                                  false
                              ? _loginCubit
                                    .userData!
                                    .user!
                                    .sexualOrientation!
                                    .first
                              : 'Straight',
                        ),
                        ProfileChip(
                          label:
                              _loginCubit.userData?.user?.pronouns ?? 'He/Him',
                        ),
                        ProfileChip(
                          icon: Assets.icons.mapPin.path,
                          label:
                              '${_loginCubit.userData?.user?.v ?? 'Austin, TX'}',
                        ),
                        ProfileChip(
                          icon: Assets.icons.navigation.path,
                          label: 'Distance',
                        ),
                      ],
                    ),
                    const CustomSizedBox(height: 16),
                    Wrap(
                      spacing: 8,
                      alignment: WrapAlignment.center,
                      children: [
                        ProfileChip(
                          icon: Assets.icons.bag.path,
                          label:
                              _loginCubit.userData?.user?.education ??
                              'Stanford University',
                        ),
                        ProfileChip(
                          icon: Assets.icons.cap.path,
                          label:
                              _loginCubit.userData?.user?.jobTitle ??
                              'Software Engineer',
                        ),
                      ],
                    ),
                    const CustomSizedBox(height: 12),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Text(
                        user?.shortBio ?? '',
                        textAlign: TextAlign.center,
                        style: AppTextStyles.body(context).copyWith(
                          color: isLightTheme(context)
                              ? Colors.black87
                              : Colors.white70,
                        ),
                      ),
                    ),
                    if (_loginCubit.userData?.prompts?.isNotEmpty ??
                        false || (user?.bestShorts?.isNotEmpty ?? false))
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: InterleavedMediaSection(
                          bestShorts: user?.bestShorts ?? [],
                          prompts: _loginCubit.userData?.prompts ?? [],
                          onImageEditTap: () {},
                          onPromptEditTap: (prompt, isEdit) {},
                          isNeedEdit: false,
                        ),
                      ),
                  ] else ...[
                    if (user?.bestShorts?.isNotEmpty ?? false)
                      HeroSection(
                        imagePath: user?.bestShorts?.first ?? "",
                        avatarPaths: user?.bestShorts ?? [],
                      ),
                    CustomSizedBox(height: 24),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Text(
                        user?.firstName ?? "",
                        textAlign: TextAlign.center,
                        style: AppTextStyles.h1Large(context).copyWith(
                          color: isLightTheme(context)
                              ? Colors.black87
                              : Colors.white70,
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Text(
                        'Just a bunch of friends who love spontaneous road trips, rooftop sunsets, concerts, and pretending we\'re outdoorsy (until it rains).',
                        textAlign: TextAlign.center,
                        style: AppTextStyles.bodyRegular(context).copyWith(
                          fontSize: 16,
                          color: isLightTheme(context)
                              ? Colors.black87
                              : Colors.white70,
                        ),
                      ),
                    ),
                    const CustomSizedBox(height: 20),
                    Container(
                      height: 44,
                      width: 68,
                      margin: const EdgeInsets.symmetric(horizontal: 110),
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        color: isDarkTheme(context)
                            ? ColorPalette.secondary
                            : ColorPalette.textGrey,
                        borderRadius: BorderRadius.circular(28),
                        border: Border.all(
                          color: ColorPalette.primary,
                          width: 1,
                        ),
                      ),
                      child: Text(
                        '${AppEmojis.backpack} Travel & Adventure',
                        style: AppTextStyles.chipLabel(
                          context,
                        ).copyWith(fontWeight: FontWeight.w600),
                      ),
                    ),
                    const CustomSizedBox(height: 20),
                  ],
                  if (widget.isEditProfile == false)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: GroupGalleryWidget(
                        onTapRight: () {},
                        onTapLeft: () {},
                        isShowReportButton: false,
                      ),
                    ),
                  const CustomSizedBox(height: 40),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildPromptCard(BuildContext context, dynamic prompt) {
    String promptTitle = '';
    String promptAnswer = '';

    // Handle both typed and dynamic prompts
    if (prompt is Map<String, dynamic>) {
      promptTitle = (prompt['promptTitle'] as String?) ?? '';
      promptAnswer = (prompt['promptAnswer'] as String?) ?? '';
    } else {
      promptTitle = prompt.promptTitle?.toString() ?? '';
      promptAnswer = prompt.promptAnswer?.toString() ?? '';
    }

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
          Text(promptTitle, style: AppTextStyles.subHeading(context)),
          const SizedBox(height: 14),
          if (promptAnswer.isAudio)
            PromptAudioRow(
              audioPath: promptAnswer,
              duration: '',
              waveformData: [],
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
    );
  }
}
