import 'package:fennac_app/app/constants/media_query_constants.dart';
import 'package:fennac_app/generated/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../app/theme/app_colors.dart';
import '../app/theme/text_styles.dart';

class CustomSearchField extends StatelessWidget {
  final TextEditingController? controller;
  final Function(String)? onChanged;
  final Function(String)? onSubmit;
  final String? hintText;
  final Color? fillColor;
  final double? borderRadius;
  final TextStyle? textStyle;
  final TextStyle? hintStyle;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final EdgeInsetsGeometry? contentPadding;
  final bool? readOnly;
  final VoidCallback? onTap;
  final InputBorder? border;
  final InputBorder? enabledBorder;
  final InputBorder? focusedBorder;
  final EdgeInsetsGeometry? margin;

  const CustomSearchField({
    super.key,
    this.controller,
    this.onChanged,
    this.onSubmit,
    this.hintText,
    this.fillColor,
    this.borderRadius,
    this.textStyle,
    this.hintStyle,
    this.prefixIcon,
    this.suffixIcon,
    this.contentPadding,
    this.readOnly,
    this.onTap,
    this.border,
    this.enabledBorder,
    this.focusedBorder,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      margin: margin ?? EdgeInsets.symmetric(horizontal: 24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius ?? 16),
        border: Border.all(color: const Color(0x80666666), width: 1),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius ?? 16),
        child: TextField(
          controller: controller,
          onChanged: onChanged,
          onSubmitted: onSubmit,
          readOnly: readOnly ?? false,
          onTap: onTap,
          style: textStyle ?? AppTextStyles.body(context),
          decoration: InputDecoration(
            hintText: hintText ?? 'Search',
            hintStyle: hintStyle ?? AppTextStyles.body(context).copyWith(),
            filled: true,
            fillColor:
                fillColor ??
                (isLightTheme(context)
                    ? Colors.white
                    : ColorPalette.black.withValues(alpha: 0.1)),
            prefixIcon: Padding(
              padding: const EdgeInsets.all(16),
              child:
                  prefixIcon ??
                  SvgPicture.asset(
                    Assets.icons.search.path,
                    height: 24,
                    width: 24,
                    color: isLightTheme(context) ? Colors.black : Colors.white,
                  ),
            ),
            suffixIcon: suffixIcon,
            border: border ?? InputBorder.none,
            enabledBorder: enabledBorder ?? InputBorder.none,
            focusedBorder: focusedBorder ?? InputBorder.none,
            contentPadding:
                contentPadding ??
                const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          ),
        ),
      ),
    );
  }
}
