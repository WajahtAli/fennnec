import 'package:auto_route/auto_route.dart';
import 'package:fennac_app/app/theme/app_colors.dart';
import 'package:fennac_app/app/theme/text_styles.dart';
import 'package:fennac_app/pages/chats/data/models/message_model.dart';
import 'package:fennac_app/pages/chats/presentation/widgets/main_media_display.dart';
import 'package:fennac_app/pages/chats/presentation/widgets/media_header.dart';
import 'package:fennac_app/pages/chats/presentation/widgets/thumbnail_strip.dart';
import 'package:fennac_app/reusable_widgets/custom_app_bar.dart';
import 'package:fennac_app/widgets/movable_background.dart';
import 'package:flutter/material.dart';

import '../../../../core/di_container.dart';
import '../bloc/cubit/message_cubit.dart';

@RoutePage()
class MediaPreviewScreen extends StatefulWidget {
  final List<MessageModel> messages;
  final int initialIndex;

  const MediaPreviewScreen({
    super.key,
    required this.messages,
    required this.initialIndex,
  });

  @override
  State<MediaPreviewScreen> createState() => _MediaPreviewScreenState();
}

class _MediaPreviewScreenState extends State<MediaPreviewScreen> {
  late int _currentIndex;
  // late PageController _pageController; // PageView logic if swiping is needed

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
    // _pageController = PageController(initialPage: _currentIndex);
  }

  @override
  Widget build(BuildContext context) {
    final media = Di().sl<MessageCubit>().getMedias();
    // Safety check
    if (widget.messages.isEmpty) {
      return Scaffold(
        body: MovableBackground(
          backgroundType: MovableBackgroundType.dark,
          child: Column(
            children: [
              CustomAppBar(title: 'Shared by Nancy'),
              Center(
                child: Text("No Media", style: AppTextStyles.body(context)),
              ),
            ],
          ),
        ),
      );
    }

    // Ensure index is valid
    if (_currentIndex >= media.length) {
      _currentIndex = 0;
    }
    final currentMessage = media[_currentIndex];

    return Scaffold(
      backgroundColor: ColorPalette.black,
      body: MovableBackground(
        backgroundType: MovableBackgroundType.dark,
        child: Column(
          children: [
            MediaHeader(
              title:
                  'Shared by ${widget.messages.first.mentionedUserName ?? ''} ',
            ),
            Expanded(
              child: Stack(
                children: [
                  Positioned.fill(
                    child: MainMediaDisplay(
                      key: ValueKey(currentMessage),
                      message: currentMessage,
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: SafeArea(
                      child: ThumbnailStrip(
                        messages: widget.messages,
                        selectedIndex: _currentIndex,
                        onMessageSelected: (index) {
                          setState(() {
                            _currentIndex = index;
                            // _pageController.jumpToPage(index); // if using PageView
                          });
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
