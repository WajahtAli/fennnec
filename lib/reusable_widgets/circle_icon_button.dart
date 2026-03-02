import 'package:fennac_app/app/constants/media_query_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CircleIconButton extends StatelessWidget {
  final String? icon;
  final VoidCallback? onTap;
  final Color? backgroundColor;
  final Color? iconColor;
  final double? iconSize;
  final double? width;
  final double? height;
  final HitTestBehavior hitTestBehavior;
  final Widget? customChild;

  const CircleIconButton({
    super.key,
    this.icon,
    this.onTap,
    this.backgroundColor,
    this.iconColor,
    this.iconSize = 20,
    this.width = 40,
    this.height = 40,
    this.hitTestBehavior = HitTestBehavior.translucent,
    this.customChild,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: hitTestBehavior,
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color:
              backgroundColor ??
              (isLightTheme(context)
                  ? Colors.white
                  : Colors.black.withOpacity(0.3)),
          shape: BoxShape.circle,
        ),
        child:
            customChild ??
            (icon != null
                ? SvgPicture.asset(
                    icon!,
                    colorFilter: ColorFilter.mode(
                      iconColor ??
                          (isLightTheme(context) ? Colors.black : Colors.white),
                      BlendMode.srcIn,
                    ),
                    width: iconSize,
                    height: iconSize,
                  )
                : const SizedBox.shrink()),
      ),
    );
  }
}
