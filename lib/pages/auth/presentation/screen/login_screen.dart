import 'package:auto_route/auto_route.dart';
import 'package:fennac_app/app/constants/media_query_constants.dart';
import 'package:fennac_app/app/theme/app_colors.dart';
import 'package:fennac_app/core/di_container.dart';
import 'package:fennac_app/generated/assets.gen.dart';
import 'package:fennac_app/pages/auth/presentation/bloc/cubit/login_cubit.dart';
import 'package:fennac_app/routes/routes_imports.gr.dart';
import 'package:fennac_app/widgets/custom_back_button.dart';
import 'package:fennac_app/widgets/custom_text_field.dart';
import 'package:fennac_app/widgets/movable_background.dart';
import 'package:flutter/material.dart';
import 'package:fennac_app/widgets/custom_sized_box.dart';
import 'package:fennac_app/widgets/custom_text.dart';
import 'package:fennac_app/widgets/custom_elevated_button.dart';
import 'package:fennac_app/app/theme/text_styles.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';

import '../bloc/state/login_state.dart';

@RoutePage()
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  final _loginCubit = Di().sl<LoginCubit>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MovableBackground(
        backgroundType: MovableBackgroundType.light,
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: BlocBuilder(
                bloc: _loginCubit,
                builder: (context, state) {
                  return Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CustomSizedBox(height: 20),

                        CustomBackButton(),

                        SvgPicture.asset(
                          Assets.icons.logoAnimation.path,
                          width: 100,
                          height: 100,
                          color: ColorPalette.primary,
                        ),

                        CustomSizedBox(height: 30),

                        AppText(
                          text: 'Login to your account',
                          style: AppTextStyles.h2(
                            context,
                          ).copyWith(fontWeight: FontWeight.bold),
                        ),

                        CustomSizedBox(height: 40),

                        CustomLabelTextField(
                          label: 'Email',
                          controller: _loginCubit.email,
                          validator: _loginCubit.validateEmail,
                          keyboardType: TextInputType.emailAddress,
                          hintText: 'example@gmail.com',
                          filled: false,
                        ),

                        CustomSizedBox(height: 24),

                        CustomLabelTextField(
                          label: 'Password',
                          controller: _loginCubit.password,
                          validator: _loginCubit.validatePassword,
                          obscureText: _loginCubit.obscurePassword,
                          hintText: 'Enter your password',
                          filled: false,
                          suffixIcon: IconButton(
                            onPressed: () {
                              _loginCubit.togglePasswordVisibility();
                            },
                            icon: Icon(
                              _loginCubit.obscurePassword
                                  ? Icons.visibility_outlined
                                  : Icons.visibility_off_outlined,
                              color: isLightTheme(context)
                                  ? Colors.black
                                  : Colors.white70,
                            ),
                          ),
                        ),
                        CustomSizedBox(height: 16),
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {
                              AutoRouter.of(
                                context,
                              ).push(const ResetPasswordRoute());
                            },
                            child: AppText(
                              text: 'Forgot Password?',
                              style: AppTextStyles.inputLabel(
                                context,
                              ).copyWith(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),

                        CustomSizedBox(height: 20),

                        BlocBuilder<LoginCubit, LoginState>(
                          bloc: _loginCubit,
                          builder: (context, state) {
                            final isLoading = state is LoginLoading;

                            return CustomElevatedButton(
                              isLoading: isLoading,
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
                              onTap: () {
                                if (_formKey.currentState!.validate()) {
                                  _loginCubit.login(context: context);
                                  // AutoRouter.of(
                                  //   context,
                                  // ).replaceAll([const DashboardRoute()]);
                                }
                              },
                              text: 'Login',
                              width: double.infinity,
                            );
                          },
                        ),
                        CustomSizedBox(height: 40),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
