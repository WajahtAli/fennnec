import 'package:fennac_app/app/theme/text_styles.dart';
import 'package:fennac_app/widgets/custom_back_button.dart';
import 'package:fennac_app/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  final String? title;
  final TextStyle? titleStyle;
  final Widget? action;
  final bool? allowSpace;

  const CustomAppBar({
    super.key,
    this.title,
    this.titleStyle,
    this.action,
    this.allowSpace = false,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        height: 48,
        child: Stack(
          alignment: Alignment.center,
          children: [
            // ── Row for left & right ──
            Row(
              children: [
                // Left (back button)
                Padding(
                  padding: EdgeInsets.only(
                    left: (allowSpace ?? false) ? 14 : 8,
                  ),
                  child: const CustomBackButton(),
                ),

                const Spacer(),

                // Right (action)
                Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: action ?? const SizedBox(),
                ),
              ],
            ),

            // ── Center Title (absolute center) ──
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 60),
              child: AppText(
                text: title ?? 'Find a Group',
                style:
                    titleStyle ??
                    AppTextStyles.h4(context).copyWith(letterSpacing: 0.2),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
