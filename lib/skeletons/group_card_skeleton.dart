import 'dart:ui';

import 'package:fennac_app/app/constants/media_query_constants.dart';
import 'package:fennac_app/app/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class GroupCardSkeleton extends StatelessWidget {
  final double? height;
  final bool isShowInfoIcon;

  const GroupCardSkeleton({super.key, this.height, this.isShowInfoIcon = true});

  @override
  Widget build(BuildContext context) {
    final cardWidth = getWidth(context) - 32;
    final maxWidth = 392.0;
    final actualWidth = cardWidth > maxWidth ? maxWidth : cardWidth;

    final isDark = Theme.of(context).brightness == Brightness.dark;
    final backgroundColor = isDark
        ? ColorPalette.cardBlack
        : ColorPalette.white;
    final shimmerBase = isDark
        ? ColorPalette.cardBlack
        : const Color(0xFFF0F0F0);
    final shimmerHighlight = isDark
        ? const Color(0xFF333333)
        : ColorPalette.lightDivider;

    return Column(
      children: [
        Container(
          // width: actualWidth,
          height: isShowInfoIcon ? height ?? 130 : null,
          margin: EdgeInsets.symmetric(
            horizontal: !isShowInfoIcon ? 16 : 0,
            vertical: 8,
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(24),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
              child: Shimmer.fromColors(
                baseColor: shimmerBase,
                highlightColor: shimmerHighlight,
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: backgroundColor,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Stack(
                    children: [
                      if (isShowInfoIcon)
                        Positioned(
                          top: 0,
                          right: 0,
                          child: Container(
                            width: 24,
                            height: 24,
                            decoration: BoxDecoration(
                              color: backgroundColor,
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          _buildAvatarsRow(backgroundColor),
                          const SizedBox(height: 16),
                          Container(
                            width: actualWidth * 0.6,
                            height: 16,
                            decoration: BoxDecoration(
                              color: backgroundColor,
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          const SizedBox(height: 16),
                          Container(
                            width: actualWidth * 0.5,
                            height: 12,
                            decoration: BoxDecoration(
                              color: backgroundColor,
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAvatarsRow(Color color) {
    const avatarSize = 60.0;
    const overlap = 45.0;
    const avatarCount = 5;
    final totalWidth = (avatarCount - 1) * overlap + avatarSize;

    return Center(
      child: SizedBox(
        height: avatarSize,
        width: totalWidth,
        child: Stack(
          alignment: Alignment.center,
          children: List.generate(
            avatarCount,
            (index) => Positioned(
              left: index * overlap,
              child: Container(
                width: avatarSize,
                height: avatarSize,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: color,
                  border: Border.all(
                    color: const Color(0xFF1a2332),
                    width: 2.5,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
