import 'dart:ui';
import 'package:auto_route/auto_route.dart';
import 'package:fennac_app/app/constants/media_query_constants.dart';
import 'package:fennac_app/app/theme/app_colors.dart';
import 'package:fennac_app/core/di_container.dart';
import 'package:fennac_app/generated/assets.gen.dart';
import 'package:fennac_app/helpers/gradient_toast.dart';
import 'package:fennac_app/pages/auth/presentation/bloc/cubit/auth_cubit.dart';
import 'package:fennac_app/pages/auth/presentation/bloc/cubit/create_account_cubit.dart';
import 'package:fennac_app/pages/auth/presentation/bloc/state/auth_state.dart';
import 'package:fennac_app/pages/auth/presentation/bloc/state/create_account_state.dart';
import 'package:fennac_app/pages/dashboard/presentation/bloc/cubit/dashboard_cubit.dart';
import 'package:fennac_app/pages/profile/presentation/bloc/cubit/profile_cubit.dart';
import 'package:fennac_app/pages/profile/presentation/bloc/state/profile_state.dart';
import 'package:fennac_app/reusable_widgets/animated_background_container.dart';
import 'package:fennac_app/routes/routes_imports.gr.dart';

import 'package:fennac_app/widgets/custom_back_button.dart';
import 'package:fennac_app/widgets/custom_bottom_sheet.dart';
import 'package:fennac_app/widgets/custom_elevated_button.dart';
import 'package:fennac_app/widgets/custom_otp_field.dart';
import 'package:fennac_app/widgets/custom_sized_box.dart';
import 'package:fennac_app/widgets/custom_text.dart';
import 'package:fennac_app/widgets/movable_background.dart';
import 'package:flutter/material.dart';
import 'package:fennac_app/widgets/app_inkwell.dart';
import 'package:fennac_app/app/theme/text_styles.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

import '../../../../utils/validators.dart';

@RoutePage()
class VerifyPhoneNumberScreen extends StatefulWidget {
  final bool? isFromProfile;
  const VerifyPhoneNumberScreen({super.key, this.isFromProfile = false});

  @override
  State<VerifyPhoneNumberScreen> createState() =>
      _VerifyPhoneNumberScreenState();
}

class _VerifyPhoneNumberScreenState extends State<VerifyPhoneNumberScreen> {
  final _otpController = TextEditingController();
  late AuthCubit _authCubit;
  final ValueNotifier<bool> _isOtpBlurred = ValueNotifier<bool>(false);
  final CreateAccountCubit _createAccountCubit = Di().sl<CreateAccountCubit>();
  final ProfileCubit _profileCubit = Di().sl<ProfileCubit>();

  @override
  void initState() {
    super.initState();
    _authCubit = Di().sl<AuthCubit>();
    _authCubit.startOtpTimer();
  }

