import 'dart:ui';
import 'package:auto_route/auto_route.dart';
import 'package:fennac_app/app/constants/media_query_constants.dart';
import 'package:fennac_app/app/theme/app_colors.dart';
import 'package:fennac_app/app/theme/text_styles.dart';
import 'package:fennac_app/core/di_container.dart';
import 'package:fennac_app/generated/assets.gen.dart';
import 'package:fennac_app/pages/auth/presentation/bloc/cubit/auth_cubit.dart';
import 'package:fennac_app/pages/auth/presentation/bloc/state/auth_state.dart';
import 'package:fennac_app/reusable_widgets/animated_background_container.dart';
import 'package:fennac_app/reusable_widgets/custom_app_bar.dart';
import 'package:fennac_app/pages/profile/presentation/bloc/cubit/profile_cubit.dart';
import 'package:fennac_app/pages/profile/presentation/bloc/state/profile_state.dart';
import 'package:fennac_app/widgets/custom_bottom_sheet.dart';
import 'package:fennac_app/widgets/custom_elevated_button.dart';
import 'package:fennac_app/widgets/custom_text_field.dart';
import 'package:fennac_app/widgets/custom_sized_box.dart';
import 'package:fennac_app/widgets/custom_text.dart';
import 'package:fennac_app/widgets/movable_background.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

