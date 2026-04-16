import 'package:fennac_app/app/constants/media_query_constants.dart';
import 'package:fennac_app/app/theme/app_colors.dart';
import 'package:fennac_app/helpers/cached_network_image_helper.dart';
import 'package:fennac_app/generated/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:fennac_app/widgets/app_inkwell.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
    final fallbackAvatar = _buildFallbackAvatar(context);
    final hasImage = imageUrl?.trim().isNotEmpty == true;

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
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(120),
              border: Border.all(
                color: isLightTheme(context)
                    ? ColorPalette.black
                    : Colors.white,
                width: 2.5,
              ),
            ),
            child: hasImage
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(120),
                    child: CachedImageHelper(
                      imageUrl: imageUrl,
                      width: size,
                      height: size,
                      fit: BoxFit.cover,
                      radius: 0,
                      placeholder: fallbackAvatar,
                      errorWidget: fallbackAvatar,
                    ),
                  )
                : CachedImageHelper(
                    imageUrl: imageUrl,
                    width: size,
                    height: size,
                    fit: BoxFit.cover,
                    radius: 0,
                    placeholder: fallbackAvatar,
                    errorWidget: fallbackAvatar,
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

  Widget _buildFallbackAvatar(BuildContext context) {
    return Center(
      child: SvgPicture.asset(
        Assets.icons.user.path,
        fit: BoxFit.cover,
        colorFilter: ColorFilter.mode(
          isLightTheme(context) ? ColorPalette.primary : Colors.white,
          BlendMode.srcIn,
        ),
        width: size * 0.5,
        height: size * 0.5,
      ),
    );
  }
}
