import 'package:fennac_app/app/theme/text_styles.dart';
import 'package:fennac_app/widgets/custom_back_button.dart';
import 'package:fennac_app/widgets/custom_sized_box.dart';
import 'package:fennac_app/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  final String? title;
  final TextStyle? titleStyle;
  const CustomAppBar({super.key, this.title, this.titleStyle});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        height: 30,
        child: Row(
          children: [
            const CustomBackButton(),
            const Spacer(),
            AppText(
              text: title ?? 'Find a Group',
              style:
                  titleStyle ??
                  AppTextStyles.h4(context).copyWith(letterSpacing: 0.2),
            ),
            const Spacer(),
            const CustomSizedBox(width: 58),
          ],
        ),
      ),
    );
  }
}
