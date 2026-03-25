import 'dart:ui';
import 'package:auto_route/auto_route.dart';
import 'package:fennac_app/app/constants/media_query_constants.dart';
import 'package:fennac_app/app/theme/app_colors.dart';
import 'package:fennac_app/app/theme/text_styles.dart';
import 'package:fennac_app/pages/liked_groups/presentation/screen/liked_groups_screen.dart';
import 'package:fennac_app/pages/my_group/presentation/bloc/cubit/my_group_cubit.dart';
import 'package:fennac_app/pages/profile/presentation/screen/appearence_screen.dart';
import 'package:fennac_app/pages/profile/presentation/widgets/poke_balance_tile.dart';
import 'package:fennac_app/pages/profile/presentation/widgets/profile_header.dart';
import 'package:fennac_app/pages/profile/presentation/widgets/switch_groups_bottomsheet.dart';

import 'package:fennac_app/pages/profile/presentation/widgets/profile_list_tile.dart';
import 'package:fennac_app/routes/routes_imports.gr.dart';
import 'package:fennac_app/utils/validators.dart';

import 'package:fennac_app/widgets/custom_sized_box.dart';
import 'package:fennac_app/widgets/custom_text.dart';
import 'package:fennac_app/widgets/movable_background.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/di_container.dart';
import '../../../auth/presentation/bloc/cubit/login_cubit.dart';

