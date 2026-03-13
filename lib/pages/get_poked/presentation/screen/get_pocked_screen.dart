import 'dart:ui';

import 'package:auto_route/auto_route.dart';
import 'package:fennac_app/app/theme/app_colors.dart';
import 'package:fennac_app/core/di_container.dart';
import 'package:fennac_app/pages/chats/data/models/chat_and_calls_response.dart';
import 'package:fennac_app/pages/get_poked/presentation/bloc/cubit/poke_detail_cubit.dart';
import 'package:fennac_app/pages/get_poked/presentation/bloc/state/poke_detail_state.dart';
import 'package:fennac_app/pages/get_poked/presentation/widgets/poke_image_card.dart';
import 'package:fennac_app/pages/get_poked/presentation/widgets/poke_message_bubble.dart';
import 'package:fennac_app/pages/get_poked/presentation/widgets/poke_notification_card.dart';
import 'package:fennac_app/pages/home/data/models/groups_model.dart';
import 'package:fennac_app/pages/home/presentation/blur_controller.dart';
import 'package:fennac_app/routes/routes_imports.gr.dart';
import 'package:fennac_app/widgets/custom_back_button.dart';
import 'package:fennac_app/widgets/custom_sized_box.dart';
import 'package:fennac_app/widgets/movable_background.dart';
import 'package:fennac_app/widgets/prompt_audio_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class GetPockedScreen extends StatefulWidget {
  final Group group;

  const GetPockedScreen({super.key, required this.group});

  @override
  State<GetPockedScreen> createState() => _GetPockedScreenState();
}

class _GetPockedScreenState extends State<GetPockedScreen> {
  late final PokeDetailCubit _pokeDetailCubit;
  Member? _sender;

  @override
  void initState() {
    super.initState();
    _pokerFallback();
    _pokeDetailCubit = Di().sl<PokeDetailCubit>();
    _pokeDetailCubit.fetchPokeDetail(widget.group.id ?? '');
  }

  void _pokerFallback() {
    if (widget.group.members != null && widget.group.members!.isNotEmpty) {
      _sender = widget.group.members!.first;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _pokeDetailCubit,
      child: BlocListener<PokeDetailCubit, PokeDetailState>(
        listener: (context, state) {
          if (state is PokeDetailLoaded) {
            final fromUser = state.response.data.fromUser;
            _sender = Member(
              id: fromUser.id,
              name: '${fromUser.firstName} ${fromUser.lastName}',
              coverImage: fromUser.bestShorts.isNotEmpty ? fromUser.bestShorts.first : '',
            );
          } else if (state is PokeStartChatSuccess) {
            AutoRouter.of(context).push(
              GroupChatRoute(
                isGroup: false,
                groupId: state.response.data.chatWithUserId,
                contactName: _sender?.name ?? widget.group.name ?? 'Chat',
                isOnline: true,
                contactAvatar: _sender?.coverImage ?? '',
              ),
            );
          } else if (state is PokeStartChatError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Failed to start chat: ${state.message}')),
            );
          }
        },
        child: Scaffold(
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
                      child: BlocBuilder<PokeDetailCubit, PokeDetailState>(
                        builder: (context, state) {
                          if (state is PokeDetailLoading) {
                            return const Center(child: CircularProgressIndicator());
                          } else if (state is PokeDetailError) {
                            return Center(
                                child: Text('Error: ${state.message}',
                                    style: const TextStyle(color: Colors.white)));
                          } else {
                            // Try to get data from current or previous state
                            PokeDetailData? pokeData;
                            if (state is PokeDetailLoaded) {
                              pokeData = state.response.data;
                            } else {
                              final currentState = _pokeDetailCubit.state;
                              if (currentState is PokeDetailLoaded) {
                                pokeData = currentState.response.data;
                              }
                            }

                            if (pokeData == null) return const SizedBox.shrink();

                            return SingleChildScrollView(
                              child: Column(
                                children: [
                                  if (pokeData.pokedTargetDetail.type == 'photo')
                                    PokeImageCard(
                                      imageUrl: pokeData.pokedTargetDetail.photo?.url ?? '',
                                    )
                                  else if (pokeData.pokedTargetDetail.type == 'audio')
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 24),
                                      child: PromptAudioRow(
                                        audioPath: pokeData.pokedTargetDetail.audio?.url ?? '',
                                      ),
                                    )
                                  else if (pokeData.pokedTargetDetail.type == 'text')
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 24),
                                      child: PokeMessageBubble(
                                        message: pokeData.pokedTargetDetail.text ??
                                            pokeData.poke.message,
                                      ),
                                    ),
                                  const CustomSizedBox(height: 20),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 24),
                                    child: PokeMessageBubble(
                                      message: pokeData.poke.message,
                                    ),
                                  ),
                                  const CustomSizedBox(height: 40),
                                ],
                              ),
                            );
                          }
                        },
                      ),
                    ),
                    // Bottom Card
                    BlocBuilder<PokeDetailCubit, PokeDetailState>(
                      builder: (context, state) {
                        bool isLoading = state is PokeStartChatLoading;

                        if (_sender == null) return const SizedBox.shrink();

                        return Stack(
                          children: [
                            PokeNotificationCard(
                              group: widget.group,
                              poker: _sender!,
                              onIgnore: () {
                                AutoRouter.of(context).pop();
                              },
                              onStartChat: () {
                                _pokeDetailCubit.startChat(widget.group.id ?? '');
                              },
                            ),
                            if (isLoading)
                              Positioned.fill(
                                child: Container(
                                  decoration: const BoxDecoration(
                                    color: Colors.black26,
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(32),
                                      topRight: Radius.circular(32),
                                    ),
                                  ),
                                  child: const Center(child: CircularProgressIndicator()),
                                ),
                              ),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),
              // Blur overlay
              ValueListenableBuilder<bool>(
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
