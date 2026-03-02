import 'dart:ui';
import 'package:auto_route/auto_route.dart';
import 'package:fennac_app/core/di_container.dart';
import 'package:fennac_app/generated/assets.gen.dart';
import 'package:fennac_app/pages/create_group/presentation/bloc/cubit/create_group_cubit.dart';
import 'package:fennac_app/pages/dashboard/presentation/bloc/cubit/dashboard_cubit.dart';
import 'package:fennac_app/pages/home/presentation/screen/home_screen.dart';
import 'package:fennac_app/pages/kyc/presentation/widgets/continue_button.dart';
import 'package:fennac_app/reusable_widgets/animated_background_container.dart';
import 'package:fennac_app/routes/routes_imports.gr.dart';
import 'package:fennac_app/widgets/custom_bottom_sheet.dart';
import 'package:fennac_app/widgets/custom_outlined_button.dart';
import 'package:flutter/material.dart';

class KycPromptActions extends StatelessWidget {
  final bool showSkipButton;
  final bool isEditMode;
  final CreateGroupCubit createGroupCubit;
  final ValueNotifier<bool> backgroundBlurNotifier;

  const KycPromptActions({
    super.key,
    required this.showSkipButton,
    required this.isEditMode,
    required this.createGroupCubit,
    required this.backgroundBlurNotifier,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Row(
            children: [
              if (showSkipButton && !isEditMode) ...[
                Expanded(
                  child: CustomOutlinedButton(
                    onPressed: () {
                      AutoRouter.of(context).push(const DashboardRoute());
                    },
                    text: 'Skip',
                  ),
                ),
                const SizedBox(width: 16),
              ],
              Expanded(
                child: ContinueButton(
                  onTap: () {
                    if (showSkipButton) {
                      AutoRouter.of(context).push(const DashboardRoute());
                    } else if (isEditMode) {
                      AutoRouter.of(context).pop();
                    } else {
                      // createGroupCubit.executeCreateGroup(context);
                      CustomBottomSheet.show(
                        icon: AnimatedBackgroundContainer(
                          isPng: true,
                          icon: Assets.icons.checkGreen.path,
                        ),
                        context: context,
                        title: 'Group Created Successfully!',
                        description:
                            'You are all set - time to explore and connect.',
                        buttonText: 'Start Exploring',
                        onButtonPressed: () {
                          AutoRouter.of(context).push(const DashboardRoute());

                          Di().sl<DashboardCubit>().changePage(0, HomeScreen());
                        },
                        secondaryButtonText: 'Share QR Code',
                        onSecondaryButtonPressed: () {
                          AutoRouter.of(context).push(const DashboardRoute());

                          Di().sl<DashboardCubit>().changePage(0, HomeScreen());
                        },
                        blurNotifier: backgroundBlurNotifier,
                      );
                    }
                  },
                  text: isEditMode ? 'Done' : 'Continue',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
