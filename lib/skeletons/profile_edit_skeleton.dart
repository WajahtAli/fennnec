import 'package:fennac_app/app/theme/app_colors.dart';
import 'package:fennac_app/widgets/custom_sized_box.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ProfileEditSkeleton extends StatelessWidget {
  const ProfileEditSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final backgroundColor = isDark
        ? ColorPalette.cardBlack
        : ColorPalette.white;
    final shimmerBase = isDark
        ? ColorPalette.cardBlack
        : const Color(0xFFF0F0F0);
    final shimmerHighlight = isDark
        ? const Color(0xFF333333)
        : const Color(0xFFE0E0E0);

    return Column(
      children: [
        // Profile Avatar Skeleton (128x128 circle)
        Shimmer.fromColors(
          baseColor: shimmerBase,
          highlightColor: shimmerHighlight,
          child: Container(
            width: 128,
            height: 128,
            decoration: BoxDecoration(
              color: backgroundColor,
              shape: BoxShape.circle,
            ),
          ),
        ),
        const CustomSizedBox(height: 24),

        // Profile Header Card Skeleton
        Shimmer.fromColors(
          baseColor: shimmerBase,
          highlightColor: shimmerHighlight,
          child: Container(
            width: double.infinity,
            height: 200,
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: isDark
                    ? ColorPalette.border.withValues(alpha: 0.2)
                    : ColorPalette.border.withValues(alpha: 0.1),
                width: 1,
              ),
            ),
          ),
        ),
        const CustomSizedBox(height: 16),

        // Gallery Widget Skeleton
        Shimmer.fromColors(
          baseColor: shimmerBase,
          highlightColor: shimmerHighlight,
          child: Container(
            width: double.infinity,
            height: 300,
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: isDark
                    ? ColorPalette.border.withValues(alpha: 0.2)
                    : ColorPalette.border.withValues(alpha: 0.1),
                width: 1,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
