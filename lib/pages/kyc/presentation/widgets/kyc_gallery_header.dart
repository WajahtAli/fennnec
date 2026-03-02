import 'package:fennac_app/app/constants/media_query_constants.dart';
import 'package:fennac_app/app/theme/text_styles.dart';
import 'package:fennac_app/widgets/custom_back_button.dart';
import 'package:fennac_app/widgets/custom_sized_box.dart';
import 'package:fennac_app/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class KycGalleryHeader extends StatelessWidget {
  const KycGalleryHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CustomSizedBox(height: 24),
        const CustomBackButton(padding: EdgeInsets.symmetric(horizontal: 12)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CustomSizedBox(height: 32),
              AppText(
                text: 'Upload your best shots and short clips.',
                style: AppTextStyles.h1(context).copyWith(
                  color: isLightTheme(context) ? Colors.black : Colors.white,
                  wordSpacing: 1.5,
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
