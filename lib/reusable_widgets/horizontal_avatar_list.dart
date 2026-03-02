import 'package:fennac_app/app/constants/dummy_constants.dart';
import 'package:fennac_app/app/constants/media_query_constants.dart';
import 'package:fennac_app/app/theme/app_colors.dart';
import 'package:fennac_app/app/theme/text_styles.dart';
import 'package:fennac_app/widgets/custom_sized_box.dart';
import 'package:flutter/material.dart';

class HorizontalAvatarList extends StatelessWidget {
  final List<String>? avatars;
  final List<String>? names;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final double? avatarRadius;
  final double? itemSpacing;
  final double? nameSpacing;
  final VoidCallback? onAvatarTap;

  const HorizontalAvatarList({
    super.key,
    this.avatars,
    this.names,
    this.height,
    this.padding,
    this.avatarRadius,
    this.itemSpacing,
    this.nameSpacing,
    this.onAvatarTap,
  });

  @override
  Widget build(BuildContext context) {
    final displayAvatars = avatars ?? DummyConstants.groupImages;
    final displayNames = names ?? ['Brenda', 'Jack', 'Nancy', 'Jeff', 'Anna'];
    final displayHeight = height ?? 120.0;
    final displayPadding =
        padding ?? const EdgeInsets.symmetric(horizontal: 16);
    final displayItemSpacing = itemSpacing ?? 6.0;

    return SizedBox(
      height: displayHeight,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: displayPadding,
        itemCount: displayAvatars.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.only(right: displayItemSpacing),
            child: GestureDetector(
              onTap: onAvatarTap,
              child: Column(
                children: [
                  Container(
                    width: 72,
                    height: 72,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: ColorPalette.black, width: 2),
                    ),
                    child: CircleAvatar(
                      backgroundImage: AssetImage(displayAvatars[index]),
                      backgroundColor: Colors.transparent,
                    ),
                  ),

                  CustomSizedBox(height: nameSpacing ?? 8.0),
                  Text(
                    displayNames[index % displayNames.length],
                    style: AppTextStyles.description(context).copyWith(
                      color: isDarkTheme(context)
                          ? ColorPalette.textPrimary
                          : ColorPalette.black,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
