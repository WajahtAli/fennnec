import 'package:fennac_app/app/constants/media_query_constants.dart';
import 'package:fennac_app/app/theme/app_colors.dart';
import 'package:fennac_app/app/theme/text_styles.dart';
import 'package:fennac_app/core/extensions/string_extension.dart';
import 'package:fennac_app/generated/assets.gen.dart';
import 'package:fennac_app/widgets/custom_sized_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'profile_interest_chip.dart';

class LifestyleSectionWidget extends StatelessWidget {
  final String userName;
  final List<String> lifestyles;
  final VoidCallback onEditTap;

  const LifestyleSectionWidget({
    super.key,
    required this.userName,
    required this.lifestyles,
    required this.onEditTap,
  });

  @override
  Widget build(BuildContext context) {
    List<String> displayLifestyles = lifestyles.isNotEmpty ? lifestyles : [];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "$userName's Life",
              style: AppTextStyles.h2(context).copyWith(
                fontWeight: FontWeight.bold,
                color: isLightTheme(context) ? Colors.black : Colors.white,
              ),
            ),
            GestureDetector(
              onTap: onEditTap,
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: ColorPalette.primary,
                  shape: BoxShape.circle,
                ),
                child: SvgPicture.asset(
                  Assets.icons.edit.path,
                  height: 16,
                  width: 16,
                  colorFilter: const ColorFilter.mode(
                    Colors.white,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),
          ],
        ),
        const CustomSizedBox(height: 16),
        if (displayLifestyles.isEmpty)
          ProfileInterestChip(emoji: "", label: "Choose your lifestyle"),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: displayLifestyles.map((lifestyle) {
            String emoji = '';
            String label = lifestyle;
            int lastSpace = lifestyle.lastIndexOf(' ');
            if (lastSpace != -1) {
              emoji = lifestyle.substring(lastSpace + 1);
              label = lifestyle.substring(0, lastSpace).capitalize();
            }
            return ProfileInterestChip(emoji: emoji, label: label);
          }).toList(),
        ),
      ],
    );
  }
}
