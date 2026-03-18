import 'package:fennac_app/app/constants/media_query_constants.dart';
import 'package:fennac_app/app/theme/app_colors.dart';
import 'package:fennac_app/app/theme/text_styles.dart';
import 'package:fennac_app/generated/assets.gen.dart';
import 'package:fennac_app/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';

class PokePackTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final int pokes;
  final String price;
  final VoidCallback? onTap;
  final bool isPurchasing;

  const PokePackTile({
    super.key,
    required this.title,
    required this.subtitle,
    required this.pokes,
    required this.price,
    this.onTap,
    this.isPurchasing = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 92,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isLightTheme(context)
              ? ColorPalette.textGrey
              : Color(0x80111111),
          borderRadius: BorderRadius.circular(24),
        ),
        child: Row(
          children: [
            _buildPokeCount(context),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AppText(
                    text: title,
                    style: AppTextStyles.h4(
                      context,
                    ).copyWith(fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 6),
                  AppText(
                    text: subtitle,
                    style: AppTextStyles.description(context).copyWith(
                      color: isLightTheme(context)
                          ? ColorPalette.black
                          : ColorPalette.textSecondary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                AppText(
                  text: price,
                  style: AppTextStyles.h6(
                    context,
                  ).copyWith(fontWeight: FontWeight.w700),
                ),
                const SizedBox(width: 16),
                isPurchasing
                    ? SizedBox(
                        width: 20,
                        height: 20,
                        child: Lottie.asset(Assets.animations.loadingSpinner),
                      )
                    : SvgPicture.asset(
                        Assets.icons.arrowRight.path,
                        width: 16,
                        height: 16,
                        colorFilter: ColorFilter.mode(
                          isLightTheme(context)
                              ? ColorPalette.black
                              : ColorPalette.white,
                          BlendMode.srcIn,
                        ),
                      ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPokeCount(BuildContext context) {
    return Container(
      width: 60,
      height: 60,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: ColorPalette.primary,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AppText(
            text: '$pokes',
            style: AppTextStyles.h3(
              context,
            ).copyWith(fontWeight: FontWeight.w700, color: ColorPalette.white),
          ),
          const SizedBox(height: 4),
          AppText(
            text: 'Pokes',
            style: AppTextStyles.label(
              context,
            ).copyWith(fontWeight: FontWeight.w600, color: ColorPalette.white),
          ),
        ],
      ),
    );
  }
}