@RoutePage()
class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _authCubit = Di().sl<AuthCubit>();
  final _profileCubit = Di().sl<ProfileCubit>();
  late ValueNotifier<bool> _showBackdropFilter;

  @override
  void initState() {
    super.initState();
    _showBackdropFilter = ValueNotifier<bool>(false);
  }

  @override
  void dispose() {
    _showBackdropFilter.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1B2E),
      body: ValueListenableBuilder<bool>(
        valueListenable: _showBackdropFilter,
        builder: (context, showBackdrop, child) {
          return Stack(
            children: [
              MovableBackground(
                child: SafeArea(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: BlocBuilder<AuthCubit, AuthState>(
                        bloc: _authCubit,
                        builder: (context, state) {
                          return Form(
                            key: _formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                CustomAppBar(title: 'Change Password'),

                                CustomSizedBox(height: 40),
                                CustomLabelTextField(
                                  label: 'Current Password',
                                  hintText: 'Enter your current password',
                                  controller:
                                      _authCubit.currentPasswordController,
                                  validator: (value) {
                                    final error = _authCubit
                                        .getCurrentPasswordError();
                                    return error;
                                  },
                                  obscureText:
                                      _authCubit.obscureCurrentPassword,
                                  onChanged: (value) {
                                    _authCubit.onCurrentPasswordChanged(value);
                                  },
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      _authCubit.obscureCurrentPassword
                                          ? Icons.visibility_outlined
                                          : Icons.visibility_off_outlined,
                                      color: isLightTheme(context)
                                          ? Colors.black
                                          : Colors.white,
                                    ),
                                    onPressed: () {
                                      _authCubit
                                          .toggleCurrentPasswordVisibility();
                                    },
                                  ),
                                  labelColor:
                                      _authCubit.getCurrentPasswordError() !=
                                          null
                                      ? ColorPalette.error
                                      : isLightTheme(context)
                                      ? Colors.black
                                      : Colors.white,
                                  filled: false,
                                ),
                                const CustomSizedBox(height: 24),
                                // New Password Field
                                CustomLabelTextField(
                                  label: 'New Password',
                                  hintText: 'Enter your new password',
                                  controller: _authCubit.newPasswordController,
                                  validator: (value) {
                                    final error = _authCubit
                                        .getNewPasswordError();
                                    return error;
                                  },
                                  obscureText: _authCubit.obscureNewPassword,
                                  onChanged: (value) {
                                    _authCubit.onNewPasswordChanged(value);
                                  },
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      _authCubit.obscureNewPassword
                                          ? Icons.visibility_outlined
                                          : Icons.visibility_off_outlined,
                                      color: isLightTheme(context)
                                          ? Colors.black
                                          : Colors.white,
                                    ),
                                    onPressed: () {
                                      _authCubit.toggleNewPasswordVisibility();
                                    },
                                  ),
                                  labelColor:
                                      _authCubit.getNewPasswordError() != null
                                      ? ColorPalette.error
                                      : isLightTheme(context)
                                      ? Colors.black
                                      : Colors.white,
                                  filled: false,
                                ),
                                if (_authCubit.getNewPasswordError() != null)
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      top: 8,
                                      left: 4,
                                    ),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.info_outline,
                                          color: ColorPalette.error,
                                          size: 16,
                                        ),
                                        const SizedBox(width: 4),
                                        Expanded(
                                          child: AppText(
                                            text: _authCubit
                                                .getNewPasswordError()!,
                                            style:
                                                AppTextStyles.bodyRegular(
                                                  context,
                                                ).copyWith(
                                                  color: ColorPalette.error,
                                                  fontSize: 12,
                                                ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                CustomSizedBox(height: 24),
                                // Confirm New Password Field
                                CustomLabelTextField(
                                  label: 'Confirm New Password',
                                  hintText: 'Re-enter your new password',
                                  controller:
                                      _authCubit.confirmNewPasswordController,
                                  validator: (value) {
                                    final error = _authCubit
                                        .getConfirmNewPasswordError();
                                    return error;
                                  },
                                  obscureText:
                                      _authCubit.obscureConfirmNewPassword,
                                  onChanged: (value) {
                                    _authCubit.onConfirmNewPasswordChanged(
                                      value,
                                    );
                                  },
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      _authCubit.obscureConfirmNewPassword
                                          ? Icons.visibility_outlined
                                          : Icons.visibility_off_outlined,
                                      color: isLightTheme(context)
                                          ? Colors.black
                                          : Colors.white,
                                    ),
                                    onPressed: () {
                                      _authCubit
                                          .toggleConfirmNewPasswordVisibility();
                                    },
                                  ),
                                  labelColor:
                                      _authCubit.getConfirmNewPasswordError() !=
                                          null
                                      ? ColorPalette.error
                                      : isLightTheme(context)
                                      ? Colors.black
                                      : Colors.white,
                                  filled: false,
                                ),
                                if (_authCubit.getConfirmNewPasswordError() !=
                                    null)
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      top: 8,
                                      left: 4,
                                    ),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.info_outline,
                                          color: ColorPalette.error,
                                          size: 16,
                                        ),
                                        const SizedBox(width: 4),
                                        Expanded(
                                          child: AppText(
                                            text: _authCubit
                                                .getConfirmNewPasswordError()!,
                                            style:
                                                AppTextStyles.bodyRegular(
                                                  context,
                                                ).copyWith(
                                                  color: ColorPalette.error,
                                                  fontSize: 12,
                                                ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                CustomSizedBox(height: 40),
                                BlocBuilder<ProfileCubit, ProfileState>(
                                  bloc: _profileCubit,
                                  builder: (context, state) {
                                    return CustomElevatedButton(
                                      onTap: () async {
                                        if (_profileCubit.isSubmitting) {
                                          return;
                                        }
                                        if (_formKey.currentState?.validate() ??
                                            false) {
                                          final success = await _profileCubit
                                              .changePassword(
                                                currentPassword: _authCubit
                                                    .currentPasswordController
                                                    .text,
                                                newPassword: _authCubit
                                                    .newPasswordController
                                                    .text,
                                                context: context,
                                              );
                                          if (!mounted || !success) return;

                                          _showBackdropFilter.value = true;
                                          CustomBottomSheet.show(
                                            context: context,
                                            icon: AnimatedBackgroundContainer(
                                              icon:
                                                  Assets.icons.checkGreen.path,
                                              isPng: true,
                                            ),
                                            title: 'Password Updated',
                                            buttonText: 'Done',
                                          ).then((_) {
                                            _showBackdropFilter.value = false;
                                          });
                                        } else {
                                          _authCubit.submitNewPassword();
                                        }
                                      },
                                      text: _profileCubit.isSubmitting
                                          ? ''
                                          : 'Update Password',
                                      icon: _profileCubit.isSubmitting
                                          ? SizedBox(
                                              width: 18,
                                              height: 18,
                                              child: Lottie.asset(
                                                Assets
                                                    .animations
                                                    .loadingSpinner,
                                              ),
                                            )
                                          : null,
                                      isLoading: _profileCubit.isSubmitting,
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
              // Backdrop filter overlay
              if (showBackdrop)
                BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
                  child: Container(color: Colors.black.withValues(alpha: 0.3)),
                ),
            ],
          );
        },
      ),
    );
  }
}