@RoutePage()
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final ValueNotifier<bool> _blurNotifier = ValueNotifier<bool>(false);

  Future<void> _fetchGroup() async {
    await Di().sl<MyGroupCubit>().fetchGroupById('');
  }

  @override
  void dispose() {
    _blurNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPalette.secondary,
      body: ValueListenableBuilder<bool>(
        valueListenable: _blurNotifier,
        builder: (context, shouldBlur, child) {
          return Stack(
            children: [
              MovableBackground(
                backgroundType: MovableBackgroundType.dark,
                child: RefreshIndicator(
                  onRefresh: _fetchGroup,
                  child: SafeArea(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 20,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ProfileHeader(),
                          const CustomSizedBox(height: 20),
                          BlocBuilder(
                            bloc: Di().sl<LoginCubit>(),
                            builder: (context, state) {
                              return PokeBalanceTile(
                                pokeCount: validateInt(
                                  Di()
                                          .sl<LoginCubit>()
                                          .userData
                                          ?.user
                                          ?.pokeBalance ??
                                      0,
                                ),
                                onBuyMore: () {
                                  AutoRouter.of(
                                    context,
                                  ).push(const BuyPokeRoute());
                                },
                              );
                            },
                          ),
                          const CustomSizedBox(height: 24),

                          if (Di()
                                  .sl<LoginCubit>()
                                  .userData
                                  ?.user
                                  ?.accountStatus
                                  ?.toLowerCase() ==
                              'active'.toLowerCase()) ...[
                            Container(
                              decoration: BoxDecoration(
                                color: isLightTheme(context)
                                    ? ColorPalette.textGrey
                                    : ColorPalette.black.withValues(
                                        alpha: 0.25,
                                      ),
                                border: Border.all(
                                  color: ColorPalette.grey,
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Column(
                                children: [
                                  ProfileListTile(
                                    isSwitchGroupTile: true,
                                    showDivider: false,
                                    title: 'People Who Liked You',
                                    onTap: () {
                                      AutoRouter.of(
                                        context,
                                      ).push(HomeRoute(isLikedGroups: true));
                                      // Navigator.of(context).push(
                                      //   MaterialPageRoute(
                                      //     builder: (context) =>
                                      //         const LikedGroupsScreen(),
                                      //   ),
                                      // );
                                    },
                                  ),
                                  Divider(
                                    height: 1,
                                    color: isLightTheme(context)
                                        ? ColorPalette.grey
                                        : ColorPalette.grey,
                                  ),
                                  ProfileListTile(
                                    isSwitchGroupTile: true,
                                    showDivider: false,
                                    title: 'Switch Groups',
                                    onTap: () {
                                      showSwitchGroupsBottomSheet(
                                        context,
                                        blurNotifier: _blurNotifier,
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                          const CustomSizedBox(height: 32),
                          _buildYourProfileSection(context),
                          const CustomSizedBox(height: 32),
                          _buildAccountSettingsSection(context),
                          const CustomSizedBox(height: 100),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              if (shouldBlur)
                Positioned.fill(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                    child: Container(
                      color: Colors.black.withValues(alpha: 0.3),
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildYourProfileSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8, bottom: 16),
          child: AppText(
            text: 'Your Profile',
            style: AppTextStyles.inputLabel(
              context,
            ).copyWith(fontWeight: FontWeight.w600),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: isLightTheme(context)
                ? ColorPalette.textGrey
                : ColorPalette.black.withValues(alpha: 0.25),

            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: ColorPalette.grey, width: 1),
          ),
          child: Column(
            children: [
              ProfileListTile(
                title: 'Edit Public Profile',
                showDivider: false,
                onTap: () {
                  AutoRouter.of(context).push(const EditPublicProfileRoute());
                },
              ),
              Container(height: 1, color: ColorPalette.grey),
              ProfileListTile(
                title: 'Your Groups',
                onTap: () {
                  AutoRouter.of(context).push(const YourGroupsRoute());
                },
                isGroupTile: true,
                showDivider: false,
              ),
              ProfileListTile(
                title: 'Create a Group',
                onTap: () {
                  AutoRouter.of(context).push(CreateGroupRoute());
                },
                showDivider: true,
              ),
              ProfileListTile(
                title: 'Find a Group with QR Code',
                showDivider: false,
                onTap: () {
                  AutoRouter.of(context).push(FindGroupRoute());
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildAccountSettingsSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8, bottom: 16),
          child: AppText(
            text: 'Account & Settings',
            style: AppTextStyles.inputLabel(
              context,
            ).copyWith(fontWeight: FontWeight.w600),
          ),
        ),
        BlocBuilder(
          bloc: Di().sl<LoginCubit>(),
          builder: (context, state) {
            return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: isLightTheme(context)
                    ? ColorPalette.textGrey
                    : ColorPalette.black.withValues(alpha: 0.2),

                border: Border.all(color: ColorPalette.grey, width: 1),
              ),
              child: Column(
                children: [
                  if (Di().sl<LoginCubit>().userData?.user?.authType ==
                      'email') ...[
                    ProfileListTile(
                      title: 'Change Password',
                      showDivider: false,
                      onTap: () {
                        AutoRouter.of(
                          context,
                        ).push(const ChangePasswordRoute());
                      },
                    ),
                    ProfileListTile(
                      title: 'Change Email or Phone',
                      onTap: () {
                        AutoRouter.of(
                          context,
                        ).push(const ChangeEmailPhoneRoute());
                      },
                    ),
                  ],

                  Container(
                    height: 1,
                    color: isLightTheme(context)
                        ? Colors.transparent
                        : ColorPalette.grey,
                  ),
                  ProfileListTile(
                    title: 'Notification Settings',
                    onTap: () {
                      AutoRouter.of(
                        context,
                      ).push(const NotificationSettingsRoute());
                    },
                    showDivider: false,
                  ),
                  Container(
                    height: 1,
                    color: isLightTheme(context)
                        ? Colors.grey
                        : ColorPalette.grey,
                  ),
                  ProfileListTile(
                    title: 'App Appearance',
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const AppearenceScreen(),
                        ),
                      );
                      // AutoRouter.of(context).push(const AppearenceRoute());
                    },
                    showDivider: false,
                  ),
                  Container(
                    height: 1,
                    color: isLightTheme(context)
                        ? ColorPalette.grey
                        : ColorPalette.grey,
                  ),
                  ProfileListTile(
                    title: 'Privacy & Permissions',
                    onTap: () {
                      AutoRouter.of(
                        context,
                      ).push(const PrivacyPermissionsRoute());
                    },
                    showDivider: true,
                  ),
                  ProfileListTile(
                    title: 'Manage Subscriptions',
                    onTap: () {
                      AutoRouter.of(
                        context,
                      ).push(const ManageSubscriptionsRoute());
                    },
                    showDivider: true,
                  ),
                  ProfileListTile(
                    title: 'Help & Support',
                    onTap: () {
                      AutoRouter.of(context).push(const HelpSupportRoute());
                    },
                    showDivider: true,
                  ),
                  ProfileListTile(
                    title: 'Logout',
                    onTap: () {
                      Di().sl<LoginCubit>().logout(context);
                    },
                    showDivider: false,
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}
