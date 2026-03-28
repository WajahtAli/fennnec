import 'package:fennac_app/app/constants/media_query_constants.dart';
import 'package:fennac_app/app/theme/app_colors.dart';
import 'package:fennac_app/app/theme/text_styles.dart';
import 'package:fennac_app/core/di_container.dart';
import 'package:fennac_app/generated/assets.gen.dart';
import 'package:fennac_app/pages/homelanding/presentation/bloc/cubit/home_landing_cubit.dart';
import 'package:fennac_app/pages/homelanding/presentation/bloc/state/home_landing_state.dart';
import 'package:fennac_app/widgets/custom_elevated_button.dart';
import 'package:fennac_app/widgets/custom_outlined_button.dart';
import 'package:fennac_app/widgets/custom_sized_box.dart';
import 'package:fennac_app/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

class PendingWidget extends StatefulWidget {
  const PendingWidget({super.key});

  @override
  State<PendingWidget> createState() => _PendingWidgetState();
}

class _PendingWidgetState extends State<PendingWidget> {
  late HomeLandingCubit _homeLandingCubit;

  @override
  void initState() {
    super.initState();
    _homeLandingCubit = Di().sl<HomeLandingCubit>();
  }

  void _handleAcceptDecline(String type) {
    final invitations = _homeLandingCubit.invitations;
    if (invitations.isEmpty || invitations[0].group?.id == null) {
      return;
    }

    final groupId = invitations[0].group!.id!;

    _homeLandingCubit.acceptDeclineGroupInvitation(
      groupId: groupId,
      type: type,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeLandingCubit, HomeLandingState>(
      bloc: _homeLandingCubit,
      builder: (context, state) {
        final isAcceptLoading =
            _homeLandingCubit.isLoading &&
            _homeLandingCubit.activeInvitationAction == 'accept';
        final isDeclineLoading =
            _homeLandingCubit.isLoading &&
            _homeLandingCubit.activeInvitationAction == 'decline';

        return Stack(
          children: [
            Column(
              children: [
                // Invitation Title
                AppText(
                  text: "You've Been Invited!",
                  style: AppTextStyles.h2(context),
                  textAlign: TextAlign.center,
                ),
                const CustomSizedBox(height: 16),
                // Invitation Description
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: AppText(
                    text:
                        'Your friends want you to be part of their circle. Join and start exploring together.',
                    style: AppTextStyles.subHeading(context).copyWith(
                      color: isDarkTheme(context)
                          ? ColorPalette.textSecondary
                          : ColorPalette.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const CustomSizedBox(height: 40),
                // Action Buttons
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    children: [
                      CustomElevatedButton(
                        icon: isAcceptLoading
                            ? SizedBox(
                                width: 16,
                                height: 16,
                                child: Lottie.asset(
                                  Assets.animations.loadingSpinner,
                                ),
                              )
                            : const SizedBox.shrink(),
                        text: isAcceptLoading ? '' : 'Join Group',
                        onTap: _homeLandingCubit.isLoading
                            ? () {}
                            : () => _handleAcceptDecline('accept'),
                      ),
                      const CustomSizedBox(height: 16),
                      CustomOutlinedButton(
                        icon: isDeclineLoading
                            ? SizedBox(
                                width: 16,
                                height: 16,
                                child: Lottie.asset(
                                  Assets.animations.loadingSpinner,
                                ),
                              )
                            : const SizedBox.shrink(),
                        text: isDeclineLoading ? '' : 'Decline',
                        onPressed: _homeLandingCubit.isLoading
                            ? () {}
                            : () => _handleAcceptDecline('decline'),
                        height: 52,
                      ),
                      const CustomSizedBox(height: 20),
                    ],
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
