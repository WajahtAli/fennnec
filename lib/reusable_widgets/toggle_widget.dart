import 'package:fennac_app/app/constants/media_query_constants.dart';
import 'package:fennac_app/app/theme/app_colors.dart';
import 'package:fennac_app/app/theme/text_styles.dart';
import 'package:fennac_app/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class ToggleWidget extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;
  final Gradient? selectedGradient;
  final Color? selectedColor;
  final Color? unselectedColor;
  final TextStyle? textStyle;
  final double? width;
  final double? height;
  const ToggleWidget({
    super.key,
    required this.label,
    required this.isSelected,
    required this.onTap,
    this.selectedGradient,
    this.selectedColor,
    this.unselectedColor,
    this.textStyle,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    final double buttonWidth = width ?? getProportionalWidth(context, 188);
    final double buttonHeight = height ?? getProportionalHeight(context, 34);
    final EdgeInsets padding = EdgeInsets.fromLTRB(
      getProportionalWidth(context, 8),
      getProportionalHeight(context, 4),
      getProportionalWidth(context, 8),
      getProportionalHeight(context, 4),
    );
    final double radius = getProportionalHeight(context, 24);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        // width: buttonWidth,
        height: buttonHeight,
        alignment: Alignment.center,
        padding: padding,
        decoration: BoxDecoration(
          color: isSelected
              ? selectedColor ??
                    (selectedGradient == null ? ColorPalette.primary : null)
              : unselectedColor ?? Colors.transparent,
          gradient: isSelected ? selectedGradient : null,
          borderRadius: BorderRadius.circular(radius),
        ),
        child: AppText(
          text: label,
          style:
              textStyle ??
              AppTextStyles.body(context).copyWith(
                color: isSelected
                    ? Colors.white
                    : (isLightTheme(context) ? Colors.black : Colors.white),
                fontWeight: FontWeight.bold,
              ),
        ),
      ),
    );
  }
}
