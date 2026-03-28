import 'package:cached_network_image/cached_network_image.dart';
import 'package:fennac_app/app/constants/media_query_constants.dart';
import 'package:fennac_app/app/theme/app_colors.dart';
import 'package:fennac_app/app/theme/text_styles.dart';
import 'package:fennac_app/pages/chats/data/models/chat_and_calls_response.dart';
import 'package:fennac_app/widgets/custom_sized_box.dart';
import 'package:flutter/material.dart';

class HorizontalAvatarList extends StatelessWidget {
  final List<MemberModel> members;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final double? itemSpacing;
  final double? nameSpacing;
  final void Function(MemberModel member)? onAvatarTap;

  const HorizontalAvatarList({
    super.key,
    required this.members,
    this.height,
    this.padding,
    this.itemSpacing,
    this.nameSpacing,
    this.onAvatarTap,
  });

  @override
  Widget build(BuildContext context) {
    final displayHeight = height ?? 120.0;
    final displayPadding =
        padding ?? const EdgeInsets.symmetric(horizontal: 16);
    final displayItemSpacing = itemSpacing ?? 6.0;

    return SizedBox(
      height: displayHeight,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: displayPadding,
        itemCount: members.length,
        itemBuilder: (context, index) {
          final member = members[index];
          return Padding(
            padding: EdgeInsets.only(right: displayItemSpacing),
            child: GestureDetector(
              onTap: onAvatarTap != null ? () => onAvatarTap!(member) : null,
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
                      backgroundColor: Colors.transparent,
                      child: ClipOval(
                        child: CachedNetworkImage(
                          imageUrl: member.image,
                          width: 72,
                          height: 72,
                          fit: BoxFit.cover,
                          errorWidget: (_, __, ___) =>
                              const Icon(Icons.person_rounded, size: 36),
                        ),
                      ),
                    ),
                  ),
                  CustomSizedBox(height: nameSpacing ?? 8.0),
                  Text(
                    member.name,
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
