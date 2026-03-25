import 'dart:developer';
import 'dart:ui';

import 'package:auto_route/auto_route.dart';
import 'package:fennac_app/app/theme/app_colors.dart';
import 'package:fennac_app/app/theme/text_styles.dart';
import 'package:fennac_app/core/di_container.dart';
import 'package:fennac_app/helpers/qr_helper.dart';
import 'package:fennac_app/pages/auth/presentation/bloc/cubit/login_cubit.dart';
import 'package:fennac_app/pages/home/presentation/bloc/cubit/home_cubit.dart';
import 'package:fennac_app/pages/home/presentation/widgets/group_gallery_widget.dart';
import 'package:fennac_app/routes/routes_imports.gr.dart';
import 'package:fennac_app/utils/validators.dart';
import 'package:fennac_app/widgets/custom_elevated_button.dart';
import 'package:fennac_app/widgets/custom_sized_box.dart';
import 'package:fennac_app/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:fennac_app/widgets/custom_outlined_button.dart';
import 'package:fennac_app/pages/profile/presentation/widgets/profile_avatar.dart';
import 'package:fennac_app/pages/profile/presentation/widgets/profile_chip.dart';
import 'package:fennac_app/pages/profile/presentation/widgets/full_profile_dialog.dart';
import 'package:fennac_app/generated/assets.gen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../app/constants/media_query_constants.dart';
import '../../../../core/extensions/string_extension.dart';

class ProfileHeader extends StatefulWidget {
  final Color? backgroundColor;
  final bool? showAvatar;
  final bool? isEditMode;
  const ProfileHeader({
    super.key,
    this.backgroundColor,
    this.showAvatar = true,
    this.isEditMode = false,
  });

  @override
  State<ProfileHeader> createState() => _ProfileHeaderState();
}

