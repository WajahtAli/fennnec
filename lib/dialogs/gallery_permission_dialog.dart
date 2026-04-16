// ─── Two-action dialog (cancel + confirm) ─────────────────────────────────

import 'package:fennac_app/app/constants/media_query_constants.dart';
import 'package:fennac_app/app/theme/app_colors.dart';
import 'package:fennac_app/app/theme/text_styles.dart';
import 'package:fennac_app/generated/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:permission_handler/permission_handler.dart';

void showAppConfirmDialog({
  required BuildContext context,
  required String title,
  required String description,
  required String confirmLabel,
  required VoidCallback onConfirm,
  String cancelLabel = 'Cancel',
  VoidCallback? onCancel,
  bool barrierDismissible = false,
  IconData? icon,
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
            // Optional icon
            if (icon != null) ...[
              SvgPicture.asset(
                Assets.icons.gallery.path,
                color: ColorPalette.primary,
                width: 28,
                height: 28,
              ),
              const SizedBox(height: 16),
            ],

            // Title
            Text(
              title,
              style: AppTextStyles.h3(context).copyWith(
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

            // Buttons row
            Row(
              children: [
                // Cancel
                Expanded(
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      side: BorderSide(
                        color: isLight
                            ? Colors.black.withValues(alpha: 0.15)
                            : Colors.white.withValues(alpha: 0.2),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () {
                      Navigator.pop(dialogContext);
                      onCancel?.call();
                    },
                    child: Text(
                      cancelLabel,
                      style: AppTextStyles.body(context).copyWith(
                        color: isLight
                            ? ColorPalette.black
                            : Colors.white.withValues(alpha: 0.8),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),

                const SizedBox(width: 12),

                // Confirm
                Expanded(
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
                      onConfirm();
                    },
                    child: Text(
                      confirmLabel,
                      style: AppTextStyles.body(context).copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}

// ─── Pre-configured shortcut ───────────────────────────────────────────────

void showGalleryPermissionDialog(BuildContext context) {
  showAppConfirmDialog(
    context: context,
    title: 'Gallery Permission',
    description: 'Enable gallery permission in Settings to select photos.',
    confirmLabel: 'Settings',
    icon: Icons.photo_library_outlined,
    onConfirm: () => openAppSettings(),
  );
}
