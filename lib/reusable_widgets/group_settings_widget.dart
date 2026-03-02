import 'package:fennac_app/app/constants/media_query_constants.dart';
import 'package:fennac_app/app/theme/app_colors.dart';
import 'package:fennac_app/app/theme/text_styles.dart';
import 'package:fennac_app/widgets/custom_sized_box.dart';
import 'package:fennac_app/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class GroupSettingsWidget extends StatelessWidget {
  final String title;
  final List<GroupSettingItem> settings;

  const GroupSettingsWidget({
    super.key,
    this.title = 'Group Settings',
    required this.settings,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(
          text: title,
          style: AppTextStyles.subHeading(
            context,
          ).copyWith(fontWeight: FontWeight.w600),
        ),
        const CustomSizedBox(height: 16),
        ...settings.map((setting) => _buildSettingItem(context, setting)),
      ],
    );
  }

  Widget _buildSettingItem(BuildContext context, GroupSettingItem setting) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: AppText(
              text: setting.label,
              style: AppTextStyles.body(context),
            ),
          ),
          const CustomSizedBox(width: 16),
          _CustomSwitch(value: setting.value, onChanged: setting.onChanged),
        ],
      ),
    );
  }
}

class GroupSettingItem {
  final String label;
  final bool value;
  final ValueChanged<bool> onChanged;

  GroupSettingItem({
    required this.label,
    required this.value,
    required this.onChanged,
  });
}

class _CustomSwitch extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;

  const _CustomSwitch({required this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onChanged(!value),
      child: Container(
        width: 56,
        height: 32,
        decoration: BoxDecoration(
          color: value
              ? ColorPalette.grey
              : Colors.black.withValues(alpha: 0.3),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: value
                ? ColorPalette.white
                : Colors.grey.withValues(alpha: 0.8),
            width: 1.5,
          ),
        ),
        child: AnimatedAlign(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeInOut,
          alignment: value ? Alignment.centerRight : Alignment.centerLeft,
          child: Container(
            width: 24,
            height: 24,
            margin: const EdgeInsets.symmetric(horizontal: 2),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: value
                  ? isLightTheme(context)
                        ? ColorPalette.primary
                        : ColorPalette.white
                  : Colors.grey.withValues(alpha: 0.8),
            ),
          ),
        ),
      ),
    );
  }
}