class _ProfileHeaderState extends State<ProfileHeader> {
  final LoginCubit _loginCubit = Di().sl<LoginCubit>();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(widget.showAvatar == true ? 24 : 16),
      decoration: BoxDecoration(
        color:
            widget.backgroundColor ??
            (isLightTheme(context)
                ? ColorPalette.textGrey
                : ColorPalette.cardBlack.withValues(alpha: 0.25)),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: ColorPalette.grey, width: 1),
      ),
      child: BlocBuilder(
        bloc: _loginCubit,
        builder: (context, state) {
          final avatarUrl = _loginCubit.userData?.user?.bestShorts
              ?.where((e) => e.trim().isNotEmpty)
              .toList()
              .firstOrNull;

          return Column(
            children: [
              if (widget.showAvatar == true) ...[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Spacer(),
                    ProfileAvatar(imageUrl: avatarUrl, size: 128),
                    Spacer(),
                    GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () {
                        log('QR Code tapped');
                        showModalBottomSheet(
                          context: context,
                          backgroundColor: Colors.transparent,
                          isScrollControlled: true,
                          builder: (context) => Container(
                            height: getHeight(context) * 0.55,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              gradient: isLightTheme(context)
                                  ? null
                                  : const LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [
                                        Color(0xFF16003F),
                                        Color(0xFF111111),
                                      ],
                                    ),
                              color: isLightTheme(context)
                                  ? Colors.white
                                  : null,
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(32),
                                topRight: Radius.circular(32),
                              ),
                            ),
                            padding: const EdgeInsets.only(
                              top: 24,
                              right: 24,
                              bottom: 48,
                              left: 24,
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SizedBox(
                                  width: 370,
                                  child: Text(
                                    'Share this QR Code with your friends',
                                    style: AppTextStyles.h3(context).copyWith(
                                      color: isLightTheme(context)
                                          ? Colors.black
                                          : Colors.white,
                                    ),
                                  ),
                                ),
                                const CustomSizedBox(height: 32),
                                Container(
                                  width: 272,
                                  height: 272,
                                  padding: const EdgeInsets.all(14),
                                  decoration: BoxDecoration(
                                    color: ColorPalette.primary,
                                    borderRadius: BorderRadius.circular(24),
                                    border: Border.all(
                                      color: ColorPalette.white,
                                      width: 4,
                                    ),
                                    boxShadow: isDarkTheme(context)
                                        ? [
                                            BoxShadow(
                                              color: ColorPalette.primary,
                                              blurRadius: 10,
                                              offset: const Offset(0, 3),
                                              spreadRadius: 3,
                                            ),
                                          ]
                                        : null,
                                  ),
                                  child: QrHelper(
                                    data:
                                        _loginCubit.userData?.user?.qrCode ??
                                        'Group QR Code Data',
                                  ),
                                ),
                                const CustomSizedBox(height: 32),
                                CustomElevatedButton(
                                  text: 'Done',
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 80),
                        child: Icon(
                          Icons.qr_code_2,
                          size: 32,
                          color: isLightTheme(context)
                              ? ColorPalette.primary
                              : Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                const CustomSizedBox(height: 16),
              ],
              if (widget.isEditMode == true)
                GestureDetector(
                  onTap: () {
                    AutoRouter.of(context).push(KycRoute(isEditMode: true));
                  },
                  child: Align(
                    alignment: Alignment.topRight,
                    child: Container(
                      width: 32,
                      height: 32,
                      alignment: Alignment.center,

                      decoration: BoxDecoration(
                        color: ColorPalette.primary,
                        shape: BoxShape.circle,
                      ),
                      child: SvgPicture.asset(
                        Assets.icons.edit.path,
                        width: 16,
                        height: 16,
                      ),
                    ),
                  ),
                ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AppText(
                    text:
                        '${_loginCubit.userData?.user?.firstName ?? ''} ${_loginCubit.userData?.user?.lastName ?? ''}, ${calculateAge(_loginCubit.userData?.user?.dob.toString() ?? "")}',
                    style: AppTextStyles.h3(
                      context,
                    ).copyWith(fontWeight: FontWeight.w500),
                  ),
                  if (_loginCubit.userData?.user?.accountStatus != null &&
                      _loginCubit.userData!.user!.accountStatus!
                              .toLowerCase() ==
                          'active'.toLowerCase()) ...[
                    const SizedBox(width: 8),
                    Tooltip(
                      message: 'Premium User',
                      triggerMode: TooltipTriggerMode.longPress,
                      decoration: BoxDecoration(
                        color: ColorPalette.primary,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      textStyle: AppTextStyles.inputLabel(context).copyWith(
                        color: ColorPalette.white,
                        fontWeight: FontWeight.w600,
                      ),
                      child: SvgPicture.asset(
                        Assets.icons.diamondStone.path,
                        width: getWidth(context) > 370 ? 24 : 20,
                        height: getWidth(context) > 370 ? 24 : 20,
                      ),
                    ),
                  ],

                  const SizedBox(width: 8),
                  if (_loginCubit.userData?.user?.isVerified == true)
                    SvgPicture.asset(
                      Assets.icons.verified.path,
                      width: 20,
                      height: 20,
                    ),
                ],
              ),
              const CustomSizedBox(height: 16),
              // Profile Chips
              Builder(
                builder: (context) {
                  final user = _loginCubit.userData?.user;
                  if (user == null) return const SizedBox.shrink();

                  List<String?>? orientation =
                      user.sexualOrientation != null &&
                          user.sexualOrientation!.isNotEmpty
                      ? user.sexualOrientation
                      : [];

                  final hasEducation =
                      user.education != null && user.education!.isNotEmpty;
                  final hasJobTitle =
                      user.jobTitle != null && user.jobTitle!.isNotEmpty;

                  return Column(
                    children: [
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        alignment: WrapAlignment.center,
                        children: [
                          if (orientation != null)
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              spacing: 8,
                              children: List.generate(orientation.length, (
                                index,
                              ) {
                                return ProfileChip(
                                  label: (orientation[index] ?? '')
                                      .capitalize(),
                                );
                              }),
                            ),
                          if (user.pronouns != null &&
                              user.pronouns!.isNotEmpty)
                            ProfileChip(label: user.pronouns!),
                          if (user.v != null)
                            ProfileChip(
                              icon: Assets.icons.mapPin.path,
                              label: '${user.v}',
                            ),
                          ProfileChip(
                            icon: Assets.icons.navigation.path,
                            label: 'Distance',
                          ),
                        ],
                      ),

                      if (hasEducation || hasJobTitle) ...[
                        const CustomSizedBox(height: 16),
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          alignment: WrapAlignment.center,
                          children: [
                            if (hasEducation)
                              ProfileChip(
                                icon: Assets.icons.bag.path,
                                label: user.education!,
                              ),
                            if (hasJobTitle)
                              ProfileChip(
                                icon: Assets.icons.cap.path,
                                label: user.jobTitle!,
                              ),
                          ],
                        ),
                      ],
                    ],
                  );
                },
              ),

              const CustomSizedBox(height: 20),
              if (widget.showAvatar == false)
                AppText(
                  text:
                      _loginCubit.userData?.user?.shortBio ??
                      'Code, climb, repeat. Always up for a challenge — unless it\'s karaoke.',

                  textAlign: TextAlign.center,
                  style: AppTextStyles.body(context).copyWith(),
                ),

              if (widget.showAvatar == true)
                CustomOutlinedButton(
                  text: 'View Full Profile',
                  onPressed: () {
                    Di().sl<HomeCubit>().selectedProfileType =
                        SelectedProfile.individual;
                    const double minSheetExtent = 0.5;
                    const double maxSheetExtent = 1.0;
                    const double initialSheetExtent = 0.8;

                    final blurNotifier = ValueNotifier<double>(
                      lerpDouble(
                            4,
                            20,
                            ((initialSheetExtent - minSheetExtent) /
                                    (maxSheetExtent - minSheetExtent))
                                .clamp(0.0, 1.0),
                          ) ??
                          8,
                    );

                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      backgroundColor: Colors.transparent,
                      builder: (_) => ValueListenableBuilder<double>(
                        valueListenable: blurNotifier,
                        builder: (context, blur, __) => Stack(
                          children: [
                            Positioned.fill(
                              child: IgnorePointer(
                                child: ClipRect(
                                  child: BackdropFilter(
                                    filter: ImageFilter.blur(
                                      sigmaX: blur,
                                      sigmaY: blur,
                                    ),
                                    child: Container(color: Colors.transparent),
                                  ),
                                ),
                              ),
                            ),
                            DraggableScrollableSheet(
                              initialChildSize: initialSheetExtent,
                              minChildSize: minSheetExtent,
                              maxChildSize: maxSheetExtent,
                              expand: false,
                              builder: (context, scrollController) =>
                                  NotificationListener<
                                    DraggableScrollableNotification
                                  >(
                                    onNotification: (notification) {
                                      final progress =
                                          ((notification.extent -
                                                      minSheetExtent) /
                                                  (maxSheetExtent -
                                                      minSheetExtent))
                                              .clamp(0.0, 1.0);
                                      final nextBlur = lerpDouble(
                                        4,
                                        20,
                                        progress,
                                      );
                                      if (nextBlur != null) {
                                        blurNotifier.value = nextBlur;
                                      }
                                      return false;
                                    },
                                    child: FullProfileDialog(
                                      isEditProfile: true,
                                      scrollController: scrollController,
                                    ),
                                  ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
            ],
          );
        },
      ),
    );
  }
}
