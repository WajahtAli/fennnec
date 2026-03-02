import 'package:fennac_app/app/theme/text_styles.dart';
import 'package:fennac_app/app/constants/media_query_constants.dart';
import 'package:fennac_app/widgets/custom_sized_box.dart';
import 'package:flutter/material.dart';

class ProfileSectionWrapper extends StatelessWidget {
  final String title;
  final Widget child;

  const ProfileSectionWrapper({
    super.key,
    required this.title,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppTextStyles.h3(context).copyWith(
            fontWeight: FontWeight.bold,
            color: isLightTheme(context) ? Colors.black : Colors.white,
          ),
        ),
        const CustomSizedBox(height: 12),
        child,
      ],
    );
  }
}
