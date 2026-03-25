import 'package:auto_route/auto_route.dart';
import 'package:fennac_app/app/theme/app_colors.dart';
import 'package:fennac_app/core/di_container.dart';
import 'package:fennac_app/pages/home/presentation/widgets/home_card_design.dart';
import 'package:fennac_app/pages/liked_groups/presentation/bloc/state/like_groups_state.dart';
import 'package:fennac_app/widgets/custom_sized_box.dart';
import 'package:fennac_app/widgets/movable_background.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fennac_app/pages/liked_groups/presentation/bloc/cubit/liked_groups_cubit.dart';
import 'package:fennac_app/generated/assets.gen.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';

@RoutePage()
class LikedGroupsScreen extends StatefulWidget {
  const LikedGroupsScreen({super.key});

  @override
  State<LikedGroupsScreen> createState() => _LikedGroupsScreenState();
}

class _LikedGroupsScreenState extends State<LikedGroupsScreen> {
  @override
  void initState() {
    super.initState();
    Di().sl<LikedGroupsCubit>().fetchPeopleWhoLikedMe();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<LikedGroupsCubit, LikedGroupsState>(
        bloc: Di().sl<LikedGroupsCubit>(),
        builder: (context, state) {
          if (state is LikedGroupsLoading) {
            return Center(
              child: SizedBox(
                width: 40,
                height: 40,
                child: Lottie.asset(Assets.animations.loadingSpinner),
              ),
            );
          }
          if (state is LikedGroupsError) {
            return Center(child: Text(state.message));
          }
          if (state is LikedGroupsSuccess) {
            final groups =
                Di().sl<LikedGroupsCubit>().groupsModel?.data?.groups ?? [];
            return MovableBackground(
              child: Column(
                children: [
                  SafeArea(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          behavior: HitTestBehavior.translucent,
                          onTap: () {},
                          child: Container(
                            height: 40,
                            width: 40,
                            alignment: Alignment.center,
                            margin: const EdgeInsets.symmetric(horizontal: 16),

                            decoration: BoxDecoration(
                              color: Colors.black26,
                              shape: BoxShape.circle,
                            ),
                            child: SvgPicture.asset(
                              Assets.icons.rotateCcw.path,
                              height: 16,
                            ),
                          ),
                        ),
                        SvgPicture.asset(
                          Assets.icons.fennecLogoText.path,
                          height: 18,
                          color: ColorPalette.primary,
                        ),
                        GestureDetector(
                          behavior: HitTestBehavior.translucent,

                          onTap: () {},
                          child: Container(
                            height: 40,
                            width: 40,
                            alignment: Alignment.center,
                            margin: const EdgeInsets.symmetric(horizontal: 16),
                            decoration: BoxDecoration(
                              color: Colors.black26,
                              shape: BoxShape.circle,
                            ),
                            child: SvgPicture.asset(
                              Assets.icons.sliders.path,
                              height: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  CustomSizedBox(height: 24),
                  HomeCardDesign(
                    group: groups.first,
                    onTapLeft: () {},
                    onTapRight: () {},
                  ),
                ],
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
