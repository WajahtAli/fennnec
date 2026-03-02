import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:fennac_app/app/theme/app_colors.dart';

class HomeLandingSkeleton extends StatelessWidget {
  const HomeLandingSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final backgroundColor = isDark
        ? ColorPalette.cardBlack
        : ColorPalette.white;
    final shimmerBase = isDark ? ColorPalette.cardBlack : HexColor("#F0F0F0");
    final shimmerHighlight = isDark ? HexColor("#333333") : HexColor("#E0E0E0");

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        spacing: 32,
        children: [
          // 1. HomeCardDesign Skeleton (408x315)
          Shimmer.fromColors(
            baseColor: shimmerBase,
            highlightColor: shimmerHighlight,
            child: Container(
              width: 408,
              height: 315,
              decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(
                  color: isDark
                      ? ColorPalette.border.withValues(alpha: 0.2)
                      : ColorPalette.border.withValues(alpha: 0.1),
                  width: 1,
                ),
              ),
            ),
          ),
          // const SizedBox(height: 32),

          // 2. Title Text Skeleton (200x29, centered)
          Center(
            child: Shimmer.fromColors(
              baseColor: shimmerBase,
              highlightColor: shimmerHighlight,
              child: Container(
                width: 200,
                height: 29,
                decoration: BoxDecoration(
                  color: backgroundColor,
                  borderRadius: BorderRadius.circular(24),
                ),
              ),
            ),
          ),
          // const SizedBox(height: 12),

          // 3. Description and Category Pill Skeleton (408x46, gap 2px)
          Column(
            spacing: 2,
            children: [
              Shimmer.fromColors(
                baseColor: shimmerBase,
                highlightColor: shimmerHighlight,
                child: Container(
                  width: 408,
                  height: 22,
                  decoration: BoxDecoration(
                    color: backgroundColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              Shimmer.fromColors(
                baseColor: shimmerBase,
                highlightColor: shimmerHighlight,
                child: Container(
                  width: 380,
                  height: 22,
                  decoration: BoxDecoration(
                    color: backgroundColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Category Pill Skeleton
          Shimmer.fromColors(
            baseColor: shimmerBase,
            highlightColor: shimmerHighlight,
            child: Container(
              width: 120,
              height: 28,
              decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: BorderRadius.circular(14),
              ),
            ),
          ),
          const SizedBox(height: 80),
        ],
      ),
    );
  }
}

extension HexColorExtension on String {
  Color toColor() {
    return HexColor(this);
  }
}

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF$hexColor";
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}
