import 'package:fennac_app/app/constants/media_query_constants.dart';
import 'package:fennac_app/app/theme/app_colors.dart';
import 'package:fennac_app/app/theme/text_styles.dart';
import 'package:fennac_app/widgets/custom_sized_box.dart';
import 'package:flutter/material.dart';

import '../../../../app/theme/app_emojis.dart';

class CallHistoryItem extends StatelessWidget {
  final String? name;
  final List<String>? names;
  final String? callType;
  final String? duration;
  final String? lastMessage;
  final String timeAgo;
  final int unreadCount;
  final String? avatar;
  final List<String>? avatars;
  final bool isGroup;
  final bool isPoked;
  final EdgeInsets? padding;
  final bool showBorder;
  final Color? backgroundColor;

  const CallHistoryItem({
    super.key,
    this.name,
    this.names,
    this.callType,
    this.duration,
    this.lastMessage,
    required this.timeAgo,
    this.unreadCount = 0,
    this.avatar,
    this.avatars,
    this.isGroup = false,
    this.padding,
    this.isPoked = false,
    this.showBorder = true,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    final isCallItem = callType != null && duration != null;

    return Container(
      padding:
          padding ?? const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      decoration: BoxDecoration(
        color:
            backgroundColor ??
            (isLightTheme(context)
                ? Colors.white
                : ColorPalette.secondary.withValues(alpha: 0.3)),
        border: showBorder
            ? Border(
                bottom: BorderSide(
                  color: ColorPalette.grey.withValues(
                    alpha: isLightTheme(context) ? 0.1 : 0.5,
                  ),
                  width: 1,
                ),
              )
            : null,
      ),
      child: Row(
        children: [
          // Avatar or avatars stack
          if (isGroup && avatars != null)
            _buildGroupAvatars()
          else
            _buildSingleAvatar(context),
          const SizedBox(width: 12),
          // Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      isGroup
                          ? ((names != null && names!.isNotEmpty)
                                ? names!.join(', ')
                                : 'Group')
                          : (name ?? ''),
                      style: AppTextStyles.body(context),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (unreadCount > 0)
                      Text(
                        unreadCount.toString(),
                        style: AppTextStyles.bodyRegular(context).copyWith(
                          color: ColorPalette.secondary,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                  ],
                ),
                const CustomSizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        _buildSecondaryText(isCallItem),
                        style: AppTextStyles.description(context).copyWith(
                          color: isLightTheme(context)
                              ? ColorPalette.black.withValues(alpha: 0.8)
                              : ColorPalette.textSecondary,
                        ),
                        maxLines: isCallItem ? 1 : 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const CustomSizedBox(width: 8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          timeAgo,
                          style: AppTextStyles.bodySmall(context).copyWith(
                            color: isLightTheme(context)
                                ? ColorPalette.black.withValues(alpha: 0.8)
                                : ColorPalette.textSecondary,
                            fontSize: 10,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _buildSecondaryText(bool isCallItem) {
    if (isCallItem) {
      return '$callType • $duration';
    } else {
      return lastMessage ?? '';
    }
  }

  Widget _buildSingleAvatar(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        // SizedBox(height: 52, width: 52),
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: ColorPalette.primary.withValues(alpha: 0.3),
              width: 2,
            ),
            image: DecorationImage(
              image: NetworkImage(avatar!),
              fit: BoxFit.cover,
            ),
          ),
        ),
        if (isPoked)
          Positioned(
            bottom: 0,
            right: 0,
            child: Container(
              height: 24,
              width: 24,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: ColorPalette.primary,
                border: Border.all(color: ColorPalette.white, width: 1),
              ),
              child: Text(
                AppEmojis.pointingRight,
                style: AppTextStyles.bodySmall(context),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildGroupAvatars() {
    return SizedBox(
      width: 48,
      height: 48,
      child: Stack(
        children: [
          // Top-left
          if (avatars!.isNotEmpty)
            Positioned(left: 0, top: 0, child: _buildAvatar(avatars![0])),
          // Top-right
          if (avatars!.length > 1)
            Positioned(left: 24, top: 0, child: _buildAvatar(avatars![1])),
          // Bottom-left
          if (avatars!.length > 3)
            Positioned(left: 0, top: 24, child: _buildAvatar(avatars![3])),
          // Bottom-right
          if (avatars!.length > 4)
            Positioned(left: 24, top: 24, child: _buildAvatar(avatars![4])),
          // Center on top
          if (avatars!.length > 2)
            Positioned(left: 12, top: 12, child: _buildAvatar(avatars![2])),
        ],
      ),
    );
  }

  Widget _buildAvatar(String assetPath) {
    return Container(
      width: 24,
      height: 24,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: ColorPalette.secondary, width: 1),
        image: DecorationImage(
          image: NetworkImage(assetPath),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
