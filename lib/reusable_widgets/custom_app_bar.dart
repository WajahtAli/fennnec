import 'package:fennac_app/app/theme/text_styles.dart';
import 'package:fennac_app/widgets/custom_back_button.dart';
import 'package:fennac_app/widgets/custom_sized_box.dart';
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
        child: Row(
          children: [
            if (allowSpace ?? false) CustomSizedBox(width: 14),
            const SizedBox(
              width: 58,
              child: Align(
                alignment: Alignment.centerLeft,
                child: CustomBackButton(),
              ),
            ),

            Expanded(
              child: Center(
                child: AppText(
                  text: title ?? 'Find a Group',
                  style:
                      titleStyle ??
                      AppTextStyles.h4(context).copyWith(letterSpacing: 0.2),
                ),
              ),
            ),

            SizedBox(
              width: 58,
              child: Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  child: action ?? const SizedBox(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
