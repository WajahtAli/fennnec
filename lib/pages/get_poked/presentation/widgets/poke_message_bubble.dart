import 'package:fennac_app/app/constants/media_query_constants.dart';
import 'package:fennac_app/app/theme/app_colors.dart';
import 'package:fennac_app/app/theme/text_styles.dart';
import 'package:fennac_app/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class PokeMessageBubble extends StatelessWidget {
  final String? message;

  const PokeMessageBubble({super.key, this.message});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          alignment: Alignment.center,
          margin: const EdgeInsets.symmetric(horizontal: 10),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: isLightTheme(context)
                ? ColorPalette.textGrey
                : ColorPalette.secondary.withValues(alpha: 0.5),
            borderRadius: BorderRadius.circular(12),
          ),
          child: AppText(
            text: message ?? 'Poking because overthinking a\nmessage seemed harder 😂',
            style: AppTextStyles.bodyRegular(context).copyWith(
              color: isLightTheme(context)
                  ? ColorPalette.black
                  : ColorPalette.white,
              fontSize: 20,
              height: 1.4,
            ),
          ),
        ),
        // Quote Icon
        Positioned(
          top: 0,
          left: 0,
          child: Transform.rotate(
            angle: 0.2,
            child: Text(
              '"',
              style: AppTextStyles.h2(context).copyWith(
                color: ColorPalette.primary,
                fontSize: 100,
                height: 0.5,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
