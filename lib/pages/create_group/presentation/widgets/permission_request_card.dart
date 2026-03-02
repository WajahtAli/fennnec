import 'package:fennac_app/app/theme/app_colors.dart';
import 'package:fennac_app/app/theme/text_styles.dart';
import 'package:fennac_app/generated/assets.gen.dart';
import 'package:fennac_app/reusable_widgets/animated_background_container.dart';
import 'package:fennac_app/widgets/custom_elevated_button.dart';
import 'package:fennac_app/widgets/custom_outlined_button.dart';
import 'package:flutter/material.dart';

import '../../../../app/constants/media_query_constants.dart';

class PermissionRequestCard extends StatelessWidget {
  final VoidCallback onAllow;
  final VoidCallback onDeny;

  const PermissionRequestCard({
    super.key,
    required this.onAllow,
    required this.onDeny,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 346,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 28),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color: isLightTheme(context)
            ? ColorPalette.textGrey
            : ColorPalette.black.withValues(alpha: 0.1),
        boxShadow: [
          BoxShadow(
            color: ColorPalette.black.withValues(alpha: 0.1),
            blurRadius: 3,
            spreadRadius: 3,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AnimatedBackgroundContainer(icon: Assets.icons.union.path),
          const SizedBox(height: 24),
          Text(
            'Allow access to contacts so you can easily find your friends.',
            textAlign: TextAlign.center,
            style: AppTextStyles.h3(context),
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                child: CustomElevatedButton(
                  text: 'Allow Access',
                  onTap: onAllow,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: CustomOutlinedButton(
                  text: 'Not Now',
                  onPressed: onDeny,
                  borderColor: isLightTheme(context)
                      ? null
                      : Colors.white.withValues(alpha: 0.7),
                  textColor: isLightTheme(context) ? null : Colors.white,
                  height: 52,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
