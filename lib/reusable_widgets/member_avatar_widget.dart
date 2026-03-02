import 'package:fennac_app/app/constants/media_query_constants.dart';
import 'package:fennac_app/helpers/cached_network_image_helper.dart';
import 'package:flutter/material.dart';

class MemberAvatarWidget extends StatelessWidget {
  final List<String> avatarPaths;
  final int maxVisible;
  final double avatarSize;
  final double overlap;
  final Color? borderColor;
  final double borderWidth;
  final bool showShadow;
  final Color placeholderColor;
  final IconData placeholderIcon;
  final Color overflowBackgroundColor;
  final TextStyle? overflowTextStyle;

  const MemberAvatarWidget({
    super.key,
    required this.avatarPaths,
    this.maxVisible = 5,
    this.avatarSize = 60,
    this.overlap = 45,
    this.borderColor,
    this.borderWidth = 1.5,
    this.showShadow = true,
    this.placeholderColor = const Color(0xFF5E6570),
    this.placeholderIcon = Icons.person,
    this.overflowBackgroundColor = const Color(0xFF1a2332),
    this.overflowTextStyle,
  });

  @override
  Widget build(BuildContext context) {
    if (avatarPaths.isEmpty) {
      return const SizedBox.shrink();
    }

    return _buildAvatarsRow(context);
  }

  Color _getBorderColor(BuildContext context) {
    if (borderColor != null) return borderColor!;
    return isLightTheme(context) ? Colors.white : const Color(0xFF1a2332);
  }

  Widget _buildAvatarsRow(BuildContext context) {
    final displayAvatars = avatarPaths.take(maxVisible).toList();
    final hasOverflow = avatarPaths.length > maxVisible;
    final totalVisible = displayAvatars.length + (hasOverflow ? 1 : 0);

    final totalWidth = totalVisible > 0
        ? (totalVisible - 1) * overlap + avatarSize
        : 0.0;

    return Center(
      child: SizedBox(
        height: avatarSize,
        width: totalWidth,
        child: Stack(
          alignment: Alignment.center,
          children: [
            for (final entry in displayAvatars.indexed)
              Positioned(
                left: entry.$1 * overlap,
                child: _buildMemberAvatar(context, entry.$2),
              ),
            if (hasOverflow)
              Positioned(
                left: displayAvatars.length * overlap,
                child: _buildOverflowAvatar(
                  context,
                  avatarPaths.length - maxVisible,
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildMemberAvatar(BuildContext context, String imagePath) {
    final isNetworkImage = imagePath.startsWith('http');
    return Container(
      width: avatarSize,
      height: avatarSize,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: _getBorderColor(context), width: borderWidth),
        boxShadow: showShadow
            ? [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.3),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ]
            : null,
      ),
      child: ClipOval(
        child: isNetworkImage
            ? CachedImageHelper(
                imageUrl: imagePath,
                width: avatarSize,
                height: avatarSize,
                radius: avatarSize / 2,
                fit: BoxFit.cover,
              )
            : Image.asset(
                imagePath,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: placeholderColor,
                    child: Icon(
                      placeholderIcon,
                      color: Colors.white,
                      size: avatarSize * 0.5,
                    ),
                  );
                },
              ),
      ),
    );
  }

  Widget _buildOverflowAvatar(BuildContext context, int remaining) {
    return Container(
      width: avatarSize,
      height: avatarSize,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: overflowBackgroundColor,
        border: Border.all(color: _getBorderColor(context), width: borderWidth),
        boxShadow: showShadow
            ? [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.3),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ]
            : null,
      ),
      alignment: Alignment.center,
      child: Text(
        '+$remaining',
        style:
            overflowTextStyle ??
            Theme.of(context).textTheme.titleSmall?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
      ),
    );
  }
}
