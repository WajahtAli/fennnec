import 'package:auto_route/auto_route.dart';
import 'package:fennac_app/app/constants/media_query_constants.dart';
import 'package:flutter/material.dart';
import '../app/theme/app_colors.dart';
import '../app/theme/text_styles.dart';
import 'custom_elevated_button.dart';
import 'custom_outlined_button.dart';
import 'custom_sized_box.dart';
import 'custom_text.dart';

class CustomBottomSheet extends StatelessWidget {
  final String title;
  final String? description;
  final TextStyle? descriptionStyle;
  final String? description1;
  final TextStyle? description1Style;
  final String buttonText;
  final VoidCallback? onButtonPressed;
  final Widget? icon;
  final String? secondaryButtonText;
  final VoidCallback? onSecondaryButtonPressed;
  final bool isHorizontalButton;
  final bool isSecondaryButtonFirst;

  const CustomBottomSheet({
    super.key,
    required this.title,
    this.description,
    this.descriptionStyle,
    this.description1,
    this.description1Style,
    required this.buttonText,
    this.onButtonPressed,
    this.icon,
    this.secondaryButtonText,
    this.onSecondaryButtonPressed,
    this.isHorizontalButton = false,
    this.isSecondaryButtonFirst = false,
  });

  static Future<void> show({
    required BuildContext context,
    required String title,
    String? description,
    TextStyle? descriptionStyle,
    String? description1,
    TextStyle? description1Style,
    required String buttonText,
    VoidCallback? onButtonPressed,
    Widget? icon,
    Color? barrierColor,
    String? secondaryButtonText,
    VoidCallback? onSecondaryButtonPressed,
    ValueNotifier<bool>? blurNotifier,
    bool? dismissible = true,
    bool isHorizontalButton = false,
    bool isSecondaryButtonFirst = false,
  }) async {
    final bool canDismiss = dismissible ?? true;
    blurNotifier?.value = true;
    try {
      await showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        barrierColor: barrierColor,
        isDismissible: canDismiss,
        enableDrag: canDismiss,
        isScrollControlled: true,
        builder: (context) => PopScope(
          canPop: canDismiss,
          child: CustomBottomSheet(
            title: title,
            description: description,
            description1: description1,
            buttonText: buttonText,
            onButtonPressed: () {
              if (onButtonPressed != null) {
                onButtonPressed();
              }
              Navigator.of(context).maybePop();
            },
            icon: icon,
            secondaryButtonText: secondaryButtonText,
            onSecondaryButtonPressed: onSecondaryButtonPressed,
            isHorizontalButton: isHorizontalButton,
            descriptionStyle: descriptionStyle,
            description1Style: description1Style,
            isSecondaryButtonFirst: isSecondaryButtonFirst,
          ),
        ),
      );
    } finally {
      blurNotifier?.value = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
      decoration: BoxDecoration(
        gradient: isDarkTheme(context)
            ? LinearGradient(
                colors: [ColorPalette.secondary, ColorPalette.black],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              )
            : null,
        color: isDarkTheme(context) ? null : Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(32),
          topRight: Radius.circular(32),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[icon!, const CustomSizedBox(height: 24)],
          AppText(
            text: title,
            style: AppTextStyles.h2(
              context,
            ).copyWith(fontWeight: FontWeight.w600),
            textAlign: TextAlign.center,
          ),
          if (description != null) ...[
            const CustomSizedBox(height: 16),
            AppText(
              text: description ?? '',
              style:
                  descriptionStyle ??
                  AppTextStyles.subHeading(context).copyWith(
                    color: isLightTheme(context)
                        ? ColorPalette.black
                        : ColorPalette.textPrimary.withValues(alpha: 0.8),
                  ),
              textAlign: TextAlign.center,
            ),
          ],

          if (description1 != null) ...[
            const CustomSizedBox(height: 8),
            AppText(
              text: description1!,
              style:
                  description1Style ??
                  AppTextStyles.body(
                    context,
                  ).copyWith(color: ColorPalette.error),
              textAlign: TextAlign.center,
            ),
          ],
          const CustomSizedBox(height: 32),
          if (isHorizontalButton && secondaryButtonText != null) ...[
            Row(
              children: [
                if (isSecondaryButtonFirst) ...[
                  Expanded(
                    child: CustomOutlinedButton(
                      text: secondaryButtonText!,
                      onPressed:
                          onSecondaryButtonPressed ??
                          () {
                            AutoRouter.of(context).pop();
                          },
                      width: double.infinity,
                    ),
                  ),
                  const CustomSizedBox(width: 16),
                  Expanded(
                    child: CustomElevatedButton(
                      text: buttonText,
                      onTap: onButtonPressed,
                      backgroundColor: description1 != null
                          ? ColorPalette.error
                          : ColorPalette.primary,
                    ),
                  ),
                ] else ...[
                  Expanded(
                    child: CustomElevatedButton(
                      text: buttonText,
                      onTap: onButtonPressed,
                      backgroundColor: description1 != null
                          ? ColorPalette.error
                          : ColorPalette.primary,
                    ),
                  ),
                  const CustomSizedBox(width: 16),
                  Expanded(
                    child: CustomOutlinedButton(
                      text: secondaryButtonText!,
                      onPressed:
                          onSecondaryButtonPressed ??
                          () {
                            AutoRouter.of(context).pop();
                          },
                      width: double.infinity,
                    ),
                  ),
                ],
              ],
            ),
            const CustomSizedBox(height: 32),
          ] else ...[
            CustomElevatedButton(text: buttonText, onTap: onButtonPressed),
            if (secondaryButtonText != null) ...[
              const CustomSizedBox(height: 32),
              CustomOutlinedButton(
                text: secondaryButtonText!,

                onPressed:
                    onSecondaryButtonPressed ??
                    () {
                      AutoRouter.of(context).pop();
                    },
                width: double.infinity,
              ),
              const CustomSizedBox(height: 40),
            ],
          ],
          const CustomSizedBox(height: 16),
        ],
      ),
    );
  }
}
