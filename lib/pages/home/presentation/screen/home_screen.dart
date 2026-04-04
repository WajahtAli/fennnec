import 'dart:ui';

import 'package:auto_route/auto_route.dart';
import 'package:fennac_app/app/constants/app_enums.dart';
import 'package:fennac_app/app/theme/text_styles.dart';
import 'package:fennac_app/core/di_container.dart';
import 'package:fennac_app/helpers/gradient_toast.dart';
import 'package:fennac_app/pages/auth/presentation/bloc/cubit/login_cubit.dart';
import 'package:fennac_app/pages/dashboard/presentation/bloc/cubit/dashboard_cubit.dart';
import 'package:fennac_app/pages/home/presentation/bloc/cubit/groups_cubit.dart';
import 'package:fennac_app/pages/home/presentation/bloc/state/groups_state.dart';
import 'package:fennac_app/pages/home/presentation/widgets/group_gallery_widget.dart';
import 'package:fennac_app/pages/home/presentation/widgets/hero_section.dart';
import 'package:fennac_app/pages/home/presentation/widgets/home_top_bar.dart';
import 'package:fennac_app/reusable_widgets/empty_widget.dart';
import 'package:fennac_app/routes/routes_imports.gr.dart';
import 'package:fennac_app/skeletons/home/home_landing_skeleton.dart';
import 'package:fennac_app/widgets/movable_background.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_emojis.dart';
import '../../../../generated/assets.gen.dart';
import '../../../../widgets/custom_sized_box.dart';
import '../blur_controller.dart';
import '../swipe/swipe_card.dart';
import '../swipe/swipe_controller.dart';
import '../widgets/home_card_design.dart';
import '../widgets/send_poke_bottomsheet.dart';

