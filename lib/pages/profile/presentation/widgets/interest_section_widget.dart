import 'package:fennac_app/app/constants/dummy_constants.dart';
import 'package:fennac_app/app/constants/media_query_constants.dart';
import 'package:fennac_app/app/theme/app_colors.dart';
import 'package:fennac_app/app/theme/text_styles.dart';
import 'package:fennac_app/generated/assets.gen.dart';
import 'package:fennac_app/pages/auth/data/model/login_model.dart';
import 'package:fennac_app/widgets/custom_sized_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'profile_interest_chip.dart';

class InterestSectionWidget extends StatelessWidget {
  final String userName;
  final Vibes? vibes;
  final VoidCallback onEditTap;

  const InterestSectionWidget({
    super.key,
    required this.userName,
    required this.vibes,
    required this.onEditTap,
  });

  @override
  Widget build(BuildContext context) {
    // Collect all selected vibes into a flat list
    List<String> userVibes = [];
    if (vibes != null) {
      userVibes.addAll(vibes!.sportsAndOutdoor ?? []);
      userVibes.addAll(vibes!.foodAndDrink ?? []);
      userVibes.addAll(vibes!.musicAndArts ?? []);
      userVibes.addAll(vibes!.travelAndAdventure ?? []);
      userVibes.addAll(vibes!.techAndGaming ?? []);
      if (vibes!.readingAndLearning is List) {
        userVibes.addAll(List<String>.from(vibes!.readingAndLearning));
      }
      if (vibes!.otherFunInterests is List) {
        userVibes.addAll(List<String>.from(vibes!.otherFunInterests));
      }
    }

    // Map backend saved values back to the UI values with emojis
    List<String> displayInterests = [];
    if (userVibes.isNotEmpty) {
      DummyConstants.interestCategories.values
          .expand((element) => element)
          .forEach((interest) {
            final stripped = interest
                .replaceAll(RegExp(r'[\p{Emoji}]+', unicode: true), '')
                .trim()
                .toLowerCase();
            if (userVibes.contains(stripped)) {
              displayInterests.add(interest);
            }
          });
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "$userName's Interests",
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
        if (displayInterests.isEmpty)
          ProfileInterestChip(
            emoji: "",
            label: "Add Interests You Like",
            isEmojiFirst: true,
          )
        else
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: displayInterests.map((interest) {
              String emoji = '';
              String label = interest;
              int firstSpace = interest.indexOf(' ');
              if (firstSpace != -1 &&
                  firstSpace < interest.runes.length &&
                  interest.runes.first > 255) {
                emoji = interest.substring(0, firstSpace);
                label = interest.substring(firstSpace + 1);
              } else if (firstSpace != -1) {
                // Try to split logic assuming first space separates emoji
                emoji = interest.substring(0, firstSpace);
                label = interest.substring(firstSpace + 1);
              }
              return ProfileInterestChip(
                emoji: emoji,
                label: label,
                isEmojiFirst: true,
              );
            }).toList(),
          ),
      ],
    );
  }
}
