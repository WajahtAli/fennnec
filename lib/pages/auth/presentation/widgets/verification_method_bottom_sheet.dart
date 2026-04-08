import 'package:fennac_app/app/constants/media_query_constants.dart';
import 'package:fennac_app/app/theme/app_colors.dart';
import 'package:fennac_app/app/theme/text_styles.dart';
import 'package:fennac_app/core/di_container.dart';
import 'package:fennac_app/generated/assets.gen.dart';
import 'package:fennac_app/helpers/gradient_toast.dart';
import 'package:fennac_app/pages/auth/presentation/bloc/cubit/auth_cubit.dart';
import 'package:fennac_app/pages/auth/presentation/bloc/cubit/create_account_cubit.dart';
import 'package:fennac_app/widgets/app_inkwell.dart';
import 'package:fennac_app/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class VerificationMethodBottomSheet extends StatelessWidget {
  final BuildContext parentContext;
  final String? phone;
  final String? email;

  const VerificationMethodBottomSheet({
    super.key,
    required this.parentContext,
    this.phone,
    this.email,
  });

  static Future<void> show({
    required BuildContext context,
    String? phone,
    String? email,
    ValueNotifier<bool>? blurNotifier,
  }) async {
    blurNotifier?.value = true;
    try {
      await showModalBottomSheet<void>(
        context: context,
        backgroundColor: Colors.transparent,
        barrierColor: Colors.transparent,
        elevation: 0,
        clipBehavior: Clip.antiAlias,
        isScrollControlled: true,
        builder: (sheetContext) {
          return VerificationMethodBottomSheet(
            parentContext: context,
            phone: phone,
            email: email,
          );
        },
      );
    } finally {
      blurNotifier?.value = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isLight = isLightTheme(context);

    return Container(
      width: double.infinity,
      constraints: const BoxConstraints(maxWidth: 440, minHeight: 347),
      padding: const EdgeInsets.fromLTRB(24, 32, 24, 64),
      decoration: BoxDecoration(
        gradient: isDarkTheme(context)
            ? LinearGradient(
                colors: [ColorPalette.secondary, ColorPalette.black],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              )
            : null,
        color: isLight ? Colors.white : null,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(32),
          topRight: Radius.circular(32),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AppText(
            text: 'Choose Verification Method',
            style: AppTextStyles.h3(context).copyWith(
              fontWeight: FontWeight.w500,
              color: isLight ? ColorPalette.black : Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          AppText(
            text:
                'Please select how you would like to receive your verification code.',
            style: AppTextStyles.body(context).copyWith(
              color: isLight
                  ? ColorPalette.black.withValues(alpha: 0.75)
                  : Colors.white.withValues(alpha: 0.85),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 32),
          Row(
            children: [
              Expanded(
                child: _MethodCard(
                  icon: SvgPicture.asset(
                    Assets.icons.messageCircle.path,
                    width: 32,
                    height: 32,
                    colorFilter: ColorFilter.mode(
                      isLight ? ColorPalette.primary : Colors.white,
                      BlendMode.srcIn,
                    ),
                  ),
                  title: 'Phone Number',
                  subtitle: 'Get a code via SMS',
                  onTap: _onPhoneTap,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _MethodCard(
                  icon: Icon(
                    Icons.email_outlined,
                    size: 32,
                    color: isLight ? ColorPalette.primary : Colors.white,
                  ),
                  title: 'Email Address',
                  subtitle: 'Get a code via email',
                  onTap: _onEmailTap,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _onPhoneTap() {
    final phoneToUse = (phone ?? Di().sl<AuthCubit>().phoneController.text)
        .trim();

    if (phoneToUse.isEmpty) {
      VxToast.show(message: 'Phone number is not available');
      return;
    }

    Di().sl<CreateAccountCubit>().sendVerificationCode(
      context: parentContext,
      method: 'phone',
      phone: phoneToUse,
    );
  }

  void _onEmailTap() {
    final emailToUse = (email ?? Di().sl<AuthCubit>().emailController.text)
        .trim();

    if (emailToUse.isEmpty) {
      VxToast.show(message: 'Email address is not available');
      return;
    }

    Di().sl<CreateAccountCubit>().sendVerificationCode(
      context: parentContext,
      method: 'email',
      email: emailToUse,
    );
  }
}

class _MethodCard extends StatelessWidget {
  final Widget icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _MethodCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isLight = isLightTheme(context);

    return AppInkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: () {
        Navigator.of(context).pop();
        onTap();
      },
      child: Container(
        height: 126,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: isLight
              ? null
              : LinearGradient(
                  colors: [
                    ColorPalette.primary.withValues(alpha: 0.95),
                    ColorPalette.primary.withValues(alpha: 0.70),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
          color: isLight
              ? ColorPalette.textGrey
              : ColorPalette.textGrey.withValues(alpha: 0.35),
          border: Border.all(
            color: isLight
                ? ColorPalette.primary.withValues(alpha: 0.18)
                : Colors.white.withValues(alpha: 0.1),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon,
            const SizedBox(height: 12),
            AppText(
              text: title,
              style: AppTextStyles.subHeading(context).copyWith(
                fontWeight: FontWeight.w500,
                color: isLight ? ColorPalette.black : Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            AppText(
              text: subtitle,
              style: AppTextStyles.description(context).copyWith(
                fontWeight: FontWeight.w400,
                color: isLight
                    ? ColorPalette.black.withValues(alpha: 0.7)
                    : Colors.white.withValues(alpha: 0.9),
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
