import 'package:flutter/material.dart';

import 'package:fennac_app/app/theme/text_styles.dart';
import 'package:fennac_app/reusable_widgets/custom_app_bar.dart';

import '../../../../app/constants/app_enums.dart';

class FindGroupHeader extends StatelessWidget {
  final FindGroupScreenType findGroupScreenType;
  const FindGroupHeader({super.key, required this.findGroupScreenType});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomAppBar(
          title: findGroupScreenType == FindGroupScreenType.qrProfileCode
              ? 'Find a Member'
              : 'Find a Group',
        ),
        const SizedBox(height: 8),
        Text(
          findGroupScreenType == FindGroupScreenType.qrProfileCode
              ? 'Quickly connect with your friends by scanning their\nprofile QR code.'
              : 'Quickly connect with your friends by scanning their\ngroup\'s QR code.',
          textAlign: TextAlign.center,
          style: AppTextStyles.body(context),
        ),
      ],
    );
  }
}
