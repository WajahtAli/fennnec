import 'package:fennac_app/pages/kyc/presentation/bloc/cubit/kyc_prompt_cubit.dart';
import 'package:fennac_app/pages/kyc/presentation/widgets/prompt_card.dart';
import 'package:fennac_app/widgets/custom_sized_box.dart';
import 'package:flutter/material.dart';

class CustomPromptsList extends StatelessWidget {
  final KycPromptCubit kycPromptCubit;
  final bool isEditMode;
  final ValueChanged<bool> setBackgroundBlurred;

  const CustomPromptsList({
    super.key,
    required this.kycPromptCubit,
    required this.isEditMode,
    required this.setBackgroundBlurred,
  });

  @override
  Widget build(BuildContext context) {
    if (kycPromptCubit.selectedPrompts.isEmpty) {
      return const SizedBox.shrink();
    }
    return Column(
      children: [
        ...kycPromptCubit.selectedPrompts.map((prompt) {
          return PromptCard(
            prompt: prompt.promptText ?? "",
            isEditMode: isEditMode,
            isPredefined: false,
            setBackgroundBlurred: setBackgroundBlurred,
          );
        }),
        CustomSizedBox(height: 24),
      ],
    );
  }
}
