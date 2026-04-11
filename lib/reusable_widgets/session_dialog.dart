import 'package:auto_route/auto_route.dart';
import 'package:fennac_app/helpers/shared_pref_helper.dart';
import 'package:fennac_app/routes/routes_imports.gr.dart';
import 'package:flutter/material.dart';

import '../app/constants/media_query_constants.dart';
import '../app/theme/app_colors.dart';
import '../app/theme/text_styles.dart';
import '../core/di_container.dart';

void showAppDialog({
  required BuildContext context,
  required String title,
  required String description,
  required String buttonLabel,
  required VoidCallback onTap,
  bool barrierDismissible = false,
  IconData? icon,
  VoidCallback? onDialogClosed,
}) {
  final isLight = isLightTheme(context);

  showDialog(
    context: context,
    barrierDismissible: barrierDismissible,
    builder: (BuildContext dialogContext) => Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.symmetric(horizontal: 24),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
        decoration: BoxDecoration(
          gradient: isDarkTheme(context)
              ? LinearGradient(
                  colors: [ColorPalette.secondary, ColorPalette.black],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                )
              : null,
          color: isLight ? Colors.white : null,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Handle bar
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: isLight
                    ? Colors.black.withValues(alpha: 0.2)
                    : Colors.white.withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 24),

            // Optional icon
            if (icon != null) ...[
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: ColorPalette.primary.withValues(alpha: 0.12),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: ColorPalette.primary, size: 28),
              ),
              const SizedBox(height: 16),
            ],

            // Title
            Text(
              title,
              style: AppTextStyles.h2(context).copyWith(
                fontWeight: FontWeight.w600,
                color: isLight ? Colors.black : Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),

            // Description
            Text(
              description,
              textAlign: TextAlign.center,
              style: AppTextStyles.subHeading(context).copyWith(
                color: isLight
                    ? ColorPalette.black
                    : ColorPalette.textPrimary.withValues(alpha: 0.8),
              ),
            ),
            const SizedBox(height: 32),

            // Action button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorPalette.primary,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  Navigator.pop(dialogContext);
                  onTap();
                },
                child: Text(
                  buttonLabel,
                  style: AppTextStyles.body(
                    context,
                  ).copyWith(color: Colors.white, fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  ).then((_) {
    onDialogClosed?.call();
  });
}

void showSessionExpiredDialog(BuildContext context) {
  showAppDialog(
    context: context,
    title: 'Session Expired',
    description: 'Your session has expired. Please login again to continue.',
    buttonLabel: 'Login Again',
    icon: Icons.lock_clock_outlined,
    onTap: () {
      sharedPreferencesHelper.clearUserData();
      sharedPreferencesHelper.clearAuthToken();
      if (context.mounted) {
        AutoRouter.of(context).replaceAll([const OnBoardingRoute()]);
      }
    },
  );
}

void showAccountDeactivatedDialog(
  BuildContext context, {
  VoidCallback? onDialogClosed,
}) {
  showAppDialog(
    context: context,
    title: 'Account Deactivated',
    description:
        'Your account has been deactivated. Please contact support for help.',
    buttonLabel: 'OK',
    icon: Icons.block_outlined,
    onDialogClosed: onDialogClosed,
    onTap: () {
      sharedPreferencesHelper.clearUserData();
      sharedPreferencesHelper.clearAuthToken();
      if (context.mounted) {
        AutoRouter.of(context).replaceAll([const OnBoardingRoute()]);
      }
    },
  );
}

final SharedPreferencesHelper sharedPreferencesHelper = Di()
    .sl<SharedPreferencesHelper>();
