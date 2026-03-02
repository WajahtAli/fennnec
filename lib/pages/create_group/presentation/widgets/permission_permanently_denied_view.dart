import 'package:fennac_app/app/theme/text_styles.dart';
import 'package:fennac_app/widgets/custom_elevated_button.dart';
import 'package:fennac_app/widgets/custom_outlined_button.dart';
import 'package:flutter/material.dart';

class PermissionPermanentlyDeniedView extends StatelessWidget {
  final VoidCallback onOpenSettings;
  final VoidCallback onRetry;

  const PermissionPermanentlyDeniedView({
    super.key,
    required this.onOpenSettings,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: 24),
        Text(
          'Unable to access your contacts',
          textAlign: TextAlign.center,
          style: AppTextStyles.h2(context),
        ),
        const SizedBox(height: 16),
        Text(
          'Contacts permission is blocked. Please enable contacts access in Settings.',
          textAlign: TextAlign.center,
          style: AppTextStyles.body(context),
        ),
        const SizedBox(height: 16),
        Text(
          "We'll only use your contacts to show who's already on Fennec.",
          textAlign: TextAlign.center,
          style: AppTextStyles.bodySmall(context),
        ),
        const SizedBox(height: 24),
        Row(
          children: [
            Expanded(
              child: CustomElevatedButton(
                text: 'Open Settings',
                onTap: onOpenSettings,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: CustomOutlinedButton(
                text: 'Retry',
                onPressed: onRetry,
                borderColor: Colors.white.withValues(alpha: 0.7),
                textColor: Colors.white,
                height: 52,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
