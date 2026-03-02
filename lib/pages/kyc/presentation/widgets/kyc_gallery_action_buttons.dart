import 'package:fennac_app/generated/assets.gen.dart';
import 'package:fennac_app/pages/kyc/presentation/widgets/continue_button.dart';
import 'package:fennac_app/widgets/custom_outlined_button.dart';
import 'package:fennac_app/widgets/custom_sized_box.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class KycGalleryActionButtons extends StatelessWidget {
  final bool isEditMode;
  final bool isLoading;
  final VoidCallback onSkip;
  final VoidCallback onContinue;

  const KycGalleryActionButtons({
    super.key,
    required this.isEditMode,
    required this.isLoading,
    required this.onSkip,
    required this.onContinue,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        children: [
          if (!isEditMode) ...[
            Expanded(
              child: CustomOutlinedButton(
                onPressed: onSkip,
                text: 'Skip',
                width: double.infinity,
              ),
            ),
            const CustomSizedBox(width: 16),
          ],
          Expanded(
            child: ContinueButton(
              isLoading: isLoading,
              loadingIcon: SizedBox(
                width: 20,
                height: 20,
                child: Lottie.asset(
                  Assets.animations.loadingSpinner,
                  fit: BoxFit.cover,
                ),
              ),
              onTap: onContinue,
              text: isEditMode ? 'Done' : 'Continue',
            ),
          ),
        ],
      ),
    );
  }
}
