import 'package:fennac_app/app/constants/media_query_constants.dart';
import 'package:fennac_app/app/theme/app_colors.dart';
import 'package:fennac_app/app/theme/app_emojis.dart';
import 'package:fennac_app/app/theme/text_styles.dart';
import 'package:fennac_app/generated/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';

class AnimatedBackgroundContainer extends StatelessWidget {
  final double? height;
  final double? width;
  final String? icon;
  final bool? isPng;
  final bool? isEmoji;
  final double? iconHeight;
  final double? iconWidth;
  const AnimatedBackgroundContainer({
    super.key,
    this.height,
    this.width,
    this.icon,
    this.isPng = false,
    this.isEmoji = false,
    this.iconHeight,
    this.iconWidth,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? (isPng! ? 120 : 100),
      height: height ?? (isPng! ? 120 : 100),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Lottie.asset(
            isLightTheme(context)
                ? Assets.animations.iconBGLight
                : Assets.animations.iconBg,
            width: (isPng! ? 120 : 100),
            height: (isPng! ? 120 : 100),
            fit: BoxFit.cover,
          ),
          if (isPng == false && isEmoji == false)
            SvgPicture.asset(
              icon ?? Assets.icons.vector3.path,
              colorFilter: isLightTheme(context)
                  ? ColorFilter.mode(ColorPalette.primary, BlendMode.srcIn)
                  : null,
              height: iconHeight ?? 40,
              width: iconWidth ?? 40,
            ),
          if (isPng == true && isEmoji == false)
            Image.asset(
              icon ?? Assets.icons.vector3.path,
              height: iconHeight ?? 72,
              width: iconWidth ?? 72,
              fit: BoxFit.cover,
              color: isLightTheme(context)
                  ? ColorPalette.primary
                  : Colors.green,
            ),

          if (isEmoji == true && isPng == false)
            Text(icon ?? AppEmojis.okHand, style: AppTextStyles.h1(context)),
        ],
      ),
    );
  }
}