  @override
  void dispose() {
    _otpController.dispose();
    _authCubit.disposeOtpTimer();
    _isOtpBlurred.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          MovableBackground(
            backgroundType: MovableBackgroundType.medium,
            child: SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CustomSizedBox(height: 20),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: CustomBackButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ),
                      CustomSizedBox(height: 40),
                      AnimatedBackgroundContainer(
                        icon: Assets.icons.vector.path,
                      ),
                      CustomSizedBox(height: 40),
                      AppText(
                        text: 'Verify your phone number',
                        style: AppTextStyles.h3(context).copyWith(
                          fontWeight: FontWeight.w600,
                          color: isLightTheme(context)
                              ? Colors.black
                              : Colors.white,
                          wordSpacing: 1.5,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      CustomSizedBox(height: 12),
                      AppText(
                        text:
                            "We've sent you a 6-digit code, enter it below to verify your account.",
                        style: AppTextStyles.subHeading(context).copyWith(
                          color: isLightTheme(context)
                              ? Colors.black
                              : Colors.white60,
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      CustomSizedBox(height: 40),
                      BlocBuilder<AuthCubit, AuthState>(
                        bloc: _authCubit,
                        builder: (context, state) {
                          return Column(
                            children: [
                              CustomOtpField(
                                controller: _otpController,
                                length: 6,
                                color: _authCubit.otpErrorMessage != null
                                    ? Colors.red
                                    : null,
                                onCompleted: (otp) {
                                  // Auto-verify when completed (optional)
                                },
                              ),
                              if (_authCubit.otpErrorMessage != null) ...[
                                CustomSizedBox(height: 12),
                                AppText(
                                  text: _authCubit.otpErrorMessage!,
                                  style: AppTextStyles.bodyRegular(context)
                                      .copyWith(
                                        color: Colors.red,
                                        fontWeight: FontWeight.w500,
                                      ),
                                ),
                              ],
                            ],
                          );
                        },
                      ),
                      CustomSizedBox(height: 40),
                      BlocListener<CreateAccountCubit, CreateAccountState>(
                        bloc: _createAccountCubit,
                        listener: (context, state) {
                          if (state is CreateAccountLoaded &&
                              _createAccountCubit.isOtpVerify) {
                            if (!mounted) return;

                            CustomBottomSheet.show(
                              context: context,
                              barrierColor: Colors.transparent,
                              title: 'Phone Number Verified',
                              description:
                                  "Your phone number has been verified. Continue to complete your profile.",
                              buttonText: 'Continue',
                              icon: AnimatedBackgroundContainer(
                                icon: Assets.icons.checkGreen.path,
                                isPng: true,
                              ),
                              onButtonPressed: () {
                                if (!mounted) return;

                                _isOtpBlurred.value = false;

                                Navigator.of(
                                  context,
                                  rootNavigator: true,
                                ).pop();

                                if (widget.isFromProfile == true) {
                                  AutoRouter.of(
                                    context,
                                  ).replace(DashboardRoute());
                                  Di().sl<DashboardCubit>().changeIndex(2);
                                } else {
                                  AutoRouter.of(context).replace(KycRoute());
                                }
                              },
                            );
                          }

                          if (state is CreateAccountError) {
                            if (!mounted) return;
                            VxToast.show(message: state.message);
                          }
                        },
                        child: BlocBuilder<ProfileCubit, ProfileState>(
                          bloc: _profileCubit,
                          builder: (context, profileState) {
                            return BlocBuilder<
                              CreateAccountCubit,
                              CreateAccountState
                            >(
                              bloc: _createAccountCubit,
                              builder: (context, accountState) {
                                final isLoading = widget.isFromProfile == true
                                    ? (profileState is ProfileLoading)
                                    : (accountState is CreateAccountLoading &&
                                          _createAccountCubit.isOtpVerify);

                                return CustomElevatedButton(
                                  icon: isLoading
                                      ? SizedBox(
                                          width: 20,
                                          height: 20,
                                          child: Lottie.asset(
                                            Assets.animations.loadingSpinner,
                                            fit: BoxFit.cover,
                                          ),
                                        )
                                      : null,
                                  text: isLoading ? '' : 'Verify',
                                  width: double.infinity,
                                  onTap: () async {
                                    if (isLoading) return;
                                    if (_otpController.text.isNotEmpty &&
                                        _otpController.text.length == 6) {
                                      // Use different verification based on context
                                      if (widget.isFromProfile == true) {
                                        // Email/Phone change flow
                                        final success = await _profileCubit
                                            .verifyEmailOrPhoneOtp(
                                              requestId:
                                                  _profileCubit
                                                      .changeContactRequestId ??
                                                  '',
                                              verificationCode:
                                                  _otpController.text,
                                            );

                                        if (success && mounted) {
                                          _isOtpBlurred.value = true;
                                          CustomBottomSheet.show(
                                            context: context,
                                            barrierColor: Colors.transparent,
                                            title: 'Verified Successfully',
                                            description:
                                                "Your contact has been verified successfully.",
                                            buttonText: 'Continue',
                                            icon: AnimatedBackgroundContainer(
                                              icon:
                                                  Assets.icons.checkGreen.path,
                                              isPng: true,
                                            ),
                                            onButtonPressed: () {
                                              if (!mounted) return;
                                              _isOtpBlurred.value = false;
                                              Navigator.of(
                                                context,
                                                rootNavigator: true,
                                              ).pop();
                                              AutoRouter.of(
                                                context,
                                              ).replace(DashboardRoute());
                                              Di()
                                                  .sl<DashboardCubit>()
                                                  .changeIndex(2);
                                            },
                                          );
                                        }
                                      } else {
                                        // Phone verification flow
                                        await _createAccountCubit.verifyOtpCode(
                                          _otpController.text,
                                          normalizePhone(
                                            _authCubit.phoneController.text,
                                          ),
                                          () {
                                            _isOtpBlurred.value = true;

                                            CustomBottomSheet.show(
                                              context: context,
                                              barrierColor: Colors.transparent,
                                              title: 'Phone Number Verified',
                                              description:
                                                  "Your phone number has been verified. Continue to complete your profile.",
                                              buttonText: 'Continue',
                                              icon: AnimatedBackgroundContainer(
                                                icon: Assets
                                                    .icons
                                                    .checkGreen
                                                    .path,
                                                isPng: true,
                                              ),
                                              onButtonPressed: () {
                                                if (!mounted) return;

                                                _isOtpBlurred.value = false;

                                                Navigator.of(
                                                  context,
                                                  rootNavigator: true,
                                                ).pop();

                                                AutoRouter.of(
                                                  context,
                                                ).replace(KycRoute());
                                              },
                                            );
                                          },
                                        );
                                      }
                                    } else if (_otpController.text.length < 6) {
                                      VxToast.show(
                                        message:
                                            'Please enter a valid OTP code',
                                      );
                                    } else {
                                      VxToast.show(
                                        message: 'Please enter OTP code',
                                      );
                                    }
                                  },
                                );
                              },
                            );
                          },
                        ),
                      ),
                      CustomSizedBox(height: 24),
                      BlocBuilder<AuthCubit, AuthState>(
                        bloc: _authCubit,
                        builder: (context, state) {
                          return Container(
                            height: 50,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 12,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: isLightTheme(context)
                                  ? ColorPalette.textGrey
                                  : Colors.black26,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                AppText(
                                  text: "Didn't get the code?",
                                  style: AppTextStyles.bodyLarge(
                                    context,
                                  ).copyWith(fontWeight: FontWeight.w500),
                                ),
                                BlocBuilder<
                                  CreateAccountCubit,
                                  CreateAccountState
                                >(
                                  bloc: _createAccountCubit,
                                  builder: (context, state) {
                                    final isLoading =
                                        state is CreateAccountLoading &&
                                        _createAccountCubit.isLoading;
                                    return AppInkWell(
                                      onTap: () {
                                        final email = _authCubit
                                            .emailController
                                            .text
                                            .trim();
                                        final phone = _authCubit
                                            .phoneController
                                            .text
                                            .trim();
                                        if (_authCubit.canResendOtp) {
                                          _createAccountCubit
                                              .resetVerificationCode(
                                                method: 'email',
                                                email: email.isNotEmpty
                                                    ? email
                                                    : null,
                                                phone:
                                                    email.isEmpty &&
                                                        phone.isNotEmpty
                                                    ? phone
                                                    : null,
                                                context: context,
                                              );
                                        }
                                      },

                                      child: isLoading
                                          ? const SizedBox(
                                              width: 18,
                                              height: 18,
                                              child: CircularProgressIndicator(
                                                color: Colors.white,
                                                strokeWidth: 2,
                                              ),
                                            )
                                          : AppText(
                                              text: _authCubit.canResendOtp
                                                  ? 'Resend'
                                                  : _authCubit.formatOtpTime(
                                                      _authCubit
                                                          .remainingSeconds,
                                                    ),
                                              style:
                                                  AppTextStyles.bodyLarge(
                                                    context,
                                                  ).copyWith(
                                                    color:
                                                        _authCubit.canResendOtp
                                                        ? Colors.black
                                                        : Colors.black
                                                              .withValues(
                                                                alpha: 0.7,
                                                              ),
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                            ),
                                    );
                                  },
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          ValueListenableBuilder<bool>(
            valueListenable: _isOtpBlurred,
            builder: (context, isBlurred, _) {
              if (!isBlurred) {
                return const SizedBox.shrink();
              }
              return Positioned.fill(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                  child: Container(color: Colors.black.withValues(alpha: 0.1)),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
