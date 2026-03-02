import 'package:fennac_app/app/theme/text_styles.dart';
import 'package:flutter/material.dart';

class PermissionDeniedView extends StatelessWidget {
  const PermissionDeniedView({super.key});

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
          "Grant access to make it easier to invite your friends from your contact list.",
          textAlign: TextAlign.center,
          style: AppTextStyles.body(context),
        ),
        const SizedBox(height: 16),
        Text(
          "We'll only use your contacts to show who's already on Fennec.",
          textAlign: TextAlign.center,
          style: AppTextStyles.bodySmall(context),
        ),
      ],
    );
  }
}
