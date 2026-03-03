import 'dart:ui';
import 'package:auto_route/auto_route.dart';
import 'package:fennac_app/app/constants/media_query_constants.dart';
import 'package:fennac_app/app/theme/app_colors.dart';
import 'package:fennac_app/core/di_container.dart';
import 'package:fennac_app/generated/assets.gen.dart';
import 'package:fennac_app/pages/auth/presentation/bloc/cubit/auth_cubit.dart';
import 'package:fennac_app/pages/auth/presentation/bloc/cubit/login_cubit.dart';
import 'package:fennac_app/pages/auth/presentation/bloc/state/login_state.dart';
import 'package:fennac_app/reusable_widgets/animated_background_container.dart';
import 'package:fennac_app/widgets/custom_back_button.dart';
import 'package:fennac_app/widgets/custom_country_field.dart';
import 'package:fennac_app/widgets/custom_text_field.dart';
import 'package:fennac_app/widgets/movable_background.dart';
import 'package:flutter/material.dart';
import 'package:fennac_app/widgets/custom_sized_box.dart';
import 'package:fennac_app/widgets/custom_text.dart';
import 'package:fennac_app/widgets/custom_elevated_button.dart';
import 'package:fennac_app/app/theme/text_styles.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

import '../../../../routes/routes_imports.gr.dart';
import '../../../../widgets/custom_bottom_sheet.dart';

@RoutePage()
class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  bool _isBackgroundBlurred = false;

  final _authCubit = Di().sl<AuthCubit>();

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
                  child: BlocBuilder(
                    bloc: _authCubit,
                    builder: (context, state) {
                      return Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CustomSizedBox(height: 20),

                            CustomBackButton(),

                            AnimatedBackgroundContainer(
                              icon: Assets.icons.vector3.path,
                            ),

                            CustomSizedBox(height: 40),

                            AppText(
                              text: 'Reset your password',
                              style: AppTextStyles.h2(
                                context,
                              ).copyWith(fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                            CustomSizedBox(height: 12),

                            AppText(
                              text:
                                  "Enter your email and we’ll send you a code to reset your password.",
                              style: AppTextStyles.subHeading(
                                context,
                              ).copyWith(fontWeight: FontWeight.w500),
                              textAlign: TextAlign.center,
                            ),
                            CustomSizedBox(height: 40),
                            if (_authCubit.isEmail)
                              CustomLabelTextField(
                                label: _authCubit.isEmail
                                    ? 'Email'
                                    : 'Phone Number',
                                controller: _emailController,
                                validator: _authCubit.validateEmail,
                                keyboardType: TextInputType.emailAddress,
                                hintText: 'example@gmail.com',
                                labelColor: Colors.white,
                                filled: false,
                              ),
                            if (!_authCubit.isEmail)
                              PhoneNumberField(
                                label: 'Country',
                                hintText: 'Select your country',

                                onChanged: (country) {},
                              ),

                            CustomSizedBox(height: 30),

                            BlocListener(
                              bloc: Di().sl<LoginCubit>(),
                              listener: (context, state) {
                                if (state is PasswordResetSuccessState) {
                                  setState(() {
                                    _isBackgroundBlurred = true;
                                  });

                                  CustomBottomSheet.show(
                                    context: context,
                                    barrierColor: Colors.transparent,
                                    title: 'Reset code sent!',
                                    description:
                                        "We've sent a 6-digit code to you. Continue to reset your password.",
                                    buttonText: 'Continue',
                                    onButtonPressed: () {
                                      // Only clear the local form field, NOT the authCubit email
                                      // because we need it for OTP and password reset screens
                                      _emailController.clear();

                                      AutoRouter.of(context).pop();
                                      AutoRouter.of(
                                        context,
                                      ).push(const OtpVerificationRoute());
                                      setState(() {
                                        _isBackgroundBlurred = false;
                                      });
                                    },
                                    icon: AnimatedBackgroundContainer(
                                      icon: Assets.icons.checkGreen.path,
                                      isPng: true,
                                    ),
                                  );
                                }
                              },
                              child: BlocBuilder(
                                bloc: Di().sl<LoginCubit>(),
                                builder: (context, state) {
                                  return CustomElevatedButton(
                                    icon: Di().sl<LoginCubit>().isLoading
                                        ? SizedBox(
                                            width: 20,
                                            height: 20,
                                            child: Lottie.asset(
                                              Assets.animations.loadingSpinner,
                                              fit: BoxFit.cover,
                                            ),
                                          )
                                        : null,
                                    onTap: () async {
                                      if (_formKey.currentState!.validate()) {
                                        _authCubit.emailController.text =
                                            _emailController.text;
                                        await Di()
                                            .sl<LoginCubit>()
                                            .requestPasswordReset(
                                              _emailController.text,
                                            );
                                      }
                                    },
                                    text: Di().sl<LoginCubit>().isLoading
                                        ? ''
                                        : 'Send reset code',
                                    width: double.infinity,
                                  );
                                },
                              ),
                            ),
                            CustomSizedBox(height: 30),
                            Container(
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  AppText(
                                    text: 'Can’t access your email?',
                                    style: AppTextStyles.description(context),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      _authCubit.toggleEmailOrPhone();
                                    },
                                    child: AppText(
                                      text: _authCubit.isEmail
                                          ? 'Use Phone Number'
                                          : 'Use Email',
                                      style: AppTextStyles.body(
                                        context,
                                      ).copyWith(fontWeight: FontWeight.w600),
                                    ),
                                  ),
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
            ),
          ),
          if (_isBackgroundBlurred)
            Positioned.fill(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                child: Container(color: Colors.black.withValues(alpha: 0.1)),
              ),
            ),
        ],
      ),
    );
  }
}
