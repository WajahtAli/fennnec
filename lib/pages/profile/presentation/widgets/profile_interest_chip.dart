import 'package:fennac_app/app/constants/media_query_constants.dart';
import 'package:fennac_app/app/theme/app_colors.dart';
import 'package:fennac_app/app/theme/text_styles.dart';
import 'package:fennac_app/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class ProfileInterestChip extends StatelessWidget {
  final String emoji;
  final String label;
  final bool isEmojiFirst;

  const ProfileInterestChip({
    super.key,
    required this.emoji,
    required this.label,
    this.isEmojiFirst = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: isLightTheme(context)
            ? Colors.transparent
            : ColorPalette.secondary,
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: ColorPalette.primary, width: 1),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (isEmojiFirst && emoji.isNotEmpty) ...[
            Text(emoji, style: AppTextStyles.chipLabel(context)),
            const SizedBox(width: 6),
          ],
          if (label.isNotEmpty) ...[
            AppText(
              text: label,
              style: AppTextStyles.chipLabel(context).copyWith(
                color: isLightTheme(context) ? Colors.black : Colors.white,
              ),
            ),
          ],
          if (!isEmojiFirst && emoji.isNotEmpty) ...[
            const SizedBox(width: 6),
            Text(emoji, style: AppTextStyles.chipLabel(context)),
          ],
        ],
      ),
    );
  }
}
