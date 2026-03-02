import 'package:fennac_app/app/constants/media_query_constants.dart';
import 'package:fennac_app/app/theme/app_colors.dart';
import 'package:fennac_app/app/theme/text_styles.dart';
import 'package:fennac_app/widgets/custom_sized_box.dart';
import 'package:fennac_app/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class CreateGroupHeader extends StatelessWidget {
  const CreateGroupHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final isLight = isLightTheme(context);
    return Column(
      children: [
        Center(
          child: SizedBox(
            width: 340,
            child: AppText(
              text:
                  'Invite your friends, add group photos, create prompts, and start exploring with your friends.',
              style: AppTextStyles.body(context).copyWith(
                color: isLight
                    ? ColorPalette.black
                    : ColorPalette.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        const CustomSizedBox(height: 30),
        Center(
          child: AppText(
            text: 'You can add up to 4 members in a group.',
            style: AppTextStyles.description(
              context,
            ).copyWith(color: ColorPalette.textPrimary.withValues(alpha: 0.5)),
            textAlign: TextAlign.center,
          ),
        ),
        const CustomSizedBox(height: 10),
      ],
    );
  }
}
