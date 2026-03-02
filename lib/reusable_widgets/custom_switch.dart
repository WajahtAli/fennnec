import 'package:fennac_app/app/constants/media_query_constants.dart';
import 'package:fennac_app/app/theme/app_colors.dart';
import 'package:flutter/material.dart';

class CustomSwitch extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;

  const CustomSwitch({super.key, required this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onChanged(!value),
      child: Container(
        width: 48,
        height: 28,
        decoration: BoxDecoration(
          color: value && isLightTheme(context)
              ? ColorPalette.primary.withValues(alpha: 0.1)
              : isLightTheme(context)
              ? ColorPalette.black.withValues(alpha: 0.1)
              : ColorPalette.cardBlack,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: value && isLightTheme(context)
                ? ColorPalette.primary
                : value
                ? ColorPalette.white
                : ColorPalette.border,
            width: 1.5,
          ),
        ),
        child: AnimatedAlign(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeInOut,
          alignment: value ? Alignment.centerRight : Alignment.centerLeft,
          child: Container(
            width: 22,
            height: 22,
            margin: const EdgeInsets.symmetric(horizontal: 1),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: value && isLightTheme(context)
                  ? ColorPalette.primary
                  : value
                  ? ColorPalette.white
                  : ColorPalette.border,
            ),
          ),
        ),
      ),
    );
  }
}
