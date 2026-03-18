import 'dart:ui';

import 'package:auto_route/auto_route.dart';
import 'package:fennac_app/app/theme/app_colors.dart';
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

@RoutePage()
class GetPockedScreen extends StatelessWidget {
  final Group group;

  const GetPockedScreen({super.key, required this.group});

  @override
  Widget build(BuildContext context) {
    final poker = group.members?.first;

    return Scaffold(
      backgroundColor: ColorPalette.black,
      body: Stack(
        children: [
          MovableBackground(
            backgroundType: MovableBackgroundType.medium,
            child: Column(
              children: [
                CustomSizedBox(height: 40),
                CustomBackButton(),

                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        PokeImageCard(
                          imageUrl:
                              (poker?.images?.isNotEmpty == true
                                  ? poker?.images!.first
                                  : poker?.coverImage) ??
                              '',
                        ),

                        const CustomSizedBox(height: 20),

                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          child: PokeMessageBubble(),
                        ),

                        const CustomSizedBox(height: 40),
                      ],
                    ),
                  ),
                ),
                // Bottom Card
                if (poker != null)
                  PokeNotificationCard(
                    group: group,
                    poker:
                        poker ??
                        Member(id: '', name: 'Unknown', coverImage: ''),
                    onIgnore: () {
                      AutoRouter.of(context).pop();
                    },
                    onStartChat: () {
                      AutoRouter.of(context).push(
                        GroupChatRoute(
                          isGroup: false,
                          groupId: group.id ?? '',
                          contactName: poker.name ?? '',
                          isOnline: true,
                          contactAvatar: poker.coverImage ?? '',
                        ),
                      );
                    },
                  ),
              ],
            ),
          ),
          // Blur overlay that appears when bottom sheet is opened
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
    );
  }
}
