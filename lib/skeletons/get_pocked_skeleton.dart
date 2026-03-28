import 'package:fennac_app/app/theme/app_colors.dart';
import 'package:fennac_app/widgets/custom_sized_box.dart';
import 'package:fennac_app/widgets/movable_background.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class GetPockedSkeleton extends StatelessWidget {
  const GetPockedSkeleton({super.key});

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
        : ColorPalette.lightDivider;

    return Scaffold(
      backgroundColor: ColorPalette.black,
      body: MovableBackground(
        backgroundType: MovableBackgroundType.medium,
        child: Column(
          children: [
            const CustomSizedBox(height: 40),
            // Back button area
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: backgroundColor.withValues(alpha: 0.2),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const CustomSizedBox(height: 20),
                    // PokeImageCard Skeleton
                    Shimmer.fromColors(
                      baseColor: shimmerBase,
                      highlightColor: shimmerHighlight,
                      child: Transform.rotate(
                        angle: -0.1,
                        child: Container(
                          height: 250,
                          width: 240,
                          decoration: BoxDecoration(
                            color: backgroundColor,
                            borderRadius: BorderRadius.circular(40),
                          ),
                        ),
                      ),
                    ),
                    const CustomSizedBox(height: 40),
                    // PokeMessageBubble Skeleton
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Shimmer.fromColors(
                        baseColor: shimmerBase,
                        highlightColor: shimmerHighlight,
                        child: Container(
                          width: double.infinity,
                          height: 80,
                          decoration: BoxDecoration(
                            color: backgroundColor,
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // PokeNotificationCard Skeleton
            Container(
              padding: const EdgeInsets.only(left: 20, right: 20, bottom: 30),
              decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(32),
                  topRight: Radius.circular(32),
                ),
              ),
              child: Shimmer.fromColors(
                baseColor: shimmerBase,
                highlightColor: shimmerHighlight,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const CustomSizedBox(height: 24),
                    Container(
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(
                        color: backgroundColor,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const CustomSizedBox(height: 24),
                    Container(
                      width: 150,
                      height: 24,
                      decoration: BoxDecoration(
                        color: backgroundColor,
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    const CustomSizedBox(height: 24),
                    Container(
                      width: double.infinity,
                      height: 40,
                      decoration: BoxDecoration(
                        color: backgroundColor,
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    const CustomSizedBox(height: 24),
                    Container(
                      width: double.infinity,
                      height: 50,
                      decoration: BoxDecoration(
                        color: backgroundColor,
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
