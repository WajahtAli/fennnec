import 'package:fennac_app/app/constants/media_query_constants.dart';
import 'package:fennac_app/app/theme/text_styles.dart';
import 'package:fennac_app/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class KycGalleryInstructions extends StatelessWidget {
  const KycGalleryInstructions({super.key});

  @override
  Widget build(BuildContext context) {
    return AppText(
      text:
          'Drag the photos to sort them. Your primary photo appears at the top and will be used as your profile picture.',
      style: AppTextStyles.bodyLarge(context).copyWith(
        color: isLightTheme(context)
            ? Colors.black.withValues(alpha: 0.7)
            : Colors.white.withValues(alpha: 0.7),
        fontSize: 12,
        height: 1.6,
      ),
    );
  }
}
