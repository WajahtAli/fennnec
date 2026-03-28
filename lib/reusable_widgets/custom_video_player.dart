import 'dart:io';

import 'package:fennac_app/app/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

enum VideoSourceType { network, file, asset }

class CustomVideoPlayer extends StatefulWidget {
  final String videoUrl;
  final VideoSourceType? sourceType;
  final bool autoPlay;
  final bool looping;
  final bool showControls;
  final double? aspectRatio;
  final BoxFit fit;
  final double? width;
  final double? height;
  final BorderRadiusGeometry? borderRadius;

  const CustomVideoPlayer({
    super.key,
    required this.videoUrl,
    this.sourceType,
    this.autoPlay = false,
    this.looping = false,
    this.showControls = true,
    this.aspectRatio,
    this.fit = BoxFit.cover,
    this.width = double.infinity,
    this.height = 400,
    this.borderRadius,
  });

  @override
  State<CustomVideoPlayer> createState() => _CustomVideoPlayerState();
}

class _CustomVideoPlayerState extends State<CustomVideoPlayer> {
  late VideoPlayerController _controller;
  bool _isInitialized = false;
  bool _hasError = false;
  bool _showControlsOverlay = true;
  bool _isMuted = false;

  String get _normalizedVideoUrl {
    var value = widget.videoUrl.trim();

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

  VideoSourceType _resolveSourceType(
    String value,
    VideoSourceType? explicitType,
  ) {
    if (explicitType != null) {
      return explicitType;
    }

    final uri = Uri.tryParse(value);
    if (uri != null && (uri.scheme == 'http' || uri.scheme == 'https')) {
      return VideoSourceType.network;
    }

    if (value.startsWith('assets/')) {
      return VideoSourceType.asset;
    }

    return VideoSourceType.file;
  }

  VideoSourceType get _effectiveSourceType {
    return _resolveSourceType(_normalizedVideoUrl, widget.sourceType);
  }

  @override
  void initState() {
    super.initState();
    _initializePlayer();
  }

  Future<void> _initializePlayer() async {
    setState(() {
      _isInitialized = false;
      _hasError = false;
    });

    try {
      switch (_effectiveSourceType) {
        case VideoSourceType.network:
          _controller = VideoPlayerController.networkUrl(
            Uri.parse(_normalizedVideoUrl),
          );
          break;
        case VideoSourceType.file:
          _controller = VideoPlayerController.file(File(_normalizedVideoUrl));
          break;
        case VideoSourceType.asset:
          _controller = VideoPlayerController.asset(_normalizedVideoUrl);
          break;
      }

      await _controller.initialize();
      await _controller.setLooping(widget.looping);

      if (widget.autoPlay) {
        await _controller.play();
        _showControlsOverlay = false;
      }

      if (mounted) {
        setState(() {
          _isInitialized = true;
        });
      }

      _controller.addListener(_videoListener);
    } catch (e) {
      debugPrint("Error initializing video player: $e");
      if (mounted) {
        setState(() {
          _hasError = true;
        });
      }
    }
  }

  void _videoListener() {
    if (_controller.value.hasError && !_hasError) {
      setState(() {
        _hasError = true;
      });
    }
    // Update state to reflect play/pause in case it changes externally
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void didUpdateWidget(covariant CustomVideoPlayer oldWidget) {
    super.didUpdateWidget(oldWidget);

    var oldNormalized = oldWidget.videoUrl.trim();
    while (oldNormalized.startsWith('/http') ||
        oldNormalized.startsWith('/https')) {
      oldNormalized = oldNormalized.substring(1);
    }
    if (oldNormalized.startsWith('http:/') &&
        !oldNormalized.startsWith('http://')) {
      oldNormalized = oldNormalized.replaceFirst('http:/', 'http://');
    }
    if (oldNormalized.startsWith('https:/') &&
        !oldNormalized.startsWith('https://')) {
      oldNormalized = oldNormalized.replaceFirst('https:/', 'https://');
    }

    final oldEffectiveSourceType = _resolveSourceType(
      oldNormalized,
      oldWidget.sourceType,
    );

    if (oldWidget.videoUrl != widget.videoUrl ||
        oldEffectiveSourceType != _effectiveSourceType) {
      _controller.removeListener(_videoListener);
      _controller.dispose();
      _initializePlayer();
    }
  }

  @override
  void dispose() {
    _controller.removeListener(_videoListener);
    _controller.dispose();
    super.dispose();
  }

  void _togglePlayPause() {
    if (!_isInitialized) return;
    setState(() {
      if (_controller.value.isPlaying) {
        _controller.pause();
        _showControlsOverlay = true;
      } else {
        _controller.play();
        _showControlsOverlay = false;
      }
    });
  }

  void _toggleMute() {
    if (!_isInitialized) return;
    setState(() {
      _isMuted = !_isMuted;
      _controller.setVolume(_isMuted ? 0.0 : 1.0);
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_hasError) {
      return Container(
        width: widget.width,
        height: widget.height,
        color: Colors.black12,
        child: const Center(
          child: Icon(Icons.error_outline, color: Colors.grey, size: 40),
        ),
      );
    }

    if (!_isInitialized) {
      return Container(
        width: widget.width,
        height: widget.height,
        color: Colors.black12,
        child: const Center(child: CircularProgressIndicator()),
      );
    }

    final double effectiveAspectRatio =
        widget.aspectRatio ?? _controller.value.aspectRatio;

    Widget playerWidget = GestureDetector(
      onTap: () {
        if (widget.showControls) {
          setState(() {
            _showControlsOverlay = !_showControlsOverlay;
          });
        }
      },
      child: AspectRatio(
        aspectRatio: effectiveAspectRatio,
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Video display that covers the aspect ratio with provided fit
            SizedBox.expand(
              child: FittedBox(
                fit: widget.fit,
                child: SizedBox(
                  width: _controller.value.size.width,
                  height: _controller.value.size.height,
                  child: VideoPlayer(_controller),
                ),
              ),
            ),

            // Play/Pause Overlay
            if (widget.showControls && _showControlsOverlay)
              Container(
                color: Colors.black26,
                child: Center(
                  child: IconButton(
                    iconSize: 50,
                    icon: Icon(
                      _controller.value.isPlaying
                          ? Icons.pause_circle_filled
                          : Icons.play_circle_filled,
                      color: Colors.white,
                    ),
                    onPressed: _togglePlayPause,
                  ),
                ),
              ),

            // Mute / Unmute Button in corner
            if (widget.showControls && _showControlsOverlay)
              Positioned(
                bottom: 20,
                right: 10,
                child: IconButton(
                  icon: Icon(
                    _isMuted ? Icons.volume_off : Icons.volume_up,
                    color: Colors.white,
                  ),
                  onPressed: _toggleMute,
                ),
              ),

            // Progress Bar
            if (widget.showControls && _showControlsOverlay)
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: VideoProgressIndicator(
                  _controller,
                  allowScrubbing: true,
                  colors: VideoProgressColors(
                    playedColor: ColorPalette.primary,
                    bufferedColor: Colors.white54,
                    backgroundColor: Colors.black26,
                  ),
                ),
              ),
          ],
        ),
      ),
    );

    if (widget.borderRadius != null) {
      playerWidget = ClipRRect(
        borderRadius: widget.borderRadius!,
        child: playerWidget,
      );
    }

    if (widget.width != null || widget.height != null) {
      return SizedBox(
        width: widget.width,
        height: widget.height,
        child: playerWidget,
      );
    }

    return playerWidget;
  }
}