@RoutePage()
class HomeScreen extends StatefulWidget {
  final bool isLikedGroups;
  final int? idFromDeepLink;
  const HomeScreen({
    super.key,
    this.isLikedGroups = false,
    this.idFromDeepLink,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  final GroupsCubit _groupsCubit = Di().sl<GroupsCubit>();
  late final AnimationController crossAnimationController;
  late final AnimationController checkAnimationController;
  late final AnimationController endFadeController;
  late final AnimationController checkAnimController;
  late final AnimationController topCardController;
  late final AnimationController nextCardSettleController;

  late final Animation<double> endFadeAnimation;

  late Animation<double> crossSizeAnimation;
  late Animation<double> crossFadeAnimation;
  late Animation<Offset> crossSlideAnimation;

  late Animation<double> checkSizeAnimation;
  late Animation<double> checkFadeAnimation;
  late Animation<Offset> checkSlideAnimation;

  late Animation<double> checkScaleAnimation;
  late Animation<double> endAnimation;

  // 🔹 Top card exit animation
  late final Animation<Offset> topCardSlide;

  // 🔹 Next card settle animation (half → top)
  late final Animation<Offset> nextCardSettleAnimation;

  late SwipeController swipeController;

  Future<void> fetchGroups() async {
    await _groupsCubit.fetchAllGroups(isLikedGroups: widget.isLikedGroups);
  }

  @override
  void initState() {
    super.initState();
    fetchGroups();
    homeCubit.selectedProfileType = SelectedProfile.group;
    swipeController = SwipeController(vsync: this);

    topCardController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    topCardSlide = Tween<Offset>(begin: Offset.zero, end: const Offset(0, -0.3))
        .animate(
          CurvedAnimation(parent: topCardController, curve: Curves.easeOut),
        );

    nextCardSettleController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    checkAnimController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    checkScaleAnimation = Tween<double>(begin: 1.0, end: 1.3).animate(
      CurvedAnimation(parent: checkAnimController, curve: Curves.easeOut),
    );

    endAnimation = Tween<double>(begin: 1, end: 0).animate(
      CurvedAnimation(parent: checkAnimController, curve: Curves.bounceIn),
    );

    nextCardSettleAnimation =
        Tween<Offset>(begin: const Offset(0, 1), end: Offset.zero).animate(
          CurvedAnimation(
            parent: nextCardSettleController,
            curve: Curves.easeOut,
          ),
        );
    crossAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    crossSizeAnimation = Tween<double>(begin: 0.1, end: 4).animate(
      CurvedAnimation(
        parent: crossAnimationController,
        curve: Curves.easeOutBack,
      ),
    );

    endFadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    endFadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: endFadeController, curve: Curves.easeInOut),
    );

    crossFadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: crossAnimationController, curve: Curves.easeIn),
    );

    checkAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    checkSizeAnimation = Tween<double>(begin: 0.1, end: 4).animate(
      CurvedAnimation(
        parent: checkAnimationController,
        curve: Curves.easeOutBack,
      ),
    );

    checkFadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: checkAnimationController, curve: Curves.easeIn),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    fetchGroups();

    final size = MediaQuery.of(context).size;
    const widgetSize = 40.0;
    const topPadding = 70.0;

    final topCenterOffset = Offset(size.width / 2 - widgetSize / 2, topPadding);

    crossSlideAnimation =
        Tween<Offset>(
          begin: Offset(size.width - 100, size.height * 0.3),
          end: topCenterOffset,
        ).animate(
          CurvedAnimation(
            parent: crossAnimationController,
            curve: Curves.easeInOut,
          ),
        );

    checkSlideAnimation =
        Tween<Offset>(
          begin: Offset(0, size.height * 0.3),
          end: topCenterOffset,
        ).animate(
          CurvedAnimation(
            parent: checkAnimationController,
            curve: Curves.easeInOut,
          ),
        );
  }

  void animateSwipe(CardSwiperDirection direction) {
    if (direction == CardSwiperDirection.left) {
      crossAnimationController.forward();
    } else if (direction == CardSwiperDirection.right) {
      checkAnimationController.forward();
    }
  }

  // reset animations
  void resetAnimations() {
    // reset all controllers
    // crossAnimationController.reset();
    // checkAnimationController.reset();
    // checkAnimController.reset();
    topCardController.reset();
    nextCardSettleController.reset();
    swipeController.reset();
  }

  @override
  void dispose() {
    endFadeController.dispose();
    crossAnimationController.dispose();
    checkAnimationController.dispose();
    super.dispose();
  }

  // 🔹 Drag driven next-card position
  double _nextCardYOffset(BuildContext context, double dragX) {
    final height = MediaQuery.of(context).size.height;
    final progress = (dragX.abs() / 250).clamp(0.0, 1.0);
    final clamped = (progress * 0.5).clamp(0.0, 0.5);
    return lerpDouble(
      height, // off screen
      height * 0.4, // half screen
      clamped / 0.5,
    )!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MovableBackground(
        backgroundType: MovableBackgroundType.dark,
        child: BlocListener(
          bloc: homeCubit,
          listener: (context, state) {
            final cardX = homeCubit.xAxisCardValue;
            final progress = (cardX.abs() / 250).clamp(0.0, 1.0);
            if (cardX > 10) {
              checkAnimationController.value = progress;
              crossAnimationController.value = 0;
            } else if (cardX < -10) {
              crossAnimationController.value = progress;
              checkAnimationController.value = 0;
            } else {
              crossAnimationController.value = 0;
              checkAnimationController.value = 0;
            }
          },
          child: BlocBuilder(
            bloc: homeCubit,
            builder: (context, state) {
              final isNonSubscribedUser =
                  Di().sl<LoginCubit>().userData?.user?.subscriptionActive ==
                  false;
              final shouldShowPremiumCard =
                  widget.isLikedGroups &&
                  isNonSubscribedUser &&
                  homeCubit.groups.isNotEmpty;

              return RefreshIndicator(
                color: ColorPalette.primary,
                backgroundColor: Colors.white,
                onRefresh: fetchGroups,
                child: Stack(
                  children: [
                    Column(
                      children: [
                        HomeTopBar(
                          isLikedGroups: widget.isLikedGroups,
                          onSettingsPressed: () {
                            if (widget.isLikedGroups) {
                              resetAnimations();
                              homeCubit.restartFromBeginning();
                              VxToast.show(
                                message: 'Group list reset to start',
                                icon: Assets.icons.checkGreen.path,
                              );
                              return;
                            } else {
                              AutoRouter.of(context).push(const FilterRoute());
                            }
                          },
                          onBackPressed: () {
                            if (widget.isLikedGroups) {
                              AutoRouter.of(context).pop();
                              Di().sl<GroupsCubit>().fetchAllGroups(
                                isLikedGroups: false,
                              );
                              return;
                            } else {
                              // Jump back to the first group and clear end state visuals
                              resetAnimations();
                              homeCubit.restartFromBeginning();
                              VxToast.show(
                                message: 'Group list reset to start',
                                icon: Assets.icons.checkGreen.path,
                              );
                            }
                          },
                        ),
                        const CustomSizedBox(height: 20),

                        //todo comment only for testing
                        // if (shouldShowPremiumCard) ...[
                        //   Padding(
                        //     padding: const EdgeInsets.symmetric(horizontal: 24),
                        //     child: const PremiumCard(),
                        //   ),
                        //   const CustomSizedBox(height: 16),
                        // ],
                        Expanded(
                          child: Stack(
                            children: [
                              AnimatedOpacity(
                                duration: const Duration(seconds: 1),
                                opacity: homeCubit.isEnd ? 0.0 : 1.0,
                                child: AnimatedBuilder(
                                  animation: checkAnimController,
                                  builder: (context, child) {
                                    return Transform.scale(
                                      alignment: Alignment.center,
                                      scale: checkScaleAnimation.value,
                                      child: Transform.translate(
                                        offset: crossSlideAnimation.value,
                                        child: Transform.scale(
                                          scale: crossSizeAnimation.value,
                                          child: Opacity(
                                            opacity: crossFadeAnimation.value,
                                            child: child,
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    height: 40,
                                    width: 40,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                          color: ColorPalette.error.withValues(
                                            alpha: .1,
                                          ),
                                          blurRadius: 5,
                                          offset: const Offset(0, 5),
                                        ),
                                      ],
                                      shape: BoxShape.circle,
                                      color: ColorPalette.error.withValues(
                                        alpha: .1,
                                      ),
                                    ),
                                    child: SvgPicture.asset(
                                      Assets.icons.error.path,
                                      height: 30,
                                      width: 30,
                                      colorFilter: ColorFilter.mode(
                                        ColorPalette.error,
                                        BlendMode.srcIn,
                                      ),
                                    ),
                                  ),
                                ),
                              ),

                              // CHECK ANIMATION
                              AnimatedOpacity(
                                duration: const Duration(milliseconds: 500),
                                opacity: homeCubit.isEnd ? 0.0 : 1.0,
                                child: AnimatedBuilder(
                                  animation: checkAnimController,
                                  builder: (context, child) {
                                    return Transform.scale(
                                      scale: checkScaleAnimation.value,
                                      alignment: Alignment.topLeft,
                                      child: Transform.translate(
                                        offset: checkSlideAnimation.value,
                                        child: Transform.scale(
                                          scale: checkSizeAnimation.value,
                                          child: Opacity(
                                            opacity: checkFadeAnimation.value,
                                            child: child,
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    height: 40,
                                    width: 40,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                          color: ColorPalette.green.withValues(
                                            alpha: .1,
                                          ),
                                          blurRadius: 5,
                                          offset: const Offset(0, 5),
                                        ),
                                      ],
                                      shape: BoxShape.circle,
                                      color: ColorPalette.green.withValues(
                                        alpha: .1,
                                      ),
                                    ),
                                    child: Image.asset(
                                      Assets.icons.checkGreen.path,
                                      height: 30,
                                      width: 30,
                                      color: ColorPalette.green,
                                    ),
                                  ),
                                ),
                              ),

                              if (homeCubit.isEnd)
                                Align(
                                  alignment: Alignment.center,
                                  child: FadeTransition(
                                    opacity: endFadeAnimation,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 24,
                                      ),
                                      child: EmptyWidget(
                                        title: 'You’re All Caught Up',
                                        description:
                                            'You’ve seen all the groups available in your area for now. New groups join regularly — check back soon.',
                                        imagePath:
                                            Assets.icons.alertTriangle.path,
                                        showButton: true,
                                        buttonText: 'Adjust Filters',
                                        onButtonTap: () {
                                          resetAnimations();
                                          AutoRouter.of(
                                            context,
                                          ).push(const FilterRoute());
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              if (homeCubit.currentGroup == null &&
                                  !homeCubit.isEnd)
                                BlocBuilder(
                                  bloc: _groupsCubit,
                                  builder: (context, state) {
                                    if (state is GroupsLoading) {
                                      return const HomeLandingSkeleton();
                                    }
                                    return Align(
                                      alignment: Alignment.center,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 24,
                                        ),
                                        child: EmptyWidget(
                                          title: widget.isLikedGroups
                                              ? 'No Likes Yet!!'
                                              : 'No Groups Available',
                                          description: widget.isLikedGroups
                                              ? 'Your group hasn’t received any likes yet. Keep swiping to get discovered and increase your chances matching.'
                                              : 'We couldn\'t find any groups right now. Try refreshing or check back soon.',
                                          imagePath: widget.isLikedGroups
                                              ? Assets.icons.noLikes.path
                                              : Assets.icons.alertTriangle.path,
                                          showButton: true,
                                          buttonText: widget.isLikedGroups
                                              ? 'Explore Groups'
                                              : 'Refresh',
                                          onButtonTap: widget.isLikedGroups
                                              ? () async {
                                                  AutoRouter.of(context).pop();
                                                  Di()
                                                      .sl<DashboardCubit>()
                                                      .changeIndex(0);
                                                  await _groupsCubit
                                                      .fetchAllGroups(
                                                        isLikedGroups: false,
                                                      );
                                                }
                                              : () {
                                                  _groupsCubit.fetchAllGroups(
                                                    isLikedGroups:
                                                        widget.isLikedGroups,
                                                  );
                                                },
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              BlocBuilder(
                                bloc: homeCubit,
                                builder: (context, state) {
                                  final bool isDragging =
                                      swipeController.isDragging;
                                  final double nextYOffset = _nextCardYOffset(
                                    context,
                                    homeCubit.xAxisCardValue,
                                  );

                                  void handleAnim(SwipeResult result) {
                                    homeCubit.selectProfileIndex(null);
                                    // animate next card half → top
                                    nextCardSettleController
                                        .forward(from: 0)
                                        .whenComplete(() {
                                          homeCubit.onSwipeCompleted(result);
                                          resetAnimations();

                                          if (homeCubit.isEndOfList) {
                                            endFadeController.forward();
                                            homeCubit.markEndReached();
                                          }
                                        });
                                    if (homeCubit.nextGroup != null) {
                                      // checkAnimController
                                      // .forward(from: 0)
                                      // .whenComplete(() {
                                      homeCubit.updateCardPosition(0);
                                      checkAnimController.reset();
                                      checkAnimationController.reset();
                                      crossAnimationController.reset();
                                      // });
                                    }
                                    // animate top card out
                                    topCardController
                                        .forward(from: 0)
                                        .whenComplete(() {});
                                  }

                                  return Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      if (homeCubit.nextGroup != null) ...[
                                        /// 🔹 NEXT CARD
                                        isDragging
                                            ? Transform.translate(
                                                offset: Offset(0, nextYOffset),
                                                child: HomeCardDesign(
                                                  group: homeCubit.nextGroup,
                                                  onTapLeft: () {
                                                    // Dislike API call
                                                    _groupsCubit
                                                        .likeDislikeGroup(
                                                          groupId:
                                                              homeCubit
                                                                  .nextGroup
                                                                  ?.id ??
                                                              '',
                                                          type: 'dislike',
                                                        );
                                                    swipeController
                                                        .swipeProgrammatically(
                                                          toRight: false,
                                                          screenSize:
                                                              MediaQuery.of(
                                                                context,
                                                              ).size,
                                                        );
                                                    homeCubit.sController
                                                        .animateTo(
                                                          0,
                                                          duration: Duration(
                                                            milliseconds: 300,
                                                          ),
                                                          curve:
                                                              Curves.easeInOut,
                                                        );
                                                    final result =
                                                        swipeController
                                                            .onDragEnd(
                                                              MediaQuery.of(
                                                                context,
                                                              ).size,
                                                            );
                                                    handleAnim(result);
                                                  },
                                                  onTapRight: () {
                                                    // Like API call
                                                    _groupsCubit
                                                        .likeDislikeGroup(
                                                          groupId:
                                                              homeCubit
                                                                  .nextGroup
                                                                  ?.id ??
                                                              '',
                                                          type: 'like',
                                                        );
                                                    homeCubit.sController
                                                        .animateTo(
                                                          0,
                                                          duration: Duration(
                                                            milliseconds: 300,
                                                          ),
                                                          curve:
                                                              Curves.easeInOut,
                                                        );
                                                    swipeController
                                                        .swipeProgrammatically(
                                                          toRight: true,
                                                          screenSize:
                                                              MediaQuery.of(
                                                                context,
                                                              ).size,
                                                        );
                                                    final result =
                                                        swipeController
                                                            .onDragEnd(
                                                              MediaQuery.of(
                                                                context,
                                                              ).size,
                                                            );
                                                    handleAnim(result);
                                                  },
                                                ),
                                              )
                                            : Opacity(
                                                opacity:
                                                    nextCardSettleController
                                                        .isAnimating
                                                    ? 1
                                                    : 0,
                                                child: SlideTransition(
                                                  position:
                                                      Tween(
                                                        begin: Offset(0, 0.4),
                                                        end: Offset.zero,
                                                      ).animate(
                                                        nextCardSettleController,
                                                      ),
                                                  child: HomeCardDesign(
                                                    group: homeCubit.nextGroup,
                                                    onTapLeft: () {
                                                      // Dislike API call
                                                      _groupsCubit
                                                          .likeDislikeGroup(
                                                            groupId:
                                                                homeCubit
                                                                    .nextGroup
                                                                    ?.id ??
                                                                '',
                                                            type: 'dislike',
                                                          );
                                                      homeCubit.sController
                                                          .animateTo(
                                                            0,
                                                            duration: Duration(
                                                              milliseconds: 300,
                                                            ),
                                                            curve: Curves
                                                                .easeInOut,
                                                          );
                                                      swipeController
                                                          .swipeProgrammatically(
                                                            toRight: false,
                                                            screenSize:
                                                                MediaQuery.of(
                                                                  context,
                                                                ).size,
                                                          );
                                                      final result =
                                                          swipeController
                                                              .onDragEnd(
                                                                MediaQuery.of(
                                                                  context,
                                                                ).size,
                                                              );
                                                      handleAnim(result);
                                                    },
                                                    onTapRight: () {
                                                      // Like API call
                                                      _groupsCubit
                                                          .likeDislikeGroup(
                                                            groupId:
                                                                homeCubit
                                                                    .nextGroup
                                                                    ?.id ??
                                                                '',
                                                            type: 'like',
                                                          );
                                                      homeCubit.sController
                                                          .animateTo(
                                                            0,
                                                            duration: Duration(
                                                              milliseconds: 300,
                                                            ),
                                                            curve: Curves
                                                                .easeInOut,
                                                          );
                                                      swipeController
                                                          .swipeProgrammatically(
                                                            toRight: true,
                                                            screenSize:
                                                                MediaQuery.of(
                                                                  context,
                                                                ).size,
                                                          );
                                                      final result =
                                                          swipeController
                                                              .onDragEnd(
                                                                MediaQuery.of(
                                                                  context,
                                                                ).size,
                                                              );
                                                      handleAnim(result);
                                                    },
                                                  ),
                                                ),
                                              ),
                                      ],
                                      if (homeCubit.currentGroup != null)
                                        /// 🔹 TOP CARD
                                        SlideTransition(
                                          position: topCardSlide,
                                          child: SwipeCard(
                                            controller: swipeController,
                                            onSwipe: (result) {
                                              if (result != SwipeResult.none) {
                                                final groupId =
                                                    homeCubit
                                                        .currentGroup
                                                        ?.id ??
                                                    '';
                                                if (groupId.isNotEmpty) {
                                                  _groupsCubit.likeDislikeGroup(
                                                    groupId: groupId,
                                                    type:
                                                        result ==
                                                            SwipeResult.right
                                                        ? 'like'
                                                        : 'dislike',
                                                  );
                                                }
                                                handleAnim(result);
                                              }
                                            },
                                            child: HomeCardDesign(
                                              group: homeCubit.currentGroup,
                                              onTapLeft: () {
                                                // Dislike API call
                                                _groupsCubit.likeDislikeGroup(
                                                  groupId:
                                                      homeCubit
                                                          .currentGroup
                                                          ?.id ??
                                                      '',
                                                  type: 'dislike',
                                                );
                                                homeCubit.sController.animateTo(
                                                  0,
                                                  duration: Duration(
                                                    seconds: 1,
                                                  ),
                                                  curve: Curves.easeInOut,
                                                );
                                                swipeController
                                                    .swipeProgrammatically(
                                                      toRight: false,
                                                      screenSize: MediaQuery.of(
                                                        context,
                                                      ).size,
                                                    );
                                                final result = swipeController
                                                    .onDragEnd(
                                                      MediaQuery.of(
                                                        context,
                                                      ).size,
                                                    );
                                                handleAnim(result);
                                              },
                                              onTapRight: () {
                                                // Like API call
                                                _groupsCubit.likeDislikeGroup(
                                                  groupId:
                                                      homeCubit
                                                          .currentGroup
                                                          ?.id ??
                                                      '',
                                                  type: 'like',
                                                );
                                                homeCubit.sController.animateTo(
                                                  0,
                                                  duration: Duration(
                                                    seconds: 1,
                                                  ),
                                                  curve: Curves.easeInOut,
                                                );
                                                swipeController
                                                    .swipeProgrammatically(
                                                      toRight: true,
                                                      screenSize: MediaQuery.of(
                                                        context,
                                                      ).size,
                                                    );
                                                final result = swipeController
                                                    .onDragEnd(
                                                      MediaQuery.of(
                                                        context,
                                                      ).size,
                                                    );
                                                handleAnim(result);
                                              },
                                            ),
                                          ),
                                        ),
                                    ],
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    // Blur overlay shown only when bottom sheets are open
                    ValueListenableBuilder<bool>(
                      valueListenable: HomeBlurController.isBlurred,
                      builder: (context, isBlurred, _) {
                        if (!isBlurred) return const SizedBox.shrink();
                        return Positioned.fill(
                          child: IgnorePointer(
                            ignoring: true,
                            child: BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                              child: Container(
                                color: Colors.black.withValues(alpha: 0.25),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
      floatingActionButton: BlocBuilder(
        bloc: homeCubit,
        builder: (context, state) {
          if (homeCubit.selectedProfile != null &&
              !homeCubit.isEnd &&
              (homeCubit.selectedProfile?.bestShorts?.isNotEmpty ?? false)) {
            return GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () async {
                await HomeBlurController.showWithBlur(
                  context: context,
                  builder: (context) => SendPokeBottomSheet(
                    pokeType: PokeType.floating,
                    image:
                        homeCubit.selectedProfile?.images?.first ??
                        homeCubit.selectedProfile?.bestShorts?.first ??
                        '',
                    promptTitle: homeCubit.selectedProfile?.promptTitle
                        ?.toString(),
                    promptAnswer: homeCubit.selectedProfile?.promptAnswer
                        ?.toString(),
                  ),
                );
              },
              child: Container(
                height: 56,
                width: 56,
                margin: const EdgeInsets.only(bottom: 110, right: 16),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: ColorPalette.primary,
                  shape: BoxShape.circle,
                ),
                child: Text(
                  AppEmojis.pointingRight,
                  style: AppTextStyles.h4(context),
                ),
              ),
            );
          }
          return SizedBox.shrink();
        },
      ),
    );
  }
}
