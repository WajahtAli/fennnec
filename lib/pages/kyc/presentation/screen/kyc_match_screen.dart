import 'dart:ui';

import 'package:auto_route/auto_route.dart';
import 'package:fennac_app/app/constants/media_query_constants.dart';
import 'package:fennac_app/app/theme/app_colors.dart';
import 'package:fennac_app/app/theme/text_styles.dart';
import 'package:fennac_app/core/di_container.dart';
import 'package:fennac_app/helpers/gradient_toast.dart';
import 'package:fennac_app/pages/auth/presentation/bloc/cubit/create_account_cubit.dart';
import 'package:fennac_app/pages/auth/presentation/bloc/state/create_account_state.dart';
import 'package:fennac_app/pages/kyc/presentation/bloc/cubit/kyc_cubit.dart';
import 'package:fennac_app/pages/kyc/presentation/bloc/state/kyc_state.dart';
import 'package:fennac_app/pages/kyc/presentation/widgets/continue_button.dart';
import 'package:fennac_app/pages/kyc/presentation/widgets/interest_selection_widget.dart';
import 'package:fennac_app/routes/routes_imports.gr.dart';
import 'package:fennac_app/widgets/custom_back_button.dart';
import 'package:fennac_app/widgets/custom_outlined_button.dart';
import 'package:fennac_app/widgets/custom_sized_box.dart';
import 'package:fennac_app/widgets/custom_text.dart';
import 'package:fennac_app/widgets/movable_background.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/cubit/kyc_prompt_cubit.dart';

@RoutePage()
class KycMatchScreen extends StatelessWidget {
  const KycMatchScreen({super.key});

  KycCubit get _kycCubit => Di().sl<KycCubit>();
  CreateAccountCubit get _createAccountCubit => Di().sl<CreateAccountCubit>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: isLightTheme(context)
          ? Colors.white
          : Colors.transparent,
      body: MovableBackground(
        backgroundType: MovableBackgroundType.medium,
        child: SafeArea(
          child: BlocBuilder<KycCubit, KycState>(
            bloc: _kycCubit,
            builder: (context, state) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    CustomSizedBox(height: 20),
                    CustomBackButton(),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomSizedBox(height: 32),
                          AppText(
                            text:
                                'Choose what you love so we can match your vibe.',
                            style: AppTextStyles.h4(context).copyWith(
                              color: isLightTheme(context)
                                  ? Colors.black
                                  : Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          CustomSizedBox(height: 32),
                          AppText(
                            text:
                                'You can select up to 3 options in each category.',
                            style: AppTextStyles.body(context).copyWith(
                              color: isLightTheme(context)
                                  ? Colors.black.withValues(alpha: 0.7)
                                  : Colors.white.withValues(alpha: 0.7),
                              fontSize: 14,
                            ),
                          ),
                          CustomSizedBox(height: 32),

                          InterestSelectionWidget(),
                          CustomSizedBox(height: 12),
                          if (_kycCubit.selectedInterests.length < 7)
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 4,
                                bottom: 12,
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.info_outline,
                                    color: ColorPalette.error,
                                    size: 16,
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: AppText(
                                      text:
                                          'Please select at least 7 vibes overall (${_kycCubit.selectedInterests.length}/7)',
                                      style: AppTextStyles.bodyRegular(context)
                                          .copyWith(
                                            color: ColorPalette.error,
                                            fontSize: 12,
                                          ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          CustomSizedBox(height: 40),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: BlocBuilder<CreateAccountCubit, CreateAccountState>(
              bloc: _createAccountCubit,

              builder: (context, state) {
                return Row(
                  children: [
                    Expanded(
                      child: CustomOutlinedButton(
                        onPressed: () {
                          Di().sl<KycPromptCubit>().resetAllData();

                          AutoRouter.of(
                            context,
                          ).push(KycPromptRoute(showSkipButton: true));
                        },
                        text: 'Skip',
                        width: double.infinity,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: ContinueButton(
                        isLoading: state is CreateAccountLoading,
                        onTap: () async {
                          if (_kycCubit.selectedInterests.length < 7) {
                            VxToast.show(
                              message: "Please select at least 7 vibes overall",
                            );
                            return;
                          }
                          await _createAccountCubit.updateProfile();
                          if (context.mounted && state is! CreateAccountError) {
                            Di().sl<KycPromptCubit>().resetAllData();

                            AutoRouter.of(
                              context,
                            ).push(KycPromptRoute(showSkipButton: true));
                          }
                        },
                        text: 'Continue',
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
