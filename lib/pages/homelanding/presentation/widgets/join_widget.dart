import 'package:fennac_app/app/constants/media_query_constants.dart';
import 'package:fennac_app/app/theme/app_colors.dart';
import 'package:fennac_app/app/theme/text_styles.dart';
import 'package:fennac_app/core/di_container.dart';
import 'package:fennac_app/generated/assets.gen.dart';
import 'package:fennac_app/pages/dashboard/presentation/bloc/cubit/dashboard_cubit.dart';
import 'package:fennac_app/pages/home/presentation/screen/home_screen.dart';
import 'package:fennac_app/widgets/custom_elevated_button.dart';
import 'package:fennac_app/widgets/custom_sized_box.dart';
import 'package:fennac_app/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class JoinWidget extends StatelessWidget {
  const JoinWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          Center(
            child: Assets.icons.checkGreen.image(
              width: getWidth(context) > 370 ? 72 : 62,
              height: getWidth(context) > 370 ? 72 : 62,
            ),
          ),
          const CustomSizedBox(height: 20),

          AppText(
            text: "Welcome to the group!",
            style: getWidth(context) > 370
                ? AppTextStyles.h2(context)
                : AppTextStyles.h3(context),
            textAlign: TextAlign.center,
          ),
          const CustomSizedBox(height: 24),
          // Invitation Description
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: AppText(
              text:
                  'Your group profile is ready. Chat, share, and match with other groups nearby!',
              style: AppTextStyles.subHeading(context).copyWith(
                color: isDarkTheme(context)
                    ? ColorPalette.textSecondary
                    : ColorPalette.black,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const CustomSizedBox(height: 24),
          CustomElevatedButton(
            text: 'Start Exploring',
            onTap: () {
              //todo
              // VxToast.show(message: 'Coming Soon!');
              Di().sl<DashboardCubit>().changePage(0, HomeScreen());
              // _homeLandingCubit.selectDeclined(InvitationStatus.declined);
            },
          ),
        ],
      ),
    );
  }
}
