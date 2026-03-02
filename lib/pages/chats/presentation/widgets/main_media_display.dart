import 'dart:io';

import 'package:fennac_app/app/theme/app_colors.dart';
import 'package:fennac_app/core/extensions/string_extension.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class MainMediaDisplay extends StatefulWidget {
  final String message;

  const MainMediaDisplay({super.key, required this.message});

  @override
  State<MainMediaDisplay> createState() => _MainMediaDisplayState();
}

class _MainMediaDisplayState extends State<MainMediaDisplay> {
  VideoPlayerController? _videoPlayerController;

  bool get isVideo => widget.message.isVideo;

  @override
  void initState() {
    super.initState();
    if (isVideo) {
      _videoPlayerController = VideoPlayerController.file(File(widget.message))
        ..initialize().then((_) {
          if (mounted) setState(() {});
        });
    }
  }

  @override
  void dispose() {
    _videoPlayerController?.dispose();
    super.dispose();
  }

  void _togglePlayPause() {
    final controller = _videoPlayerController;
    if (controller == null) return;

    setState(() {
      controller.value.isPlaying ? controller.pause() : controller.play();
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!isVideo) {
      return Image.file(File(widget.message), fit: BoxFit.cover);
    }

    final controller = _videoPlayerController;

    if (controller == null || !controller.value.isInitialized) {
      return const Center(child: CircularProgressIndicator());
    }

    return Stack(
      alignment: Alignment.center,
      children: [
        AspectRatio(
          aspectRatio: controller.value.aspectRatio,
          child: VideoPlayer(controller),
        ),
        GestureDetector(
          onTap: _togglePlayPause,
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: ColorPalette.black.withValues(alpha: 0.4),
              shape: BoxShape.circle,
            ),
            child: Icon(
              controller.value.isPlaying
                  ? Icons.pause_rounded
                  : Icons.play_arrow_rounded,
              color: ColorPalette.white,
              size: 48,
            ),
          ),
        ),
      ],
    );
  }
}
