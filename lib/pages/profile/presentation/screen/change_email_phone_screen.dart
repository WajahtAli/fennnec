import 'package:auto_route/auto_route.dart';
import 'package:fennac_app/app/constants/media_query_constants.dart';
import 'package:fennac_app/app/theme/app_colors.dart';
import 'package:fennac_app/app/theme/text_styles.dart';
import 'package:fennac_app/core/di_container.dart';
import 'package:fennac_app/generated/assets.gen.dart';
import 'package:fennac_app/pages/auth/presentation/bloc/cubit/login_cubit.dart';
import 'package:fennac_app/pages/profile/presentation/bloc/cubit/profile_cubit.dart';
import 'package:fennac_app/pages/profile/presentation/bloc/state/profile_state.dart';
import 'package:fennac_app/reusable_widgets/custom_app_bar.dart';
import 'package:fennac_app/routes/routes_imports.gr.dart';
import 'package:fennac_app/widgets/custom_country_field.dart';
import 'package:fennac_app/widgets/custom_elevated_button.dart';
import 'package:fennac_app/widgets/custom_sized_box.dart';
import 'package:fennac_app/widgets/custom_text_field.dart';
import 'package:fennac_app/widgets/movable_background.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';

@RoutePage()
class ChangeEmailPhoneScreen extends StatefulWidget {
  const ChangeEmailPhoneScreen({super.key});

  @override
  State<ChangeEmailPhoneScreen> createState() => _ChangeEmailPhoneScreenState();
}

class _ChangeEmailPhoneScreenState extends State<ChangeEmailPhoneScreen> {
  final TextEditingController _emailController = TextEditingController();
  final ProfileCubit _profileCubit = Di().sl<ProfileCubit>();
  final LoginCubit _loginCubit = Di().sl<LoginCubit>();
  String? _phoneNumber;
  bool _isSubmitting = false;

  @override
  initState() {
    _emailController.text = _loginCubit.userData?.user?.email ?? '';
    _phoneNumber = _loginCubit.userData?.user?.phone ?? '';
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MovableBackground(
        child: SafeArea(
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () => FocusScope.of(context).unfocus(),
            child: LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  padding: EdgeInsets.only(
                    left: 20,
                    right: 20,
                    top: 8,
                    bottom: 24 + MediaQuery.viewInsetsOf(context).bottom,
                  ),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: constraints.maxHeight,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomAppBar(title: 'Change Email or Phone'),
                        const SizedBox(height: 32),
                        Text(
                          'Keep your contact info up to date.',
                          style: AppTextStyles.h3(context),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 32),

                        CustomLabelTextField(
                          label: 'Email',
                          hintText: 'johndoe123@email.com',
                          filled: false,
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                        ),

                        const SizedBox(height: 28),
                        Text(
                          'Phone Number',
                          style: AppTextStyles.bodySmall(
                            context,
                          ).copyWith(fontWeight: FontWeight.w600),
                        ),
                        const CustomSizedBox(height: 12),
                        PhoneNumberField(
                          initialValue: _phoneNumber,
                          onChanged: (completePhoneNumber) {
                            _phoneNumber = completePhoneNumber;
                          },
                        ),
                        const CustomSizedBox(height: 32),

                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: isDarkTheme(context)
                                ? Colors.black26
                                : ColorPalette.textGrey,
                          ),
                          child: ListTile(
                            contentPadding: EdgeInsets.zero,
                            leading: SvgPicture.asset(
                              Assets.icons.info.path,
                              width: 24,
                              height: 24,
                              color: isLightTheme(context)
                                  ? ColorPalette.black
                                  : ColorPalette.textSecondary,
                            ),
                            title: Text(
                              'We’ll send a verification code to confirm your new phone number.',
                              style: AppTextStyles.subHeading(context).copyWith(
                                color: isLightTheme(context)
                                    ? ColorPalette.black
                                    : ColorPalette.textSecondary,
                                fontSize: 13,
                              ),
                            ),
                          ),
                        ),
                        const CustomSizedBox(height: 48),
                        BlocBuilder<ProfileCubit, ProfileState>(
                          bloc: _profileCubit,
                          builder: (context, state) {
                            return CustomElevatedButton(
                              text: _profileCubit.isSubmitting
                                  ? ''
                                  : 'Send Verification Code',
                              isLoading: _isSubmitting,
                              icon: _profileCubit.isSubmitting
                                  ? SizedBox(
                                      height: 18,
                                      width: 18,
                                      child: Lottie.asset(
                                        Assets.animations.loadingSpinner,
                                        width: 18,
                                        height: 18,
                                      ),
                                    )
                                  : null,
                              onTap: () async {
                                final success = await _profileCubit
                                    .changeEmailOrPhone(
                                      email: _emailController.text,
                                      phone: _phoneNumber,
                                    );
                                if (!mounted) return;
                                setState(() => _isSubmitting = false);
                                if (success) {
                                  AutoRouter.of(context).push(
                                    VerifyPhoneNumberRoute(isFromProfile: true),
                                  );
                                }
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
