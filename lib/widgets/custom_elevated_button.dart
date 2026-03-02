import 'package:fennac_app/app/constants/media_query_constants.dart';
import 'package:fennac_app/widgets/custom_sized_box.dart';
import 'package:fennac_app/widgets/custom_text.dart';
import 'package:flutter/material.dart';

import '../app/theme/app_colors.dart';
import '../app/theme/text_styles.dart';

class CustomElevatedButton extends StatelessWidget {
  final Function()? onTap;
  final String text;
  final Widget? icon;
  final double? width;
  final Color? backgroundColor;
  final bool isLoading;

  const CustomElevatedButton({
    super.key,
    this.onTap,
    required this.text,
    this.icon,
    this.width,
    this.backgroundColor,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(52),
        boxShadow: [
          isLightTheme(context)
              ? BoxShadow(
                  color: ColorPalette.primary.withValues(alpha: 0.25),
                  offset: const Offset(0, 8),
                  blurRadius: 12,
                  spreadRadius: 0,
                )
              : BoxShadow(),
          isLightTheme(context)
              ? BoxShadow(
                  color: ColorPalette.primary.withValues(alpha: 0.25),
                  offset: const Offset(0, -8),
                  blurRadius: 12,
                  spreadRadius: 0,
                )
              : BoxShadow(),
        ],
      ),
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor ?? ColorPalette.primary,
          foregroundColor: backgroundColor ?? ColorPalette.primary,
          elevation: 0,
          shadowColor: Colors.transparent,
          textStyle: AppTextStyles.button(
            context,
          ).copyWith(fontWeight: FontWeight.bold),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(52),
          ),
          minimumSize: const Size.fromHeight(52),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: isLoading
              ? [icon ?? const SizedBox()]
              : [
                  AppText(
                    text: text,
                    style: AppTextStyles.button(context).copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const CustomSizedBox(width: 10),
                  icon ?? const SizedBox(),
                ],
        ),
      ),
    );
  }
}
