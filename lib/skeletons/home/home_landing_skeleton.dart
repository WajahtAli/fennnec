import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:fennac_app/app/theme/app_colors.dart';

class HomeLandingSkeleton extends StatelessWidget {
  final double? verticalSpacing;
  const HomeLandingSkeleton({super.key, this.verticalSpacing});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final backgroundColor = isDark ? ColorPalette.cardBlack : Colors.white;
    final shimmerBase = isDark ? ColorPalette.cardBlack : HexColor("#F0F0F0");
    final shimmerHighlight = isDark ? HexColor("#333333") : HexColor("#E0E0E0");

    return Container(
      color: isDark ? ColorPalette.cardBlack : Colors.white,
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: 16,
          vertical: verticalSpacing ?? 0,
        ),
        child: Column(
          spacing: 32,
          children: [
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
