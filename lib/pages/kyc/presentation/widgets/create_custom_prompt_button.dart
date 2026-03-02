import 'package:fennac_app/app/constants/media_query_constants.dart';
import 'package:fennac_app/app/theme/app_colors.dart';
import 'package:fennac_app/app/theme/text_styles.dart';
import 'package:fennac_app/pages/kyc/presentation/bloc/cubit/kyc_prompt_cubit.dart';
import 'package:fennac_app/pages/kyc/presentation/widgets/create_prompt_bottom_sheet.dart';
import 'package:fennac_app/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class CreateCustomPromptButton extends StatelessWidget {
  final KycPromptCubit kycPromptCubit;
  final bool isEditMode;
  final ValueNotifier<bool> backgroundBlurNotifier;
  final VoidCallback onMaxPromptsReached;

  const CreateCustomPromptButton({
    super.key,
    required this.kycPromptCubit,
    required this.isEditMode,
    required this.backgroundBlurNotifier,
    required this.onMaxPromptsReached,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: isLightTheme(context)
            ? ColorPalette.textGrey
            : ColorPalette.primary.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () async {
            if (kycPromptCubit.isMaxReached()) {
              onMaxPromptsReached();
              return;
            }
            backgroundBlurNotifier.value = true;
            String id = DateTime.now().millisecondsSinceEpoch.toString();
            AudioPromptData tempPromptData = AudioPromptData(
              id: id,
              oldId: id,
              promptText: '',
              isCustom: true,
            );
            kycPromptCubit.addPrompt(tempPromptData);
            await CreatePromptBottomSheet.show(
              context,
              isEditMode: isEditMode,
              promptData: tempPromptData,
            );
            backgroundBlurNotifier.value = false;
          },
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppText(
                  text: 'Create Custom Prompt',
                  style: AppTextStyles.bodyLarge(context).copyWith(
                    color: isLightTheme(context) ? Colors.black : Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  color: isLightTheme(context) ? Colors.black : Colors.white,
                  size: 16,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
