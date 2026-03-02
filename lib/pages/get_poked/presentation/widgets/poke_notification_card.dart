import 'package:fennac_app/app/theme/app_colors.dart';
import 'package:fennac_app/app/theme/text_styles.dart';
import 'package:fennac_app/pages/home/data/models/groups_model.dart';
import 'package:fennac_app/pages/home/presentation/blur_controller.dart';
import 'package:fennac_app/pages/home/presentation/widgets/report_and_block_bottomsheet.dart';
import 'package:fennac_app/pages/profile/presentation/widgets/full_profile_dialog.dart';
import 'package:fennac_app/widgets/custom_elevated_button.dart';
import 'package:fennac_app/widgets/custom_outlined_button.dart';
import 'package:fennac_app/widgets/custom_sized_box.dart';
import 'package:fennac_app/widgets/custom_text.dart';
import 'package:flutter/material.dart';

import '../../../../app/constants/media_query_constants.dart';
import '../../../../core/di_container.dart';
import '../../../home/presentation/bloc/cubit/home_cubit.dart';

class PokeNotificationCard extends StatelessWidget {
  final Group group;
  final Member poker;
  final VoidCallback onIgnore;
  final VoidCallback onStartChat;

  const PokeNotificationCard({
    super.key,
    required this.group,
    required this.poker,
    required this.onIgnore,
    required this.onStartChat,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          padding: const EdgeInsets.only(left: 20, right: 20, bottom: 30),
          decoration: BoxDecoration(
            color: isLightTheme(context)
                ? Colors.white
                : ColorPalette.secondary,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(32),
              topRight: Radius.circular(32),
            ),
            boxShadow: [
              isLightTheme(context)
                  ? BoxShadow(
                      color: Colors.black.withValues(alpha: 0.1),
                      blurRadius: 10,
                      offset: const Offset(0, -5),
                    )
                  : null,
            ].whereType<BoxShadow>().toList(),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const CustomSizedBox(height: 24),
              Center(
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: isLightTheme(context)
                        ? ColorPalette.white
                        : ColorPalette.secondary,
                    shape: BoxShape.circle,
                  ),
                  child: Container(
                    height: 60,
                    width: 60,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: AssetImage(poker.coverImage ?? ''),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
              const CustomSizedBox(height: 24),
              AppText(
                text: 'You Got a Poke!',
                style: AppTextStyles.h2(
                  context,
                ).copyWith(fontWeight: FontWeight.bold),
              ),
              const CustomSizedBox(height: 24),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: AppTextStyles.body(
                    context,
                  ).copyWith(color: ColorPalette.textSecondary, height: 1.5),
                  children: [
                    TextSpan(
                      text: poker.firstName,
                      style: AppTextStyles.body(context),
                    ),
                    TextSpan(
                      text:
                          ' poked you on your photo — guess it caught\nhis attention 👀',
                      style: AppTextStyles.body(context),
                    ),
                  ],
                ),
              ),
              const CustomSizedBox(height: 24),
              // Group Stack Container
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color: isLightTheme(context)
                      ? ColorPalette.textGrey
                      : ColorPalette.primary.withValues(
                          alpha: 0.5,
                        ), // Slightly lighter purple
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Row(
                  children: [
                    SizedBox(
                      height: 44,
                      width: 130,
                      child: Stack(
                        children: List.generate(
                          (group.members?.take(4).length ?? 0),
                          (index) {
                            return Positioned(
                              left: index * 24.0,
                              child: Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: ColorPalette.secondary,
                                    width: 2,
                                  ),
                                ),
                                child: CircleAvatar(
                                  radius: 20,
                                  backgroundImage: AssetImage(
                                    group.members?[index].coverImage ?? '',
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    const Spacer(),
                    InkWell(
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          backgroundColor: Colors.transparent,
                          builder: (_) => FractionallySizedBox(
                            heightFactor: 0.8,
                            child: FullProfileDialog(),
                          ),
                        );
                      },
                      child: AppText(
                        text: 'View Group Profile',
                        style: AppTextStyles.bodySmall(
                          context,
                        ).copyWith(fontWeight: FontWeight.w600),
                      ),
                    ),
                    const CustomSizedBox(width: 4),
                    Icon(
                      Icons.arrow_outward_rounded,
                      color: isLightTheme(context)
                          ? ColorPalette.black
                          : ColorPalette.white,
                      size: 16,
                    ),
                  ],
                ),
              ),
              const CustomSizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: CustomOutlinedButton(
                      text: 'Ignore',
                      onPressed: onIgnore,
                      borderColor: isLightTheme(context)
                          ? ColorPalette.secondary
                          : ColorPalette.white,
                      textColor: isLightTheme(context)
                          ? ColorPalette.secondary
                          : ColorPalette.white,
                      borderRadius: 30,
                    ),
                  ),
                  const CustomSizedBox(width: 16),
                  Expanded(
                    child: CustomElevatedButton(
                      text: 'Start Chat',
                      onTap: onStartChat,
                      backgroundColor: ColorPalette.primary,
                    ),
                  ),
                ],
              ),
              const CustomSizedBox(height: 16),
              InkWell(
                onTap: () {
                  final groupId = Di().sl<HomeCubit>().currentGroup?.id;
                  if (groupId == null || groupId.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Unable to report this group right now.'),
                      ),
                    );
                    return;
                  }
                  HomeBlurController.showWithBlur(
                    context: context,
                    builder: (_) => ReportAndBlockBottomSheet(groupId: ''),
                  );
                },
                child: AppText(
                  text: 'Report and block',
                  style: AppTextStyles.bodyLarge(context),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
