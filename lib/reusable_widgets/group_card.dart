import 'dart:ui';
import 'package:auto_route/auto_route.dart';
import 'package:fennac_app/app/constants/media_query_constants.dart';
import 'package:fennac_app/app/theme/app_colors.dart';
import 'package:fennac_app/app/theme/app_emojis.dart';
import 'package:fennac_app/app/theme/text_styles.dart';
import 'package:fennac_app/generated/assets.gen.dart';
import 'package:fennac_app/pages/create_group/presentation/widgets/interest_chip.dart';
import 'package:fennac_app/reusable_widgets/member_avatar_widget.dart';
import 'package:fennac_app/routes/routes_imports.gr.dart';
import 'package:fennac_app/utils/validators.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class GroupCard extends StatelessWidget {
  final String title;
  final String? subtitle;
  final String? chipLabel;
  final double? height;
  final List<String> avatarPaths;
  final List<String> memberNames;
  final VoidCallback? onMenuPressed;

  final Color? backgroundColor;
  final bool isShowInfoIcon;
  final bool isEditMode;
  final String? createdByName;
  final DateTime? createdAt;

  const GroupCard({
    super.key,
    required this.title,
    this.subtitle,
    this.chipLabel,
    this.height,
    this.avatarPaths = const [],
    this.memberNames = const [],
    this.onMenuPressed,
    this.backgroundColor,
    this.isShowInfoIcon = true,
    this.isEditMode = false,
    this.createdByName,
    this.createdAt,
  });

  @override
  Widget build(BuildContext context) {
    final cardWidth = getWidth(context) - 32;
    final maxWidth = 392.0;
    final actualWidth = cardWidth > maxWidth ? maxWidth : cardWidth;

    return Column(
      children: [
        Container(
          // width: actualWidth,
          // height: height ?? 166,
          margin: EdgeInsets.symmetric(
            horizontal: isEditMode ? 0 : 16,
            vertical: 8,
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(24),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color:
                      backgroundColor ??
                      (isLightTheme(context)
                          ? ColorPalette.textGrey
                          : ColorPalette.black.withValues(alpha: 0.3)),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Stack(
                  children: [
                    // Menu icon - top right
                    if (isShowInfoIcon)
                      Positioned(
                        top: 8,
                        right: 8,
                        child: GestureDetector(
                          onTap:
                              onMenuPressed ??
                              () {
                                if (isEditMode) {
                                  AutoRouter.of(
                                    context,
                                  ).push(CreateGroupRoute(isEditMode: true));
                                }
                              },

                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: isEditMode
                                  ? ColorPalette.primary
                                  : Colors.transparent,
                              shape: BoxShape.circle,
                            ),
                            child: SvgPicture.asset(
                              isEditMode
                                  ? Assets.icons.edit.path
                                  : Assets.icons.moreVertical.path,
                              height: isEditMode ? 14 : 24,
                              width: 14,
                              colorFilter: ColorFilter.mode(
                                isEditMode
                                    ? Colors.white
                                    : (isLightTheme(context)
                                          ? Colors.black
                                          : Colors.white),
                                BlendMode.srcIn,
                              ),
                            ),
                          ),
                        ),
                      ),
                    // Positioned(
                    //   top: 0,
                    //   right: 0,
                    //   child: IconButton(
                    //     padding: EdgeInsets.zero,
                    //     constraints: const BoxConstraints(),
                    //     icon: Icon(
                    //       isEditMode ? Icons.edit : Icons.more_vert,
                    //       color: isLightTheme(context)
                    //           ? Colors.black
                    //           : Colors.white,
                    //       size: 24,
                    //     ),
                    //     onPressed: onMenuPressed,
                    //   ),
                    // ),
                    // Main content
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        MemberAvatarWidget(
                          avatarPaths: avatarPaths,
                          memberNames: memberNames,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          title,
                          style: AppTextStyles.h4(context),
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          subtitle ?? '',
                          style: AppTextStyles.description(context),
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        if (createdByName != null && createdAt != null) ...[
                          const SizedBox(height: 8),
                          Text(
                            'Created by $createdByName • ${getTimeAgo(createdAt!)}',
                            style: AppTextStyles.bodySmall(context).copyWith(
                              color: isLightTheme(context)
                                  ? Colors.black.withValues(alpha: 0.6)
                                  : Colors.white.withValues(alpha: 0.6),
                            ),
                            textAlign: TextAlign.center,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                        if (isEditMode && chipLabel != null) ...[
                          const SizedBox(height: 12),
                          InterestChip(
                            emoji: AppEmojis.mountain,
                            label: chipLabel ?? '',
                            isSelected: true,
                            onTap: () {},
                          ),
                        ],
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
