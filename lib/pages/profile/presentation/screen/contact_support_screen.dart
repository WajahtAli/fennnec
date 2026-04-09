import 'dart:ui';

import 'package:auto_route/auto_route.dart';
import 'package:fennac_app/app/constants/media_query_constants.dart';
import 'package:fennac_app/app/theme/app_colors.dart';
import 'package:fennac_app/app/theme/text_styles.dart';
import 'package:fennac_app/core/di_container.dart';
import 'package:fennac_app/generated/assets.gen.dart';
import 'package:fennac_app/pages/profile/presentation/bloc/cubit/contact_support_cubit.dart';
import 'package:fennac_app/pages/profile/presentation/bloc/state/contact_support_state.dart';
import 'package:fennac_app/reusable_widgets/animated_background_container.dart';
import 'package:fennac_app/reusable_widgets/custom_app_bar.dart';
import 'package:fennac_app/widgets/custom_bottom_sheet.dart';
import 'package:fennac_app/widgets/custom_elevated_button.dart';
import 'package:fennac_app/widgets/custom_sized_box.dart';
import 'package:fennac_app/widgets/custom_text.dart';
import 'package:fennac_app/widgets/custom_text_field.dart';
import 'package:fennac_app/widgets/movable_background.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

@RoutePage()
class ContactSupportScreen extends StatefulWidget {
  const ContactSupportScreen({super.key});

  @override
  State<ContactSupportScreen> createState() => _ContactSupportScreenState();
}

class _ContactSupportScreenState extends State<ContactSupportScreen> {
  late TextEditingController _topicController;
  late TextEditingController _messageController;
  late final ValueNotifier<bool> _isBlurNotifier;
  final ContactSupportCubit _contactSupportCubit = Di()
      .sl<ContactSupportCubit>();

  @override
  void initState() {
    super.initState();
    _topicController = TextEditingController();
    _messageController = TextEditingController();
    _isBlurNotifier = ValueNotifier<bool>(false);
  }

  @override
  void dispose() {
    _topicController.dispose();
    _messageController.dispose();
    _isBlurNotifier.dispose();
    _contactSupportCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ContactSupportCubit, ContactSupportState>(
      bloc: _contactSupportCubit,
      listener: (context, state) {
        if (state is ContactSupportSuccess) {
          _topicController.clear();
          _messageController.clear();
          _contactSupportCubit.reset();
        }
      },
      child: ValueListenableBuilder<bool>(
        valueListenable: _isBlurNotifier,
        builder: (context, isBlurred, _) {
          return Stack(
            children: [
              Scaffold(
                body: MovableBackground(
                  backgroundType: MovableBackgroundType.dark,
                  child: SafeArea(
                    child: Column(
                      children: [
                        CustomAppBar(title: 'Contact Support'),
                        Expanded(
                          child: SingleChildScrollView(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 20,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Main heading
                                AppText(
                                  text:
                                      'We\'re here to help — anytime you need us.',
                                  style: AppTextStyles.h3(
                                    context,
                                  ).copyWith(fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.start,
                                ),
                                const CustomSizedBox(height: 16),

                                // Subtitle
                                AppText(
                                  text:
                                      'Tell us what you need help with, and our support team will get back to you within 24 hours.',
                                  style: AppTextStyles.body(context).copyWith(
                                    color: isLightTheme(context)
                                        ? ColorPalette.black
                                        : ColorPalette.textSecondary,
                                    height: 1.5,
                                  ),
                                  textAlign: TextAlign.start,
                                ),
                                const CustomSizedBox(height: 32),

                                // Topic TextField
                                CustomLabelTextField(
                                  label: 'What can we help you with?',
                                  controller: _topicController,
                                  hintText: 'Select a Topic',
                                  fillColor: ColorPalette.black.withValues(
                                    alpha: 0.3,
                                  ),
                                  filled: false,
                                  labelStyle: AppTextStyles.bodyLarge(
                                    context,
                                  ).copyWith(fontWeight: FontWeight.w500),
                                ),
                                const CustomSizedBox(height: 24),

                                // Message TextField
                                CustomLabelTextField(
                                  label: 'Message',
                                  controller: _messageController,
                                  hintText:
                                      'Describe your question or issue here...',
                                  fillColor: ColorPalette.black.withValues(
                                    alpha: 0.3,
                                  ),
                                  filled: false,
                                  maxLines: 6,
                                  minLines: 4,
                                  labelColor: ColorPalette.white,
                                  labelStyle: AppTextStyles.bodyLarge(
                                    context,
                                  ).copyWith(fontWeight: FontWeight.w500),
                                ),
                                const CustomSizedBox(height: 32),

                                BlocBuilder<
                                  ContactSupportCubit,
                                  ContactSupportState
                                >(
                                  bloc: _contactSupportCubit,
                                  builder: (context, state) {
                                    return CustomElevatedButton(
                                      icon: _contactSupportCubit.isSubmitting
                                          ? Lottie.asset(
                                              Assets.animations.loadingSpinner,
                                              width: 24,
                                              height: 24,
                                            )
                                          : null,
                                      text: _contactSupportCubit.isSubmitting
                                          ? ''
                                          : 'Send Message',
                                      onTap: _contactSupportCubit.isSubmitting
                                          ? () {}
                                          : () async {
                                              final success =
                                                  await _contactSupportCubit
                                                      .sendSupportMessage(
                                                        subject:
                                                            _topicController
                                                                .text,
                                                        message:
                                                            _messageController
                                                                .text,
                                                      );

                                              if (success && context.mounted) {
                                                CustomBottomSheet.show(
                                                  context: context,
                                                  icon:
                                                      AnimatedBackgroundContainer(
                                                        icon: Assets
                                                            .icons
                                                            .checkGreen
                                                            .path,
                                                        isPng: true,
                                                      ),
                                                  title: 'Message Sent!',
                                                  description:
                                                      'Thanks for contacting Fennec Support. Our team will review your message and respond shortly.',
                                                  buttonText: 'Done',
                                                  onButtonPressed: () {
                                                    context.pop();
                                                    context.pop();
                                                  },
                                                  blurNotifier: _isBlurNotifier,
                                                );
                                              }
                                            },
                                    );
                                  },
                                ),
                                const CustomSizedBox(height: 40),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              if (isBlurred)
                Positioned.fill(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
                    child: Container(
                      color: Colors.black.withValues(alpha: 0.2),
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}
