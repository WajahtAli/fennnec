import 'package:fennac_app/app/constants/media_query_constants.dart';
import 'package:flutter/material.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/text_styles.dart';
import '../../../../reusable_widgets/animated_background_container.dart';
import '../../../../widgets/custom_elevated_button.dart';

class EmptyWidget extends StatelessWidget {
  final double? height;
  final double? width;
  final EdgeInsetsGeometry? padding;

  final String? title;
  final String? description;
  final TextAlign textAlign;

  final String? imagePath;

  final bool showButton;
  final String? buttonText;
  final VoidCallback? onButtonTap;

  final BorderRadiusGeometry? borderRadius;
  final Color? backgroundColor;

  const EmptyWidget({
    super.key,
    this.height,
    this.width,
    this.padding,
    this.title,
    this.description,
    this.imagePath,
    this.showButton = false,
    this.buttonText,
    this.onButtonTap,
    this.borderRadius,
    this.backgroundColor,
    this.textAlign = TextAlign.center,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width ?? double.infinity,
      padding:
          padding ?? const EdgeInsets.symmetric(horizontal: 24, vertical: 28),
      decoration: BoxDecoration(
        borderRadius: borderRadius ?? BorderRadius.circular(24),
        color:
            backgroundColor ??
            (isLightTheme(context)
                ? ColorPalette.textGrey
                : ColorPalette.black.withValues(alpha: 0.1)),
        boxShadow: [
          BoxShadow(
            color: isLightTheme(context)
                ? ColorPalette.black.withValues(alpha: 0.1 / 5)
                : Colors.black.withValues(alpha: 0.5),
            spreadRadius: 3,
            blurRadius: 3,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (imagePath != null) AnimatedBackgroundContainer(icon: imagePath!),

          if (imagePath != null) const SizedBox(height: 24),

          if (title != null)
            Text(
              title!,
              textAlign: textAlign,
              style: AppTextStyles.h2(
                context,
              ).copyWith(fontWeight: FontWeight.w500),
            ),

          if (description != null) const SizedBox(height: 24),

          if (description != null)
            Text(
              description!,
              textAlign: textAlign,
              style: AppTextStyles.bodyLarge(context).copyWith(
                color: isLightTheme(context)
                    ? ColorPalette.black
                    : ColorPalette.textSecondary,
                fontWeight: FontWeight.w500,
              ),
            ),

          if (showButton) const SizedBox(height: 48),

          if (showButton)
            CustomElevatedButton(
              text: buttonText ?? 'Action',
              onTap: onButtonTap,
            ),
        ],
      ),
    );
  }
}
