import '../app/constants/media_query_constants.dart';
import 'package:flutter/material.dart';
import '../app/theme/app_colors.dart';
import '../app/theme/text_styles.dart';
import 'custom_text.dart';

class CustomLabelTextField extends StatelessWidget {
  final String? label;
  final TextEditingController? controller;
  final Function(String)? onChanged;
  final Function(String)? onSubmit;
  final String? Function(String?)? validator;
  final bool? readOnly;
  final bool? obscureText;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final Widget? suffix;
  final Widget? prefix;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final String? hintText;
  final Color? labelColor;
  final TextStyle? labelStyle;
  final TextStyle? textStyle;
  final TextStyle? hintStyle;
  final Color? fillColor;
  final double? borderRadius;
  final bool? filled;
  final InputBorder? border;
  final InputBorder? enabledBorder;
  final InputBorder? focusedBorder;
  final InputBorder? errorBorder;
  final InputBorder? focusedErrorBorder;
  final TextStyle? errorStyle;
  final EdgeInsetsGeometry? contentPadding;
  final int? maxLines;
  final int? minLines;
  final ScrollController? scrollController;
  final bool isCentered;

  const CustomLabelTextField({
    super.key,
    this.label,
    this.controller,
    this.onChanged,
    this.onSubmit,
    this.validator,
    this.readOnly,
    this.obscureText,
    this.suffixIcon,
    this.prefixIcon,
    this.suffix,
    this.prefix,
    this.keyboardType,
    this.hintText,
    this.labelColor,
    this.labelStyle,
    this.textStyle,
    this.hintStyle,
    this.textInputAction,
    this.fillColor,
    this.borderRadius,
    this.filled,
    this.border,
    this.enabledBorder,
    this.focusedBorder,
    this.errorBorder,
    this.focusedErrorBorder,
    this.errorStyle,
    this.contentPadding,
    this.maxLines,
    this.minLines,
    this.scrollController,
    this.isCentered = false,
  });

  @override
  Widget build(BuildContext context) {
    final bool isLight = isLightTheme(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null)
          AppText(
            text: label!,
            style:
                labelStyle ??
                AppTextStyles.inputLabel(context).copyWith(
                  color:
                      labelColor ??
                      (isLight ? Colors.black : ColorPalette.white),
                  fontWeight: FontWeight.bold,
                ),
          ),
        // if (label != null) CustomSizedBox(height: 8),

        // Check if using default rounded style or underline style
        if (filled == false || border != null || enabledBorder != null)
          // Underline style (for login screen)
          TextFormField(
            controller: controller,
            onChanged: onChanged,
            onFieldSubmitted: onSubmit,
            validator: validator,
            scrollController: scrollController,
            keyboardType: keyboardType,
            textInputAction: textInputAction ?? TextInputAction.done,
            readOnly: readOnly ?? false,
            obscureText: obscureText ?? false,
            maxLines: obscureText == true ? 1 : maxLines,
            minLines: minLines,
            textAlign: isCentered ? TextAlign.center : TextAlign.start,
            textAlignVertical: isCentered
                ? TextAlignVertical.center
                : TextAlignVertical.center,
            style:
                textStyle ??
                AppTextStyles.bodyLarge(
                  context,
                ).copyWith(color: isLight ? ColorPalette.black : null),
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle:
                  hintStyle ??
                  AppTextStyles.inputLabel(context).copyWith(
                    color: isLight
                        ? ColorPalette.black.withValues(alpha: 0.6)
                        : ColorPalette.white.withValues(alpha: 0.9),
                  ),
              filled: filled ?? false,
              fillColor:
                  fillColor ?? (isLight ? Colors.white : Colors.transparent),
              suffixIcon: suffixIcon,
              prefixIcon: prefixIcon,
              suffix: suffix,
              prefix: prefix,
              border: border,
              enabledBorder:
                  enabledBorder ??
                  UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: isLight
                          ? ColorPalette.black.withOpacity(0.2)
                          : Colors.white24,
                    ),
                  ),
              focusedBorder:
                  focusedBorder ??
                  UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: isLight ? ColorPalette.primary : Colors.white70,
                    ),
                  ),
              errorBorder:
                  errorBorder ??
                  const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.red),
                  ),
              focusedErrorBorder:
                  focusedErrorBorder ??
                  const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.red),
                  ),
              errorStyle:
                  errorStyle ??
                  const TextStyle(color: Colors.red, fontSize: 12),
              contentPadding:
                  contentPadding ?? const EdgeInsets.symmetric(vertical: 12),
            ),
          )
        else
          // Rounded style (default - your original style)
          ClipRRect(
            borderRadius: BorderRadius.circular(borderRadius ?? 15),
            child: TextFormField(
              controller: controller,
              onChanged: onChanged,
              onFieldSubmitted: onSubmit,
              validator: validator,
              keyboardType: keyboardType,
              readOnly: readOnly ?? false,
              obscureText: obscureText ?? false,
              maxLines: obscureText == true ? 1 : (maxLines ?? 1),
              minLines: minLines,
              style:
                  textStyle ??
                  AppTextStyles.bodyLarge(
                    context,
                  ).copyWith(color: isLight ? ColorPalette.textPrimary : null),
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle:
                    hintStyle ??
                    AppTextStyles.inputLabel(context).copyWith(
                      color: isLight
                          ? ColorPalette.textSecondary.withOpacity(0.7)
                          : ColorPalette.textPrimary.withValues(alpha: 0.9),
                    ),
                border: InputBorder.none,
                filled: true,
                fillColor:
                    fillColor ?? (isLight ? Colors.white : Colors.transparent),
                suffixIcon: suffixIcon,
                prefixIcon: prefixIcon,
                suffix: suffix,
                prefix: prefix,
                contentPadding:
                    contentPadding ??
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              ),
            ),
          ),
      ],
    );
  }
}
