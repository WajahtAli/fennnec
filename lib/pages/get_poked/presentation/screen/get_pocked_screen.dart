import 'dart:ui';
import 'package:auto_route/auto_route.dart';
import 'package:fennac_app/app/theme/app_colors.dart';
import 'package:fennac_app/pages/chats/data/models/chat_and_calls_response.dart';
import 'package:fennac_app/pages/chats/presentation/bloc/cubit/chat_landing_cubit.dart';
import 'package:fennac_app/pages/dashboard/presentation/bloc/cubit/dashboard_cubit.dart';
import 'package:fennac_app/pages/get_poked/presentation/bloc/cubit/get_poked_details_cubit.dart';
import 'package:fennac_app/pages/get_poked/presentation/bloc/state/get_poked_details_state.dart';
import 'package:fennac_app/pages/get_poked/presentation/widgets/poke_image_card.dart';
import 'package:fennac_app/pages/get_poked/presentation/widgets/poke_message_bubble.dart';
import 'package:fennac_app/pages/get_poked/presentation/widgets/poke_notification_card.dart';
import 'package:fennac_app/pages/home/data/models/groups_model.dart';
import 'package:fennac_app/pages/home/presentation/blur_controller.dart';
import 'package:fennac_app/routes/routes_imports.gr.dart';
import 'package:fennac_app/widgets/custom_back_button.dart';
import 'package:fennac_app/widgets/custom_sized_box.dart';
import 'package:fennac_app/widgets/movable_background.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fennac_app/core/di_container.dart';
import 'package:fennac_app/skeletons/get_pocked_skeleton.dart';

@RoutePage()
class GetPockedScreen extends StatefulWidget {
  final Group? group;
  final String? pokeId;

  const GetPockedScreen({super.key, this.group, this.pokeId});

  @override
  State<GetPockedScreen> createState() => _GetPockedScreenState();
}

class _GetPockedScreenState extends State<GetPockedScreen> {
  late final PageController _pageController;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    final id = widget.pokeId ?? widget.group?.id;
    if (id != null) {
      Di().sl<GetPokedDetailsCubit>().fetchPokeDetail(id);
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GetPokedDetailsCubit, GetPokedDetailsState>(
      bloc: Di().sl<GetPokedDetailsCubit>(),
      listener: (context, state) {
        if (state is GetPokedDetailsChatStarted) {
          Di().sl<ChatLandingCubit>().fetchChatsAndCalls();

          Di().sl<DashboardCubit>().changeIndex(1);
          context.router.popUntilRoot();
          // context.router.replace(
          //   GroupChatRoute(
          //     isGroup: false,
          //     groupId: state.startChatData.chatWithUserId,
          //   ),
          // );
        }
      },
      builder: (context, state) {
        if (state is GetPokedDetailsLoading) {
          return const GetPockedSkeleton();
        }

        if (state is GetPokedDetailsError) {
          return Scaffold(
            backgroundColor: ColorPalette.black,
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    state.message,
                    style: const TextStyle(color: Colors.white),
                  ),
                  const CustomSizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      final id = widget.pokeId ?? widget.group?.id;
                      if (id != null) {
                        Di().sl<GetPokedDetailsCubit>().fetchPokeDetail(id);
                      }
                    },
                    child: const Text('Retry'),
                  ),
                ],
              ),
            ),
          );
        }

        if (state is GetPokedDetailsLoaded) {
          final detail = state.pokeDetail;
          final fromUser = detail.fromUser;
          final target = detail.pokedTargetDetail;
          final pokes = detail.pokes.isNotEmpty ? detail.pokes : [detail.poke];
          final isCircular = target.type == 'profile';

          return Scaffold(
            backgroundColor: ColorPalette.black,
            body: Stack(
              children: [
                MovableBackground(
                  backgroundType: MovableBackgroundType.medium,
                  child: Column(
                    children: [
                      const CustomSizedBox(height: 40),
                      const CustomBackButton(),
                      Expanded(
                        child: Column(
                          children: [
                            Expanded(
                              child: PageView.builder(
                                controller: _pageController,
                                itemCount: pokes.length,
                                onPageChanged: (index) {
                                  setState(() => _currentPage = index);
                                },
                                itemBuilder: (context, index) {
                                  final poke = pokes[index];
                                  return SingleChildScrollView(
                                    child: Column(
                                      children: [
                                        const CustomSizedBox(height: 20),
                                        PokeImageCard(
                                          imageUrl: _getImageForTarget(
                                            poke,
                                            fromUser,
                                          ),
                                          isAsset: false,
                                          isCircular: isCircular,
                                        ),
                                        const CustomSizedBox(height: 20),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 24,
                                          ),
                                          child: PokeMessageBubble(
                                            message: poke?.message ?? "",
                                          ),
                                        ),
                                        const CustomSizedBox(height: 20),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                            if (pokes.length > 1)
                              Padding(
                                padding: const EdgeInsets.only(bottom: 12),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: List.generate(
                                    pokes.length,
                                    (index) => AnimatedContainer(
                                      duration: const Duration(
                                        milliseconds: 300,
                                      ),
                                      margin: const EdgeInsets.symmetric(
                                        horizontal: 4,
                                      ),
                                      width: _currentPage == index ? 20 : 8,
                                      height: 8,
                                      decoration: BoxDecoration(
                                        color: _currentPage == index
                                            ? ColorPalette.primary
                                            : ColorPalette.white.withValues(
                                                alpha: 0.4,
                                              ),
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                      PokeNotificationCard(
                        fromUser: fromUser,
                        targetDetail: target,
                        pokeCount: pokes.length,
                        activeGroup: detail.activeGroup,
                        onIgnore: () => context.router.pop(),
                        onStartChat: () {
                          Di().sl<GetPokedDetailsCubit>().startChat(
                            pokes[_currentPage]?.id ?? "",
                          );
                        },
                      ),
                    ],
                  ),
                ),
                _buildBlurOverlay(),
              ],
            ),
          );
        }

        return Scaffold(backgroundColor: ColorPalette.black);
      },
    );
  }

  String _getImageForTarget(PokeModel? target, PokerFromUser fromUser) {
    if (target?.targetType == 'prompt' && target?.targetPrompt != null) {
      return fromUser.bestShorts.isNotEmpty ? fromUser.bestShorts.first : '';
    } else if (target?.targetType == 'photo' && target?.targetPhoto != null) {
      return target?.targetPhoto?.url ?? "";
    }
    return fromUser.bestShorts.isNotEmpty ? fromUser.bestShorts.first : '';
  }

  Widget _buildBlurOverlay() {
    return ValueListenableBuilder<bool>(
      valueListenable: HomeBlurController.isBlurred,
      builder: (context, isBlurred, child) {
        if (!isBlurred) return const SizedBox.shrink();

        return Positioned.fill(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
            child: Container(color: Colors.black.withOpacity(0.3)),
          ),
        );
      },
    );
  }
}
