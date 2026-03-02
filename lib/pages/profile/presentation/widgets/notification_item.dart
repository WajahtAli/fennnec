import 'package:fennac_app/app/theme/app_colors.dart';
import 'package:fennac_app/app/theme/text_styles.dart';
import 'package:fennac_app/reusable_widgets/custom_switch.dart';
import 'package:flutter/material.dart';

import '../../../../app/constants/media_query_constants.dart';

class NotificationItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final bool value;
  final ValueChanged<bool>? onChanged;
  final EdgeInsetsGeometry? padding;
  final TextStyle? titleStyle;
  final TextStyle? subtitleStyle;
  final bool showDivider;
  final Color? dividerColor;

  const NotificationItem({
    super.key,
    required this.title,
    required this.subtitle,
    required this.value,
    this.onChanged,
    this.padding,
    this.titleStyle,
    this.subtitleStyle,
    this.showDivider = true,
    this.dividerColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: padding ?? const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style:
                          titleStyle ??
                          AppTextStyles.body(
                            context,
                          ).copyWith(fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style:
                          subtitleStyle ??
                          AppTextStyles.description(context).copyWith(
                            color: isLightTheme(context)
                                ? ColorPalette.black
                                : ColorPalette.textSecondary,
                          ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              CustomSwitch(value: value, onChanged: onChanged ?? (_) {}),
            ],
          ),
        ),
        if (showDivider)
          Divider(
            color: dividerColor ?? ColorPalette.border.withValues(alpha: 0.3),
            thickness: 1,
          ),
      ],
    );
  }
}
