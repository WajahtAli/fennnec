import 'package:fennac_app/app/theme/app_colors.dart';
import 'package:fennac_app/app/theme/text_styles.dart';
import 'package:fennac_app/pages/home/data/models/groups_model.dart';
import 'package:fennac_app/widgets/custom_sized_box.dart';
import 'package:fennac_app/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class AudioParticipantTile extends StatelessWidget {
  final Member profile;
  final bool isVideoCall;
  const AudioParticipantTile({
    super.key,
    required this.profile,
    this.isVideoCall = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ColorPalette.secondary.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(12),
        image: isVideoCall
            ? DecorationImage(
                image: AssetImage(profile.coverImage ?? ''),
                fit: BoxFit.cover,
              )
            : null,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          if (!isVideoCall)
            Container(
              padding: const EdgeInsets.all(3),
              decoration: BoxDecoration(shape: BoxShape.circle),
              child: CircleAvatar(
                radius: 60,
                backgroundImage: AssetImage(profile.coverImage ?? ''),
                backgroundColor: ColorPalette.secondary,
              ),
            ),
          const CustomSizedBox(height: 12),
          AppText(
            text: profile.firstName ?? "",
            style: AppTextStyles.body(
              context,
            ).copyWith(fontWeight: FontWeight.w600),
          ),
          const CustomSizedBox(height: 12),
        ],
      ),
    );
  }
}
