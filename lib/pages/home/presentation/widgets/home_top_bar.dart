import 'package:fennac_app/app/constants/media_query_constants.dart';
import 'package:fennac_app/app/theme/app_colors.dart';
import 'package:fennac_app/generated/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeTopBar extends StatelessWidget {
  final VoidCallback? onBackPressed;
  final VoidCallback? onSettingsPressed;
  final bool? isLikedGroups;

  const HomeTopBar({
    super.key,
    this.onBackPressed,
    this.onSettingsPressed,
    this.isLikedGroups = false,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: onBackPressed,
            child: Container(
              height: 40,
              width: 40,
              alignment: Alignment.center,
              margin: const EdgeInsets.symmetric(horizontal: 16),

              decoration: BoxDecoration(
                color: Colors.black26,
                shape: BoxShape.circle,
              ),
              child: SvgPicture.asset(
                isLikedGroups == true
                    ? Assets.icons.arrowLeft.path
                    : Assets.icons.rotateCcw.path,
                height: 16,
              ),
            ),
          ),

          // SvgPicture.asset(Assets.icons.fennecLogoText.path, height: 18),
          Text(
            'Fennec',
            textAlign: TextAlign.center,
            style: GoogleFonts.shrikhand(
              fontSize: 32,
              fontWeight: FontWeight.w400,
              fontStyle: FontStyle.italic,
              height: 1.0,
              letterSpacing: 0,
              color: isLightTheme(context)
                  ? ColorPalette.primary
                  : Colors.white,
            ),
          ),
          GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: onSettingsPressed,
            child: Container(
              height: 40,
              width: 40,
              alignment: Alignment.center,
              margin: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.black26,
                shape: BoxShape.circle,
              ),
              child: SvgPicture.asset(
                isLikedGroups == true
                    ? Assets.icons.refreshCcw.path
                    : Assets.icons.sliders.path,
                height: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
