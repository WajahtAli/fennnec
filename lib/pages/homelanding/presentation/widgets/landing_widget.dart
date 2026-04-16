import 'package:auto_route/auto_route.dart';
import 'package:fennac_app/app/constants/app_enums.dart';
import 'package:fennac_app/app/constants/media_query_constants.dart';
import 'package:fennac_app/app/theme/app_colors.dart';
import 'package:fennac_app/app/theme/text_styles.dart';
import 'package:fennac_app/core/di_container.dart';
import 'package:fennac_app/generated/assets.gen.dart';
import 'package:fennac_app/pages/homelanding/presentation/bloc/cubit/home_landing_cubit.dart';
import 'package:fennac_app/routes/routes_imports.gr.dart';
import 'package:fennac_app/widgets/custom_elevated_button.dart';
import 'package:fennac_app/widgets/custom_outlined_button.dart';
import 'package:fennac_app/widgets/custom_sized_box.dart';
import 'package:fennac_app/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class LandingWidget extends StatelessWidget {
  const LandingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          Center(
            child: Assets.icons.groupUsersIcon4.svg(
              width: getWidth(context) > 370 ? 52 : 42,
              height: getWidth(context) > 370 ? 52 : 42,
              color: isLightTheme(context)
                  ? ColorPalette.primary
                  : Colors.white,
            ),
          ),

          const CustomSizedBox(height: 24),
          AppText(
            text: 'No Invitations',
            style: AppTextStyles.h2(
              context,
            ).copyWith(fontSize: getWidth(context) > 370 ? 32 : 24),
            textAlign: TextAlign.center,
          ),
          const CustomSizedBox(height: 20),
          AppText(
            text:
                'You can create your own group or join another one using a link, or QR code.',
            style: AppTextStyles.subHeading(context),
            textAlign: TextAlign.center,
          ),
          const CustomSizedBox(height: 24),
          Row(
            children: [
              Expanded(
                child: CustomElevatedButton(
                  text: 'Create a Group',
                  onTap: () {
                    context.router.push(CreateGroupRoute());
                  },
                ),
              ),
              const CustomSizedBox(width: 14),
              Expanded(
                child: CustomOutlinedButton(
                  padding: EdgeInsets.all(4),
                  text: 'Find a Group',
                  onPressed: () {
                    Di().sl<HomeLandingCubit>().invitationStatus ==
                        InvitationStatus.landing;
                    context.router.push(FindGroupRoute());
                  },

                  height: 52,
                ),
              ),
            ],
          ),
          const CustomSizedBox(height: 20),
        ],
      ),
    );
  }
}
