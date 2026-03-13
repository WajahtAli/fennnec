import 'package:cached_network_image/cached_network_image.dart';
import 'package:fennac_app/app/constants/media_query_constants.dart';
import 'package:fennac_app/app/theme/app_colors.dart';
import 'package:fennac_app/app/theme/text_styles.dart';
import 'package:fennac_app/pages/chats/data/models/chat_and_calls_response.dart';
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
  final String? avatar;
  final List<String>? avatars;
  final bool isGroup;
  final bool isPoked;
  final EdgeInsets? padding;
  final bool showBorder;
  final Color? backgroundColor;

  // New optional models
  final ChatModel? chatModel;
  final CallModel? callModel;

  const CallHistoryItem({
    super.key,
    this.name,
    this.names,
    this.callType,
    this.duration,
    this.lastMessage,
    required this.timeAgo,
    this.avatar,
    this.avatars,
    this.isGroup = false,
    this.padding,
    this.isPoked = false,
    this.showBorder = true,
    this.backgroundColor,
    this.chatModel,
    this.callModel,
  });

  @override
  Widget build(BuildContext context) {
    // Determine data source
    final bool isGroupVal = chatModel?.type == 'group' || isGroup;
    final String nameVal =
        chatModel?.name ??
        (isGroup
            ? (names?.join(', ') ?? '')
            : (name ?? ''));

    final String lastMessageVal =
        chatModel?.lastMessage ?? lastMessage ?? '';
    final String timeVal = chatModel != null ? '' : timeAgo; // Placeholder for time
    final String? singleAvatar =
        chatModel?.members?.isNotEmpty == true
            ? chatModel?.members?.first.image
            : avatar;

    final List<String> groupAvatars =
        chatModel?.members?.map((e) => e.image ?? '').toList() ??
        avatars ??
        [];

    final isCallItem = callType != null && duration != null || callModel != null;

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
          if (isGroupVal && groupAvatars.isNotEmpty)
            _buildGroupAvatars(groupAvatars)
          else
            _buildSingleAvatar(context, singleAvatar),
          const SizedBox(width: 12),
          // Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  nameVal,
                  style: AppTextStyles.body(context),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const CustomSizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      isCallItem
                          ? (callModel != null
                              ? '${callModel!.callTypeLabel ?? ''} • ${callModel!.duration ?? ''}'
                              : '$callType • $duration')
                          : lastMessageVal,
                      style: AppTextStyles.description(context).copyWith(
                        color: isLightTheme(context)
                            ? ColorPalette.black.withValues(alpha: 0.8)
                            : ColorPalette.textSecondary,
                      ),
                      maxLines: isCallItem ? 1 : 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      callModel?.timeAgo ?? timeVal,
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
          ),
        ],
      ),
    );
  }

  Widget _buildSingleAvatar(BuildContext context, String? avatarPath) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: ColorPalette.primary.withValues(alpha: 0.3),
              width: 2,
            ),
          ),
          child: ClipOval(
            child:
                avatarPath != null &&
                        (avatarPath.startsWith('http') ||
                            avatarPath.contains('assets/'))
                    ? (avatarPath.startsWith('http')
                        ? CachedNetworkImage(
                          imageUrl: avatarPath,
                          fit: BoxFit.cover,
                          placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                          errorWidget: (context, url, error) => const Icon(Icons.person),
                        )
                        : Image.asset(avatarPath, fit: BoxFit.cover))
                    : const Icon(Icons.person),
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

  Widget _buildGroupAvatars(List<String> avatarPaths) {
    return SizedBox(
      width: 48,
      height: 48,
      child: Stack(
        children: [
          // Top-left
          if (avatarPaths.isNotEmpty)
            Positioned(left: 0, top: 0, child: _buildAvatar(avatarPaths[0])),
          // Top-right
          if (avatarPaths.length > 1)
            Positioned(left: 24, top: 0, child: _buildAvatar(avatarPaths[1])),
          // Bottom-left
          if (avatarPaths.length > 3)
            Positioned(left: 0, top: 24, child: _buildAvatar(avatarPaths[3])),
          // Bottom-right
          if (avatarPaths.length > 4)
            Positioned(left: 24, top: 24, child: _buildAvatar(avatarPaths[4])),
          // Center on top
          if (avatarPaths.length > 2)
            Positioned(left: 12, top: 12, child: _buildAvatar(avatarPaths[2])),
        ],
      ),
    );
  }

  Widget _buildAvatar(String avatarPath) {
    return Container(
      width: 24,
      height: 24,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: ColorPalette.secondary, width: 1),
      ),
      child: ClipOval(
        child:
            avatarPath.startsWith('http')
                ? CachedNetworkImage(
                  imageUrl: avatarPath,
                  fit: BoxFit.cover,
                  errorWidget: (context, url, error) => const Icon(Icons.person, size: 12),
                )
                : Image.asset(avatarPath, fit: BoxFit.cover),
      ),
    );
  }
}
