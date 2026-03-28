import 'package:fennac_app/app/constants/media_query_constants.dart';
import 'package:fennac_app/app/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class NotificationItemSkeleton extends StatelessWidget {
  final int itemCount;
  final bool showDivider;

  const NotificationItemSkeleton({
    super.key,
    this.itemCount = 4,
    this.showDivider = true,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final rowColor = isDark ? ColorPalette.cardBlack : Colors.white;
    final shimmerBase = isDark
        ? ColorPalette.cardBlack
        : const Color(0xFFF0F0F0);
    final shimmerHighlight = isDark
        ? const Color(0xFF333333)
        : ColorPalette.lightDivider;

    return Shimmer.fromColors(
      baseColor: shimmerBase,
      highlightColor: shimmerHighlight,
      child: ListView.builder(
        itemCount: itemCount,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: getWidth(context) * 0.38,
                            height: 16,
                            decoration: BoxDecoration(
                              color: rowColor,
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Container(
                            width: getWidth(context) * 0.58,
                            height: 12,
                            decoration: BoxDecoration(
                              color: rowColor,
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 16),
                    Container(
                      width: 46,
                      height: 28,
                      decoration: BoxDecoration(
                        color: rowColor,
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ],
                ),
              ),
              if (showDivider)
                Divider(
                  color: ColorPalette.border.withValues(alpha: 0.3),
                  thickness: 1,
                ),
            ],
          );
        },
      ),
    );
  }
}
