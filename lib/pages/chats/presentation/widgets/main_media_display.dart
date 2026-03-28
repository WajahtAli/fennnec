import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:fennac_app/app/theme/app_colors.dart';
import 'package:fennac_app/core/extensions/string_extension.dart';
import 'package:fennac_app/generated/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:video_player/video_player.dart';

class MainMediaDisplay extends StatefulWidget {
  final String message;

  const MainMediaDisplay({super.key, required this.message});

  @override
  State<MainMediaDisplay> createState() => _MainMediaDisplayState();
}

class _MainMediaDisplayState extends State<MainMediaDisplay> {
  VideoPlayerController? _controller;
  bool _isInitializing = false;

  String get _normalizedMessage {
    var value = widget.message.trim();

    while (value.startsWith('/http') || value.startsWith('/https')) {
      value = value.substring(1);
    }

    if (value.startsWith('http:/') && !value.startsWith('http://')) {
      value = value.replaceFirst('http:/', 'http://');
    }

    if (value.startsWith('https:/') && !value.startsWith('https://')) {
      value = value.replaceFirst('https:/', 'https://');
    }

    return value;
  }

  Uri? get _networkUri {
    final uri = Uri.tryParse(_normalizedMessage);
    if (uri == null) return null;
    if (uri.scheme == 'http' || uri.scheme == 'https') return uri;
    return null;
  }

  bool get isVideo => _normalizedMessage.isVideo;
  bool get isNetwork => _networkUri != null;

  @override
  void initState() {
    super.initState();
    _initializeMedia();
  }

  @override
  void didUpdateWidget(covariant MainMediaDisplay oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.message != widget.message) {
      _disposeController();
      _initializeMedia();
    }
  }

  Future<void> _initializeMedia() async {
    if (!isVideo) return;

    try {
      _isInitializing = true;

      if (isNetwork) {
        final cachedFile = await DefaultCacheManager().getSingleFile(
          _networkUri.toString(),
        );
        _controller = VideoPlayerController.file(cachedFile);
      } else {
        _controller = VideoPlayerController.file(File(_normalizedMessage));
      }

      await _controller!.initialize();

      _controller!
        ..setLooping(true)
        ..setVolume(1.0);

      if (mounted) setState(() {});
    } catch (e) {
      debugPrint("Video init error: $e");
    } finally {
      _isInitializing = false;
    }
  }

  void _disposeController() {
    _controller?.dispose();
    _controller = null;
  }

  @override
  void dispose() {
    _disposeController();
    super.dispose();
  }

  void _togglePlayPause() {
    final controller = _controller;
    if (controller == null || !controller.value.isInitialized) return;

    setState(() {
      controller.value.isPlaying ? controller.pause() : controller.play();
    });
  }

  @override
  Widget build(BuildContext context) {
    // ✅ IMAGE HANDLING
    if (!isVideo) {
      if (isNetwork && _normalizedMessage.isImage) {
        return CachedNetworkImage(
          imageUrl: _networkUri.toString(),
          fit: BoxFit.cover,
          placeholder: (_, __) =>
              Center(child: Lottie.asset(Assets.animations.loadingSpinner)),
          errorWidget: (_, __, ___) =>
              const Center(child: Icon(Icons.broken_image_rounded)),
        );
      }

      return Image.file(
        File(_normalizedMessage),
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) =>
            const Center(child: Icon(Icons.broken_image_rounded)),
      );
    }

    // ✅ VIDEO LOADING STATE
    if (_isInitializing ||
        _controller == null ||
        !_controller!.value.isInitialized) {
      return Center(child: Lottie.asset(Assets.animations.loadingSpinner));
    }

    final controller = _controller!;

    // ✅ VIDEO PLAYER UI
    return Stack(
      alignment: Alignment.center,
      children: [
        AspectRatio(
          aspectRatio: controller.value.aspectRatio == 0
              ? 16 / 9
              : controller.value.aspectRatio,
          child: VideoPlayer(controller),
        ),

        // Play/Pause Overlay
        GestureDetector(
          onTap: _togglePlayPause,
          child: AnimatedOpacity(
            duration: const Duration(milliseconds: 200),
            opacity: controller.value.isPlaying ? 0.0 : 1.0,
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
        ),
      ],
    );
  }
}
