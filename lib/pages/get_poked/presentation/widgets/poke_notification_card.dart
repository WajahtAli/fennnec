import 'package:fennac_app/app/theme/app_colors.dart';
import 'package:fennac_app/app/theme/text_styles.dart';
import 'package:fennac_app/helpers/gradient_toast.dart';
import 'package:fennac_app/widgets/custom_elevated_button.dart';
import 'package:fennac_app/widgets/custom_outlined_button.dart';
import 'package:fennac_app/widgets/custom_sized_box.dart';
import 'package:fennac_app/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:fennac_app/widgets/app_inkwell.dart';
import 'package:fennac_app/pages/chats/data/models/chat_and_calls_response.dart';

import '../../../../app/constants/media_query_constants.dart';

class PokeNotificationCard extends StatelessWidget {
  final PokerFromUser fromUser;
  final PokedTargetDetail targetDetail;
  final VoidCallback onIgnore;
  final VoidCallback onStartChat;

  final int pokeCount;
  final PokeActiveGroupModel? activeGroup;
  final VoidCallback? onViewGroupProfile;

  const PokeNotificationCard({
    super.key,
    required this.fromUser,
    required this.targetDetail,
    required this.onIgnore,
    required this.onStartChat,
    this.pokeCount = 1,
    this.activeGroup,
    this.onViewGroupProfile,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          padding: const EdgeInsets.only(left: 20, right: 20, bottom: 30),
          decoration: BoxDecoration(
            color: isLightTheme(context)
                ? Colors.white
                : ColorPalette.secondary,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(32),
              topRight: Radius.circular(32),
            ),
            boxShadow: [
              isLightTheme(context)
                  ? BoxShadow(
                      color: Colors.black.withValues(alpha: 0.1),
                      blurRadius: 10,
                      offset: const Offset(0, -5),
                    )
                  : null,
            ].whereType<BoxShadow>().toList(),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const CustomSizedBox(height: 24),
              Center(
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: isLightTheme(context)
                        ? ColorPalette.white
                        : ColorPalette.secondary,
                    shape: BoxShape.circle,
                  ),
                  child: Container(
                    height: 60,
                    width: 60,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: NetworkImage(
                          fromUser.bestShorts.isNotEmpty
                              ? fromUser.bestShorts.first
                              : '',
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
              const CustomSizedBox(height: 24),
              AppText(
                text: pokeCount > 1 ? 'You Got $pokeCount Pokes!' : 'You Got a Poke!',
                style: AppTextStyles.h2(
                  context,
                ).copyWith(fontWeight: FontWeight.bold),
              ),
              const CustomSizedBox(height: 24),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: AppTextStyles.body(
                    context,
                  ).copyWith(color: ColorPalette.textSecondary, height: 1.5),
                  children: [
                    TextSpan(
                      text: '${fromUser.firstName} ${fromUser.lastName ?? ''}',
                      style: AppTextStyles.body(
                        context,
                      ).copyWith(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text:
                          ' poked you on your ${targetDetail.type} — guess it caught\ntheir attention 👀',
                      style: AppTextStyles.body(context),
                    ),
                  ],
                ),
              ),
              const CustomSizedBox(height: 24),
              // Profile/Target Info Area
              if (targetDetail.type == 'profile' &&
                  targetDetail.profile != null)
                              // Active Group members row
                              if (activeGroup != null && activeGroup!.members.isNotEmpty)
                                GestureDetector(
                                  onTap: onViewGroupProfile,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                                    decoration: BoxDecoration(
                                      color: isLightTheme(context)
                                          ? ColorPalette.textGrey
                                          : ColorPalette.primary.withValues(alpha: 0.5),
                                      borderRadius: BorderRadius.circular(24),
                                    ),
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          height: 44,
                                          width: (activeGroup!.members.take(4).length * 28.0 + 16),
                                          child: Stack(
                                            children: List.generate(
                                              activeGroup!.members.take(4).length,
                                              (index) {
                                                final member = activeGroup!.members[index];
                                                final imageUrl = member.image ?? '';
                                                return Positioned(
                                                  left: index * 24.0,
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      border: Border.all(
                                                        color: ColorPalette.secondary,
                                                        width: 2,
                                                      ),
                                                    ),
                                                    child: CircleAvatar(
                                                      radius: 20,
                                                      backgroundImage: imageUrl.isNotEmpty
                                                          ? NetworkImage(imageUrl)
                                                          : null,
                                                      backgroundColor: ColorPalette.primary.withValues(alpha: 0.3),
                                                    ),
                                                  ),
                                                );
                                              },
                                            ),
                                          ),
                                        ),
                                        const Spacer(),
                                        AppText(
                                          text: 'View Group Profile',
                                          style: AppTextStyles.bodySmall(
                                            context,
                                          ).copyWith(fontWeight: FontWeight.w600),
                                        ),
                                        const CustomSizedBox(width: 4),
                                        Icon(
                                          Icons.arrow_outward_rounded,
                                          color: isLightTheme(context)
                                              ? ColorPalette.black
                                              : ColorPalette.white,
                                          size: 16,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              if (activeGroup != null && activeGroup!.members.isNotEmpty)
                                const CustomSizedBox(height: 16),
                              // Profile/Target Info Area
                              if (activeGroup == null && targetDetail.type == 'profile' &&
                                  targetDetail.profile != null)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    color: isLightTheme(context)
                        ? ColorPalette.textGrey
                        : ColorPalette.primary.withValues(alpha: 0.5),
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Row(
                    children: [
                      SizedBox(
                        height: 44,
                        width: 130,
                        child: Stack(
                          children: List.generate(
                            targetDetail.profile!.bestShorts.take(4).length,
                            (index) {
                              return Positioned(
                                left: index * 24.0,
                                child: Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: ColorPalette.secondary,
                                      width: 2,
                                    ),
                                  ),
                                  child: CircleAvatar(
                                    radius: 20,
                                    backgroundImage: NetworkImage(
                                      targetDetail.profile!.bestShorts[index],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      const Spacer(),
                      AppInkWell(
                        onTap: () {
                          // View Profile logic using targetDetail.profile
                        },
                        child: AppText(
                          text: 'View Profile',
                          style: AppTextStyles.bodySmall(
                            context,
                          ).copyWith(fontWeight: FontWeight.w600),
                        ),
                      ),
                      const CustomSizedBox(width: 4),
                      Icon(
                        Icons.arrow_outward_rounded,
                        color: isLightTheme(context)
                            ? ColorPalette.black
                            : ColorPalette.white,
                        size: 16,
                      ),
                    ],
                  ),
                ),
              const CustomSizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: CustomOutlinedButton(
                      text: 'Ignore',
                      onPressed: onIgnore,
                      borderColor: isLightTheme(context)
                          ? ColorPalette.secondary
                          : ColorPalette.white,
                      textColor: isLightTheme(context)
                          ? ColorPalette.secondary
                          : ColorPalette.white,
                      borderRadius: 30,
                    ),
                  ),
                  const CustomSizedBox(width: 16),
                  Expanded(
                    child: CustomElevatedButton(
                      text: 'Start Chat',
                      onTap: onStartChat,
                      backgroundColor: ColorPalette.primary,
                    ),
                  ),
                ],
              ),
              const CustomSizedBox(height: 16),
              AppInkWell(
                onTap: () {
                  // Report and Block
                  VxToast.show(
                    message: 'Report and block feature coming soon!',
                  );
                },
                child: AppText(
                  text: 'Report and block',
                  style: AppTextStyles.bodyLarge(context),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
