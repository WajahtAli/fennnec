import 'package:fennac_app/app/constants/dummy_constants.dart';
import 'package:fennac_app/app/theme/app_colors.dart';
import 'package:fennac_app/helpers/cached_network_image_helper.dart';
import 'package:fennac_app/generated/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:fennac_app/widgets/app_inkwell.dart';

class ProfileAvatar extends StatelessWidget {
  final String? imageUrl;
  final double size;
  final bool? isShowEditButton;
  final VoidCallback? onEditTap;

  const ProfileAvatar({
    super.key,
    this.imageUrl,
    this.size = 128,
    this.isShowEditButton = false,
    this.onEditTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Avatar
          Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(120),
              border: Border.all(color: ColorPalette.black, width: 2.5),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(120),
              child: imageUrl != null
                  ? CachedImageHelper(
                      imageUrl: imageUrl!,
                      fit: BoxFit.cover,
                      radius: 120,
                    )
                  : Image.asset(
                      DummyConstants.avatarPaths[0],
                      fit: BoxFit.cover,
                    ),
            ),
          ),

          // Edit button
          if (isShowEditButton == true)
            Positioned(
              bottom: 4,
              right: 4,
              child: AppInkWell(
                borderRadius: BorderRadius.circular(24),
                onTap: onEditTap ?? () {},
                child: Container(
                  width: 40,
                  height: 40,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: ColorPalette.primary,
                    shape: BoxShape.circle,
                  ),
                  child: Assets.icons.refreshCcw.svg(
                    width: 16,
                    height: 16,
                    color: ColorPalette.white,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
