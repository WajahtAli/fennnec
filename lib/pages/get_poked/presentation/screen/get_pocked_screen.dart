import 'dart:ui';
import 'package:auto_route/auto_route.dart';
import 'package:fennac_app/app/theme/app_colors.dart';
import 'package:fennac_app/pages/chats/data/models/chat_and_calls_response.dart';
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
  @override
  void initState() {
    super.initState();
    final id = widget.pokeId ?? widget.group?.id;
    if (id != null) {
      Di().sl<GetPokedDetailsCubit>().fetchPokeDetail(id);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GetPokedDetailsCubit, GetPokedDetailsState>(
      bloc: Di().sl<GetPokedDetailsCubit>(),
      listener: (context, state) {
        if (state is GetPokedDetailsChatStarted) {
          context.router.replace(
            GroupChatRoute(
              isGroup: false,
              groupId: state.startChatData.chatWithUserId,
            ),
          );
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
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              PokeImageCard(
                                imageUrl: _getImageForTarget(target, fromUser),
                                isAsset: false,
                              ),
                              const CustomSizedBox(height: 20),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 24,
                                ),
                                child: PokeMessageBubble(
                                  message: detail.poke.message,
                                ),
                              ),
                              const CustomSizedBox(height: 40),
                            ],
                          ),
                        ),
                      ),
                      PokeNotificationCard(
                        fromUser: fromUser,
                        targetDetail: target,
                        onIgnore: () => context.router.pop(),
                        onStartChat: () {
                          Di().sl<GetPokedDetailsCubit>().startChat(
                            detail.poke.id,
                          );
                          // VxToast.show(message: 'Chat feature coming soon!');
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

  String _getImageForTarget(PokedTargetDetail target, PokerFromUser fromUser) {
    if (target.type == 'profile' && target.profile != null) {
      return target.profile!.bestShorts.isNotEmpty
          ? target.profile!.bestShorts.first
          : '';
    } else if (target.type == 'photo' && target.photo != null) {
      return target.photo!.url;
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
