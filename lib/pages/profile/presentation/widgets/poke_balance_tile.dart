import 'package:fennac_app/app/constants/media_query_constants.dart';
import 'package:fennac_app/app/theme/app_colors.dart';
import 'package:fennac_app/app/theme/app_emojis.dart';
import 'package:fennac_app/app/theme/text_styles.dart';
import 'package:fennac_app/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class PokeBalanceTile extends StatelessWidget {
  final int pokeCount;
  final VoidCallback onBuyMore;

  const PokeBalanceTile({
    super.key,
    required this.pokeCount,
    required this.onBuyMore,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 80,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: BoxDecoration(
        color: isLightTheme(context)
            ? ColorPalette.textGrey
            : ColorPalette.cardBlack.withValues(alpha: 0.25),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: ColorPalette.grey, width: 1),
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: ColorPalette.primary,
            ),
            child: Text(AppEmojis.writingHand, style: TextStyle(fontSize: 24)),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AppText(
                  text: '$pokeCount pokes left',
                  style: AppTextStyles.body(context),
                ),
                const SizedBox(height: 4),
                AppText(
                  text: 'Your Poke Balance',
                  style: AppTextStyles.description(context),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          GestureDetector(
            onTap: onBuyMore,
            child: Container(
              height: 28,
              width: 100,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: ColorPalette.primary,
                borderRadius: BorderRadius.circular(52),
              ),
              child: AppText(
                text: 'Buy More',
                style: AppTextStyles.chipLabel(
                  context,
                ).copyWith(fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
