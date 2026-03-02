import 'package:fennac_app/app/constants/media_query_constants.dart';
import 'package:fennac_app/app/constants/dummy_constants.dart';
import 'package:fennac_app/app/theme/text_styles.dart';
import 'package:fennac_app/pages/kyc/presentation/widgets/prompt_card.dart';
import 'package:fennac_app/widgets/custom_sized_box.dart';
import 'package:fennac_app/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class PredefinedPromptsList extends StatelessWidget {
  final ValueChanged<bool> setBackgroundBlurred;
  final bool isEditMode;
  const PredefinedPromptsList({
    super.key,
    required this.setBackgroundBlurred,
    required this.isEditMode,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomSizedBox(height: 24),
        // Separator
        Center(
          child: AppText(
            text: 'Or use one of ours..',
            textAlign: TextAlign.center,
            style: AppTextStyles.bodyRegular(context).copyWith(
              color: isLightTheme(context) ? Colors.black : Colors.white54,
              fontSize: 14,
            ),
          ),
        ),
        CustomSizedBox(height: 16),
        // Predefined Prompts
        ...DummyConstants.predefinedPrompts.map((prompt) {
          return PromptCard(
            prompt: prompt,
            isPredefined: true,
            isEditMode: isEditMode,
            setBackgroundBlurred: setBackgroundBlurred,
          );
        }),
        CustomSizedBox(height: 100),
      ],
    );
  }
}
