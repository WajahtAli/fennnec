import 'package:fennac_app/app/constants/media_query_constants.dart';
import 'package:fennac_app/app/theme/app_colors.dart';
import 'package:fennac_app/app/theme/text_styles.dart';
import 'package:fennac_app/core/di_container.dart';
import 'package:fennac_app/generated/assets.gen.dart';
import 'package:fennac_app/pages/auth/presentation/bloc/cubit/login_cubit.dart';
import 'package:fennac_app/pages/auth/presentation/bloc/state/login_state.dart';
import 'package:fennac_app/pages/liked_groups/presentation/bloc/cubit/liked_groups_cubit.dart';
import 'package:fennac_app/pages/liked_groups/presentation/bloc/state/like_groups_state.dart';
import 'package:fennac_app/pages/my_group/presentation/bloc/cubit/my_group_cubit.dart';
import 'package:fennac_app/reusable_widgets/member_avatar_widget.dart';
import 'package:fennac_app/utils/validators.dart';
import 'package:fennac_app/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';

class ProfileListTile extends StatelessWidget {
  final String title;
  final String? subtitle;
  final VoidCallback? onTap;
  final bool showDivider;
  final bool? isGroupTile;
  final bool? isPeopleLikedYouTile;
  final bool? isSwitchGroupTile;
  final bool? isLogoutTile;

  const ProfileListTile({
    super.key,
    required this.title,
    this.subtitle,
    this.onTap,
    this.showDivider = true,
    this.isGroupTile,
    this.isPeopleLikedYouTile,
    this.isSwitchGroupTile,
    this.isLogoutTile,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 56,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          border: showDivider
              ? Border(
                  top: BorderSide(color: ColorPalette.grey, width: 1),
                  bottom: BorderSide(color: ColorPalette.grey, width: 1),
                )
              : null,
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AppText(text: title, style: AppTextStyles.body(context)),
                  if (subtitle != null) ...[
                    const SizedBox(height: 4),
                    AppText(
                      text: subtitle!,
                      style: AppTextStyles.description(
                        context,
                      ).copyWith(color: ColorPalette.textSecondary),
                    ),
                  ],
                ],
              ),
            ),

            if (isGroupTile == true) ...[
              BlocBuilder(
                bloc: Di().sl<MyGroupCubit>(),
                builder: (context, state) {
                  return AppText(
                    text: validateString(
                      Di().sl<MyGroupCubit>().myGroupList?.groupList?.length ??
                          '0',
                    ),
                    style: AppTextStyles.body(context),
                  );
                },
              ),
              const SizedBox(width: 8),
            ],
            if (isPeopleLikedYouTile == true) ...[
              BlocBuilder<LikedGroupsCubit, LikedGroupsState>(
                bloc: Di().sl<LikedGroupsCubit>(),
                builder: (context, state) {
                  if (state is LikedGroupsLoading) {
                    return SizedBox(
                      width: 20,
                      height: 20,
                      child: Lottie.asset(
                        Assets.animations.loadingSpinner,
                        fit: BoxFit.cover,
                      ),
                    );
                  }

                  return AppText(
                    text: validateString(
                      Di()
                              .sl<LikedGroupsCubit>()
                              .groupsModel
                              ?.data
                              ?.groups
                              ?.length ??
                          '0',
                    ),
                    style: AppTextStyles.body(context),
                  );
                },
              ),
              const SizedBox(width: 8),
            ],

            if (isSwitchGroupTile == true) ...[
              BlocBuilder(
                bloc: Di().sl<MyGroupCubit>(),
                builder: (context, state) {
                  final firstGroup = Di()
                      .sl<MyGroupCubit>()
                      .myGroupList
                      ?.groupList
                      ?.firstOrNull;

                  final avatarPaths =
                      firstGroup?.members
                          ?.map((member) => member.image ?? '')
                          .toList() ??
                      [];
                  return MemberAvatarWidget(
                    avatarSize: 32,
                    overlap: 24,
                    avatarPaths: avatarPaths,
                    memberNames:
                        firstGroup?.members
                            ?.map(
                              (member) =>
                                  '${member.firstName ?? ''} ${member.lastName ?? ''}'
                                      .trim(),
                            )
                            .toList() ??
                        [],
                  );
                },
              ),
              const SizedBox(width: 8),
            ],
            if (isLogoutTile == true) ...[
              BlocBuilder<LoginCubit, LoginState>(
                bloc: Di().sl<LoginCubit>(),
                builder: (context, state) {
                  if (state is LoginLoading) {
                    return SizedBox(
                      width: 20,
                      height: 20,
                      child: Lottie.asset(
                        Assets.animations.loadingSpinner,
                        fit: BoxFit.cover,
                      ),
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
              const SizedBox(width: 8),
            ],
            SvgPicture.asset(
              isSwitchGroupTile == true
                  ? Assets.icons.arrowDown.path
                  : Assets.icons.arrowRightChevron.path,
              colorFilter: ColorFilter.mode(
                isLightTheme(context) ? Colors.black : Colors.white,
                BlendMode.srcIn,
              ),
              width: 24,
              height: 24,
            ),
          ],
        ),
      ),
    );
  }
}
