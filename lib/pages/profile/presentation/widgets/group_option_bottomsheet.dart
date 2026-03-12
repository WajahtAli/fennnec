import 'package:auto_route/auto_route.dart';
import 'package:fennac_app/app/constants/media_query_constants.dart';
import 'package:fennac_app/app/theme/app_colors.dart';
import 'package:fennac_app/app/theme/text_styles.dart';
import 'package:fennac_app/core/di_container.dart';
import 'package:fennac_app/generated/assets.gen.dart';
import 'package:fennac_app/helpers/qr_helper.dart';
import 'package:fennac_app/pages/my_group/data/model/my_group_model.dart';
import 'package:fennac_app/pages/dashboard/presentation/bloc/cubit/dashboard_cubit.dart';
import 'package:fennac_app/pages/my_group/presentation/bloc/cubit/my_group_cubit.dart';
import 'package:fennac_app/reusable_widgets/animated_background_container.dart';
import 'package:fennac_app/reusable_widgets/group_card.dart';
import 'package:fennac_app/routes/routes_imports.gr.dart';
import 'package:fennac_app/utils/validators.dart';
import 'package:fennac_app/widgets/custom_bottom_sheet.dart';
import 'package:fennac_app/widgets/custom_elevated_button.dart';
import 'package:fennac_app/widgets/custom_sized_box.dart';
import 'package:fennac_app/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class GroupOptionsBottomSheet extends StatelessWidget {
  final bool isEdit;
  final MyGroupData groupData;

  const GroupOptionsBottomSheet({
    super.key,
    this.isEdit = false,
    required this.groupData,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: isLightTheme(context)
            ? null
            : const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xFF16003F), Color(0xFF111111)],
              ),
        color: isLightTheme(context) ? Colors.white : null,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(32),
          topRight: Radius.circular(32),
        ),
      ),
      padding: const EdgeInsets.only(top: 24, right: 24, bottom: 48, left: 24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: AppText(
                text: 'Your Groups',
                textAlign: TextAlign.left,
                style: AppTextStyles.subHeading(
                  context,
                ).copyWith(fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Builder(
            builder: (context) {
              final avatarPaths =
                  groupData.members
                      ?.map((member) => member.image ?? '')
                      .toList() ??
                  [];

              return GroupCard(
                isShowInfoIcon: false,
                height: 156,
                backgroundColor: isDarkTheme(context)
                    ? ColorPalette.primary.withValues(alpha: 0.25)
                    : null,
                memberNames:
                    groupData.members
                        ?.map((member) => validateString(member.firstName))
                        .toList() ??
                    [],
                title:
                    groupData.titleMembers ?? 'Brenda, Nancy, Jeff, Anna & You',
                subtitle: groupData.bio ?? 'A group for Flutter developers',
                avatarPaths: avatarPaths,
              );
            },
          ),
          const SizedBox(height: 24),

          _buildOption(
            context,
            title: 'Edit Group',
            textColor: Colors.white,
            onTap: () {
              Di().sl<MyGroupCubit>().updateMyGroupDataLocal(groupData);
              Navigator.pop(context);
              AutoRouter.of(
                context,
              ).push(EditGroupRoute(groupId: groupData.id ?? ''));
            },
          ),

          // View QR Code Option
          _buildOption(
            context,
            title: 'View QR Code',
            textColor: Colors.white,
            onTap: () {
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
                            colors: [Color(0xFF16003F), Color(0xFF111111)],
                          ),
                    color: isLightTheme(context) ? Colors.white : null,
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
                          data: groupData.qrCode ?? 'Group QR Code Data',
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
          ),

          //todo only for group to group unMatch
          // _buildOption(
          //   context,
          //   title: 'Leave This Group',
          //   textColor: const Color(0xFFFF3B30),
          //   onTap: () {
          //     CustomBottomSheet.show(
          //       context: context,
          //       isSecondaryButtonFirst: true,

          //       icon: AnimatedBackgroundContainer(
          //         icon: Assets.icons.alertTriangle.path,
          //       ),
          //       title: 'Leave This Group?',
          //       description:
          //           "Once you leave this group, you won’t be able to access its messages, media, and matches with this group.",
          //       description1: 'This action cannot be undone.',
          //       buttonText: ' Leave Group',
          //       onButtonPressed: () async {
          //         final bool isUnmatched = await Di()
          //             .sl<MyGroupCubit>()
          //             .unMatchGroupById(groupData.id ?? '');
          //         if (!context.mounted || !isUnmatched) {
          //           return;
          //         }

          //         CustomBottomSheet.show(
          //           context: context,
          //           icon: AnimatedBackgroundContainer(
          //             icon: Assets.icons.checkGreen.path,
          //             isPng: true,
          //           ),
          //           title: 'Group Deleted',
          //           description: 'Your group has been successfully removed.',
          //           descriptionStyle: AppTextStyles.h4(context),
          //           description1:
          //               "You can always create a new group or join an existing one whenever you’re ready to connect again.",
          //           description1Style: AppTextStyles.subHeading(context)
          //               .copyWith(
          //                 color: ColorPalette.textSecondary,
          //                 fontWeight: FontWeight.w600,
          //               ),
          //           buttonText: 'Explore Groups',
          //           onButtonPressed: () {
          //             AutoRouter.of(context).push(DashboardRoute());
          //             Di().sl<DashboardCubit>().changeIndex(0);
          //           },
          //         );
          //       },
          //       isHorizontalButton: true,

          //       secondaryButtonText: 'Cancel',
          //     );
          //   },
          // ),
          _buildOption(
            context,
            title: 'Delete This Group',
            textColor: const Color(0xFFFF3B30),
            onTap: () {
              CustomBottomSheet.show(
                context: context,
                isSecondaryButtonFirst: true,

                icon: AnimatedBackgroundContainer(
                  icon: Assets.icons.alertTriangle.path,
                ),
                title: 'Delete This Group?',
                description:
                    "Once you Delete this group, you won’t be able to access its messages, media, and matches with this group.",
                description1: 'This action cannot be undone.',
                buttonText: ' Delete Group',
                onButtonPressed: () async {
                  final bool isDeleted = await Di()
                      .sl<MyGroupCubit>()
                      .deleteGroupById(groupData.id ?? '');
                  if (!context.mounted || !isDeleted) {
                    return;
                  }

                  CustomBottomSheet.show(
                    context: context,
                    icon: AnimatedBackgroundContainer(
                      icon: Assets.icons.checkGreen.path,
                      isPng: true,
                    ),
                    title: 'Group Deleted',
                    description: 'Your group has been successfully removed.',
                    descriptionStyle: AppTextStyles.h4(context),
                    description1:
                        "You can always create a new group or join an existing one whenever you’re ready to connect again.",
                    description1Style: AppTextStyles.subHeading(context)
                        .copyWith(
                          color: ColorPalette.textSecondary,
                          fontWeight: FontWeight.w600,
                        ),
                    buttonText: 'Explore Groups',
                    onButtonPressed: () {
                      AutoRouter.of(context).push(DashboardRoute());
                      Di().sl<DashboardCubit>().changeIndex(0);
                    },
                  );
                },
                isHorizontalButton: true,

                secondaryButtonText: 'Cancel',
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildOption(
    BuildContext context, {
    required String title,
    required Color textColor,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Divider(
            color: isLightTheme(context)
                ? Colors.black.withValues(alpha: 0.1)
                : ColorPalette.grey,
            thickness: 1.5,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              title,
              style: AppTextStyles.body(context).copyWith(
                color: isLightTheme(context) && textColor == Colors.white
                    ? Colors.black
                    : textColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
