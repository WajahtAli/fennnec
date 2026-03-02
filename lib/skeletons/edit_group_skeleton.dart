import 'package:fennac_app/app/theme/app_colors.dart';
import 'package:fennac_app/skeletons/group_card_skeleton.dart';
import 'package:fennac_app/widgets/custom_sized_box.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class EditGroupSkeleton extends StatelessWidget {
  const EditGroupSkeleton({super.key});

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

    Widget buildShimmerBox({
      required double height,
      required double borderRadius,
    }) {
      return Shimmer.fromColors(
        baseColor: shimmerBase,
        highlightColor: shimmerHighlight,
        child: Container(
          width: double.infinity,
          height: height,
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(borderRadius),
            border: Border.all(
              color: isDark
                  ? ColorPalette.border.withValues(alpha: 0.2)
                  : ColorPalette.border.withValues(alpha: 0.1),
              width: 1,
            ),
          ),
        ),
      );
    }

    return Column(
      children: [
        // Avatar Section
        buildShimmerBox(height: 250, borderRadius: 24),
        const CustomSizedBox(height: 24),

        // Group Card
        const GroupCardSkeleton(),
        const CustomSizedBox(height: 24),

        // Photos Grid (placeholder)
        buildShimmerBox(height: 200, borderRadius: 16),
        const CustomSizedBox(height: 24),

        // Prompts Section
        buildShimmerBox(height: 120, borderRadius: 28),
        const CustomSizedBox(height: 24),

        // Settings Section
        buildShimmerBox(height: 200, borderRadius: 16),
        const CustomSizedBox(height: 32),
      ],
    );
  }
}
