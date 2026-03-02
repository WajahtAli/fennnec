import 'dart:ui';

import 'package:auto_route/auto_route.dart';
import 'package:fennac_app/app/constants/dummy_constants.dart';
import 'package:fennac_app/app/constants/media_query_constants.dart';
import 'package:fennac_app/app/theme/app_colors.dart';
import 'package:fennac_app/app/theme/text_styles.dart';
import 'package:fennac_app/core/di_container.dart';
import 'package:fennac_app/generated/assets.gen.dart';
import 'package:fennac_app/pages/chats/presentation/bloc/cubit/chat_landing_cubit.dart';
import 'package:fennac_app/pages/chats/presentation/bloc/state/chat_landing_state.dart';
import 'package:fennac_app/pages/chats/presentation/widgets/chat_tab_selector.dart';
import 'package:fennac_app/pages/chats/presentation/widgets/group_detail_members_avatar.dart';
import 'package:fennac_app/pages/dashboard/presentation/bloc/cubit/dashboard_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fennac_app/reusable_widgets/animated_background_container.dart';
import 'package:fennac_app/reusable_widgets/custom_app_bar.dart';
import 'package:fennac_app/routes/routes_imports.gr.dart';
import 'package:fennac_app/widgets/custom_bottom_sheet.dart';
import 'package:fennac_app/widgets/custom_sized_box.dart';
import 'package:fennac_app/widgets/custom_text_field.dart';
import 'package:fennac_app/widgets/movable_background.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';

@RoutePage()
class GroupDetailScreen extends StatefulWidget {
  final bool isGroup;
  final String? contactName;
  final String? contactAvatar;
  final bool isOnline;

  const GroupDetailScreen({
    super.key,
    this.isGroup = true,
    this.contactName,
    this.contactAvatar,
    this.isOnline = false,
  });

  @override
  State<GroupDetailScreen> createState() => _GroupDetailScreenState();
}

class _GroupDetailScreenState extends State<GroupDetailScreen> {
  final ValueNotifier<bool> _blurNotifier = ValueNotifier(false);
  final TextEditingController _nameController = TextEditingController(
    text: 'Weekend Warriors',
  );

