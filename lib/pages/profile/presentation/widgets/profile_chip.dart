import 'dart:ui';
import 'package:fennac_app/app/constants/media_query_constants.dart';
import 'package:fennac_app/app/theme/app_colors.dart';
import 'package:fennac_app/app/theme/text_styles.dart';
import 'package:fennac_app/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ProfileChip extends StatelessWidget {
  final String? emoji;
  final String? icon;
  final String label;

  const ProfileChip({super.key, this.emoji, this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(48),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
        child: Container(
          height: 24,
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
          decoration: BoxDecoration(
            color: isLightTheme(context)
                ? ColorPalette.textGrey
                : ColorPalette.primary,
            borderRadius: BorderRadius.circular(48),
            border: Border.all(color: ColorPalette.primary, width: 1),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (emoji != null) ...[
                Text(emoji!, style: const TextStyle(fontSize: 12)),
                const SizedBox(width: 5),
              ],
              if (icon != null) ...[
                SvgPicture.asset(
                  icon!,
                  height: 12,
                  width: 12,
                  colorFilter: ColorFilter.mode(
                    isLightTheme(context) ? Colors.black : ColorPalette.white,
                    BlendMode.srcIn,
                  ),
                ),
                const SizedBox(width: 5),
              ],
              AppText(
                text: label,
                style: AppTextStyles.description(context).copyWith(
                  color: isLightTheme(context)
                      ? Colors.black
                      : ColorPalette.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
