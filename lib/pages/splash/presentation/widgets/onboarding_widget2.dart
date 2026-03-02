import 'package:fennac_app/app/theme/text_styles.dart';
import 'package:fennac_app/generated/assets.gen.dart';
import 'package:fennac_app/widgets/custom_sized_box.dart';
import 'package:fennac_app/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class OnboardingWidget2 extends StatelessWidget {
  const OnboardingWidget2({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    final designHeight = 956.0;

    final lottieHeight = (600 / designHeight) * screenHeight;

    return Stack(
      children: [
        Positioned.fill(
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Lottie.asset(Assets.animations.emojis7s, fit: BoxFit.cover),
          ),
        ),
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            child: SizedBox(
              width: screenWidth,
              height: lottieHeight,
              child: Lottie.asset(
                Assets.animations.scrollingMessagesTopOpacity,
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Padding(
            padding: EdgeInsets.only(
              left: 14,
              right: 14,
              bottom: MediaQuery.paddingOf(context).bottom + 14,
            ),
            child: SizedBox(
              width: screenWidth,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AppText(
                    text: 'Group Chats that\nStay Alive',
                    textAlign: TextAlign.center,
                    style: AppTextStyles.h2(
                      context,
                    ).copyWith(fontWeight: FontWeight.bold),
                  ),
                  const CustomSizedBox(height: 12),
                  AppText(
                    text:
                        'Dive into a shared chat room,\t\tHave fun with your friends',
                    textAlign: TextAlign.center,
                    style: AppTextStyles.subHeading(
                      context,
                    ).copyWith(fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
