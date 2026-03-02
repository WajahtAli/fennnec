import 'package:fennac_app/app/constants/media_query_constants.dart';
import 'package:fennac_app/app/theme/app_colors.dart';
import 'package:fennac_app/app/theme/text_styles.dart';
import 'package:flutter/material.dart';

class FilterPill extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const FilterPill({
    super.key,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 44,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected
              ? ColorPalette.primary
              : (isLightTheme(context)
                    ? ColorPalette.textGrey
                    : ColorPalette.primary.withValues(alpha: 0.25)),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: isSelected
                ? ColorPalette.primary
                : (isLightTheme(context)
                      ? Colors.transparent
                      : ColorPalette.primary),
            width: 1.5,
          ),
        ),
        child: Text(
          label,
          style: AppTextStyles.bodyLarge(context).copyWith(
            color: isSelected
                ? Colors.white
                : (isLightTheme(context)
                      ? Colors.black.withValues(alpha: 0.7)
                      : Colors.white70),
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
