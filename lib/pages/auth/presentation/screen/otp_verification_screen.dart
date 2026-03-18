import 'dart:developer';
import 'dart:ui';

import 'package:auto_route/auto_route.dart';
import 'package:fennac_app/app/constants/media_query_constants.dart';
import 'package:fennac_app/app/theme/app_colors.dart';
import 'package:fennac_app/core/di_container.dart';
import 'package:fennac_app/generated/assets.gen.dart';
import 'package:fennac_app/pages/auth/presentation/bloc/cubit/auth_cubit.dart';
import 'package:fennac_app/pages/auth/presentation/bloc/cubit/create_account_cubit.dart';
import 'package:fennac_app/pages/auth/presentation/bloc/cubit/login_cubit.dart';
import 'package:fennac_app/pages/auth/presentation/bloc/state/auth_state.dart';
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

import '../../../../helpers/gradient_toast.dart';
import '../bloc/state/login_state.dart';

@RoutePage()
class OtpVerificationScreen extends StatefulWidget {
  const OtpVerificationScreen({super.key});

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  final AuthCubit _authCubit = Di().sl<AuthCubit>();
  final LoginCubit _loginCubit = Di().sl<LoginCubit>();
  final ValueNotifier<bool> _isOtpBlurred = ValueNotifier<bool>(false);

  @override
  void initState() {
    super.initState();
    _authCubit.startOtpTimer();
  }

  @override
  void dispose() {
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
                        child: CustomBackButton(),
                      ),
                      AnimatedBackgroundContainer(
                        icon: Assets.icons.vector4.path,
                      ),
                      CustomSizedBox(height: 40),
                      AppText(
                        text: 'Verify your code',
                        style: AppTextStyles.h3(context).copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      CustomSizedBox(height: 12),
                      AppText(
                        text:
                            "We've sent you a 6-digit code, enter it below to verify your account.",
                        style: AppTextStyles.subHeading(context).copyWith(
                          color: isDarkTheme(context)
                              ? ColorPalette.textSecondary
                              : Colors.black,
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
                                controller: _loginCubit.otpController,
                                length: 6,
                                color: _authCubit.otpErrorMessage != null
                                    ? Colors.red
                                    : null,
                                onCompleted: (otp) {},
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
                      BlocListener<LoginCubit, LoginState>(
                        bloc: _loginCubit,
                        listener: (context, state) async {
                          if (state is LoginLoaded) {
                            _isOtpBlurred.value = true;

                            await CustomBottomSheet.show(
                              icon: AnimatedBackgroundContainer(
                                icon: Assets.icons.checkGreen.path,
                                isPng: true,
                              ),
                              context: context,
                              title: 'Account Verified',
                              description:
                                  'Your account has been verified. Continue to set new password.',
                              buttonText: 'Continue',
                              onButtonPressed: () {
                                _isOtpBlurred.value = false;
                                Navigator.pop(context);
                                AutoRouter.of(context).push(
                                  SetNewPasswordRoute(
                                    email: _authCubit.emailController.text,
                                    resetCode: _loginCubit.otpController.text,
                                  ),
                                );
                                log(
                                  'Navigating to SetNewPasswordRoute with email: ${_authCubit.emailController.text}',
                                );
                              },
                            );

                            if (mounted) _isOtpBlurred.value = false;
                          }

                          if (state is LoginError) {
                            VxToast.show(message: state.message);
                          }
                        },
                        child: BlocBuilder<LoginCubit, LoginState>(
                          bloc: _loginCubit,
                          builder: (context, loginState) {
                            return CustomElevatedButton(
                              width: double.infinity,
                              text: _loginCubit.isLoading
                                  ? ''
                                  : _authCubit.otpErrorMessage == null
                                  ? 'Verify'
                                  : 'Try Again',
                              icon: _loginCubit.isLoading
                                  ? SizedBox(
                                      width: 20,
                                      height: 20,
                                      child: Lottie.asset(
                                        Assets.animations.loadingSpinner,
                                        fit: BoxFit.cover,
                                      ),
                                    )
                                  : null,
                              onTap: () {
                                if (_loginCubit.otpController.text.isNotEmpty &&
                                    mounted) {
                                  _isOtpBlurred.value = true;

                                  _loginCubit.verifyResetCode(
                                    resetCode: _loginCubit.otpController.text,
                                    emailAddress:
                                        _authCubit.emailController.text,
                                  );
                                  _isOtpBlurred.value = false;
                                }
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
                              color: isDarkTheme(context)
                                  ? Colors.black26
                                  : ColorPalette.textGrey,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                AppText(
                                  text: 'Didn\'t get the code?',
                                  style: AppTextStyles.bodyLarge(context),
                                ),
                                AppInkWell(
                                  borderRadius: BorderRadius.circular(32),
                                  onTap: _authCubit.canResendOtp
                                      ? () async {
                                          final isEmail = _authCubit
                                              .emailController
                                              .text
                                              .trim()
                                              .isNotEmpty;
                                          await Di()
                                              .sl<CreateAccountCubit>()
                                              .resetVerificationCode(
                                                method: isEmail
                                                    ? 'email'
                                                    : 'phone',
                                                email: _authCubit
                                                    .emailController
                                                    .text
                                                    .trim(),
                                                phone: _authCubit
                                                    .phoneController
                                                    .text
                                                    .trim(),

                                                context: context,
                                              );
                                          // _authCubit.resendOtpCode();
                                        }
                                      : null,
                                  child: AppText(
                                    text: _authCubit.canResendOtp
                                        ? 'Resend'
                                        : _authCubit.formatOtpTime(
                                            _authCubit.remainingSeconds,
                                          ),
                                    style: AppTextStyles.bodyLarge(context)
                                        .copyWith(
                                          color: isLightTheme(context)
                                              ? Colors.black
                                              : Colors.white.withValues(
                                                  alpha: 0.5,
                                                ),
                                          fontWeight: FontWeight.w600,
                                        ),
                                  ),
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