  @override
  void dispose() {
    _blurNotifier.dispose();
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPalette.secondary,
      body: Stack(
        children: [
          MovableBackground(
            backgroundType: MovableBackgroundType.dark,
            child: SafeArea(
              child: ValueListenableBuilder<bool>(
                valueListenable: _blurNotifier,
                builder: (context, isBlurred, child) {
                  return Stack(
                    children: [
                      child!,
                      if (isBlurred)
                        Positioned.fill(
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
                            child: Container(
                              color: Colors.black.withValues(alpha: 0.35),
                            ),
                          ),
                        ),
                    ],
                  );
                },
                child: _buildContent(context),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CustomAppBar(title: 'Group Details'),
          const CustomSizedBox(height: 16),
          const GroupDetailMembersAvatar(),
          CustomLabelTextField(
            controller: _nameController,
            hintText: 'Enter group name',
            textStyle: AppTextStyles.h4(
              context,
            ).copyWith(fontWeight: FontWeight.w700),
            filled: false,
            isCentered: true,

            suffix: SvgPicture.asset(
              Assets.icons.edit3.path,
              width: 16,
              height: 16,
              colorFilter: ColorFilter.mode(
                isLightTheme(context)
                    ? ColorPalette.black
                    : ColorPalette.textSecondary,
                BlendMode.srcIn,
              ),
            ),
          ),
          const CustomSizedBox(height: 20),
          ChatTabSelector(title1: 'About This Group', title2: 'Shared Media'),
          const CustomSizedBox(height: 20),
          BlocBuilder<ChatLandingCubit, ChatLandingState>(
            bloc: Di().sl<ChatLandingCubit>(),
            builder: (context, state) {
              final selectedTab = Di().sl<ChatLandingCubit>().selectedTabIndex;
              return selectedTab == 0
                  ? _buildAboutThisGroupContent(context)
                  : _buildSharedMediaContent(context);
            },
          ),
          const CustomSizedBox(height: 32),
        ],
      ),
    );
  }

  Widget _buildMatchedCard(BuildContext context) {
    return Container(
      height: 273,
      width: double.infinity,
      decoration: BoxDecoration(
        color: isLightTheme(context)
            ? ColorPalette.textGrey
            : ColorPalette.black.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(20),
      ),
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: 100,
            height: 100,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Lottie.asset(
                  Assets.animations.iconBg,
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                ),

                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Matched',
                        style: AppTextStyles.description(context),
                      ),
                      Text('2', style: AppTextStyles.h1(context)),
                      Text(
                        'months ago',
                        style: AppTextStyles.description(context),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const CustomSizedBox(height: 16),
          Text(
            'Common Interests',
            style: AppTextStyles.label(
              context,
            ).copyWith(fontWeight: FontWeight.w700),
          ),
          const CustomSizedBox(height: 8),

          _buildInterests(context),
        ],
      ),
    );
  }

  Widget _buildAboutThisGroupContent(BuildContext context) {
    return Column(
      children: [
        _buildMatchedCard(context),
        const CustomSizedBox(height: 32),
        _buildUnmatchButton(context),
      ],
    );
  }

  Widget _buildSharedMediaContent(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        childAspectRatio: 1,
      ),
      itemCount: DummyConstants.mediaItems.length,
      itemBuilder: (context, index) {
        final item = DummyConstants.mediaItems[index];
        return _buildMediaItem(item);
      },
    );
  }

  Widget _buildMediaItem(Map<String, dynamic> item) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Stack(
        fit: StackFit.expand,
        children: [
          // Media thumbnail
          Image.asset(
            item['image'],
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                color: ColorPalette.black.withValues(alpha: 0.5),
                child: const Icon(Icons.image, color: Colors.white, size: 40),
              );
            },
          ),
          // Play button overlay for videos
          if (item['type'] == 'video')
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withValues(alpha: 0.3),
                  ],
                ),
              ),
              child: Center(
                child: Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.9),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.play_arrow,
                    color: Colors.black,
                    size: 32,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildInterests(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      alignment: WrapAlignment.center,
      children: DummyConstants.interestsGroup.map((interest) {
        // Split emoji and text
        final parts = interest.split(' ');
        final emoji = parts.isNotEmpty ? parts[0] : '';
        final text = parts.length > 1 ? parts.sublist(1).join(' ') : interest;

        return ClipRRect(
          borderRadius: BorderRadius.circular(48),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
            child: Container(
              height: 24,
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
              decoration: BoxDecoration(
                color: isLightTheme(context)
                    ? ColorPalette.textGrey
                    : ColorPalette.primary,
                border: Border.all(
                  color: isLightTheme(context)
                      ? ColorPalette.primary
                      : Colors.transparent,
                ),
                borderRadius: BorderRadius.circular(48),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(emoji, style: const TextStyle(fontSize: 14)),
                  const CustomSizedBox(width: 6),
                  Text(
                    text,
                    style: AppTextStyles.bodySmall(
                      context,
                    ).copyWith(fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildUnmatchButton(BuildContext context) {
    return GestureDetector(
      onTap: () {
        CustomBottomSheet.show(
          icon: AnimatedBackgroundContainer(
            icon: Assets.icons.alertTriangle.path,
          ),
          context: context,
          title: 'Unmatch this Group?',
          description:
              'By unmatching it will unmatch the entire group not just you. You’ll lose access to your chat and shared media with this group. They won’t be notified, but they’ll no longer see your group in their matches.',
          buttonText: 'Dismiss',
          secondaryButtonText: 'Unmatch',
          onButtonPressed: () {},
          onSecondaryButtonPressed: () {
            Navigator.of(context).pop();
            CustomBottomSheet.show(
              icon: AnimatedBackgroundContainer(
                icon: Assets.icons.heartBroken.path,
                isPng: true,
                iconHeight: 56,
                iconWidth: 56,
              ),
              context: context,
              title: 'You’ve Unmatched This Group',
              description:
                  'We’ve closed your chat and removed this group from your matches. You can still find new connections.',
              buttonText: 'Explore Groups',
              onButtonPressed: () {
                AutoRouter.of(context).push(DashboardRoute());
                Di().sl<DashboardCubit>().changeIndex(0);
              },
            );
          },
          blurNotifier: _blurNotifier,
          isHorizontalButton: true,
        );
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        decoration: BoxDecoration(
          color: isLightTheme(context)
              ? ColorPalette.textGrey
              : ColorPalette.black.withValues(alpha: 0.25),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isLightTheme(context)
                ? ColorPalette.textGrey
                : ColorPalette.black.withValues(alpha: 0.4),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Unmatch Group',
              style: AppTextStyles.body(
                context,
              ).copyWith(color: Colors.redAccent, fontWeight: FontWeight.w700),
            ),
            Icon(Icons.arrow_forward_ios, color: Colors.redAccent, size: 20),
          ],
        ),
      ),
    );
  }
}
