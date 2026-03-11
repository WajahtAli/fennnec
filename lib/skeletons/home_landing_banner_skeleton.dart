import 'package:fennac_app/app/constants/media_query_constants.dart';
import 'package:fennac_app/app/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class HomeLandingBannerSkeleton extends StatelessWidget {
  const HomeLandingBannerSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final backgroundColor = isDark ? ColorPalette.cardBlack : Colors.white;
    final shimmerBase = isDark ? ColorPalette.cardBlack : Colors.white;
    final shimmerHighlight = isDark ? const Color(0xFF333333) : Colors.white;

    // Mirrors HomeLandingBanner exactly
    final double cardHeight = getWidth(context) > 370 ? 370 : 320;
    final double imageHeight = getWidth(context) > 370 ? 250 : 200;
    final double avatarSize = getWidth(context) > 370 ? 64 : 54;

    return Shimmer.fromColors(
      baseColor: shimmerBase,
      highlightColor: shimmerHighlight,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Matches: const CustomSizedBox(height: 80)
          const SizedBox(height: 80),

          // Matches: Container(height: ..., decoration: BoxDecoration(...))
          Container(
            height: cardHeight,
            decoration: BoxDecoration(
              color: isDark
                  ? ColorPalette.black.withValues(alpha: 0.2)
                  : ColorPalette.textGrey,
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.2),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Column(
              children: [
                // Matches: _buildGroupImageWithAvatars → Stack
                Stack(
                  clipBehavior: Clip.none,
                  alignment: Alignment.center,
                  children: [
                    // Matches: inner Container(width: 392, height: ...)
                    Container(
                      width: 392,
                      height: imageHeight,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24),
                        color: backgroundColor,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.3),
                            blurRadius: 20,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(24),
                        child: Container(color: backgroundColor),
                      ),
                    ),

                    // Matches: Positioned(bottom: -30, right: 0, left: 70)
                    // Uses 4 dummy avatars (default branch in real widget)
                    Positioned(
                      bottom: -30,
                      right: 0,
                      left: 70,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          for (int i = 0; i < 4; i++)
                            Transform.translate(
                              offset: Offset(-12.0 * i, 0),
                              child: Container(
                                width: avatarSize,
                                height: avatarSize,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Colors.black,
                                    width: 2,
                                  ),
                                  color: backgroundColor,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withValues(
                                        alpha: 0.2,
                                      ),
                                      blurRadius: 8,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),

                // Matches: const CustomSizedBox(height: 54)
                const SizedBox(height: 54),

                // Matches: AppText memberNames — h1, fontSize 24, fontWeight 600
                // Single centered line, ~24px tall
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Container(
                    width: 220,
                    height: 24,
                    decoration: BoxDecoration(
                      color: backgroundColor,
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                ),

                // Matches: const CustomSizedBox(height: 16)
                const SizedBox(height: 16),

                // Matches: AppText group info — description style, centered
                // One full-width line + one shorter line
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Container(
                    width: double.infinity,
                    height: 14,
                    decoration: BoxDecoration(
                      color: backgroundColor,
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                ),
                const SizedBox(height: 6),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Container(
                    width: 180,
                    height: 14,
                    decoration: BoxDecoration(
                      color: backgroundColor,
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                ),

                // Matches: const CustomSizedBox(height: 16)
                const SizedBox(height: 16),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
