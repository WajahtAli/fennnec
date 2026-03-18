import 'package:fennac_app/app/constants/media_query_constants.dart';
import 'package:fennac_app/app/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:fennac_app/widgets/app_inkwell.dart';

class CustomBackButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final Color? backgroundColor;
  final Color? iconColor;
  final IconData? icon;
  final double? size;
  final Alignment? alignment;
  final EdgeInsetsGeometry? padding;
  final double? height;
  final double? width;

  const CustomBackButton({
    super.key,
    this.onPressed,
    this.backgroundColor,
    this.iconColor,
    this.icon,
    this.size,
    this.alignment,
    this.padding,
    this.height,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment ?? Alignment.centerLeft,
      child: Container(
        height: height ?? 48,
        width: width ?? 48,
        decoration: BoxDecoration(
          color:
              backgroundColor ??
              (isLightTheme(context)
                  ? Colors.transparent
                  : ColorPalette.black.withOpacity(0.75)),
          shape: BoxShape.circle,
        ),
        child: AppInkWell(
          borderRadius: BorderRadius.circular(32),
          onTap: onPressed ?? () => Navigator.pop(context),
          child: Icon(
            icon ?? Icons.arrow_back,
            color:
                iconColor ??
                (isLightTheme(context)
                    ? ColorPalette.black
                    : ColorPalette.white),
            size: size ?? 20,
          ),
        ),
      ),
    );
  }
}
