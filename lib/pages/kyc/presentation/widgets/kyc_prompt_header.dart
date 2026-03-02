import 'package:fennac_app/app/constants/media_query_constants.dart';
import 'package:fennac_app/app/theme/text_styles.dart';
import 'package:fennac_app/reusable_widgets/custom_app_bar.dart';
import 'package:fennac_app/widgets/custom_back_button.dart';
import 'package:fennac_app/widgets/custom_sized_box.dart';
import 'package:fennac_app/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class KycPromptHeader extends StatelessWidget {
  final bool showSkipButton;
  final bool isEditMode;
  final String? title;
  final String? subtitle;

  const KycPromptHeader({
    super.key,
    required this.showSkipButton,
    this.isEditMode = false,
    this.title,
    this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomSizedBox(height: 20),
        if (showSkipButton == false)
          CustomAppBar(
            title:
                title ?? (isEditMode ? 'Edit Group Details' : 'Create a Group'),
          )
        else
          const CustomBackButton(),
        CustomSizedBox(height: 32),
        // Title
        if (showSkipButton) ...[
          AppText(
            text: title ?? 'Pick a few prompts and show off your personality.',
            style: AppTextStyles.h3(context).copyWith(
              color: isLightTheme(context) ? Colors.black : Colors.white,
              fontWeight: FontWeight.w500,
            ),
          ),
          CustomSizedBox(height: 12),
          AppText(
            text:
                subtitle ??
                'Answer honestly, creatively, or with humor — these are your ice-breakers. You can answer up to 4 prompts.',
            style: AppTextStyles.bodyLarge(context).copyWith(
              color: isLightTheme(context)
                  ? Colors.black.withValues(alpha: 0.7)
                  : Colors.white70,
              fontSize: 14,
              height: 1.5,
            ),
          ),
          CustomSizedBox(height: 32),
        ],
      ],
    );
  }
}
