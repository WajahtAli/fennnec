import 'dart:io';

import 'package:fennac_app/app/constants/media_query_constants.dart';
import 'package:fennac_app/app/theme/app_colors.dart';
import 'package:fennac_app/bloc/cubit/imagepicker_cubit.dart';
import 'package:fennac_app/core/di_container.dart';
import 'package:fennac_app/generated/assets.gen.dart';
import 'package:fennac_app/helpers/cached_network_image_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
import 'package:video_player/video_player.dart';

class MediaContainerWidget extends StatefulWidget {
  final MediaItem? media;
  final int index;
  final double width;
  final double height;
  final VoidCallback onTapAdd;
  final VoidCallback? onTapExisting;
  final bool isEditMode;
  final bool isSelected;
  final bool isDeleteNeeded;

  const MediaContainerWidget({
    super.key,
    this.media,
    required this.index,
    required this.width,
    required this.height,
    required this.onTapAdd,
    this.onTapExisting,
    this.isEditMode = false,
    this.isSelected = false,
    this.isDeleteNeeded = true,
  });

  @override
  State<MediaContainerWidget> createState() => _MediaContainerWidgetState();
}

class _MediaContainerWidgetState extends State<MediaContainerWidget> {
  VideoPlayerController? _videoController;
  Future<void>? _videoInitFuture;

  @override
  void initState() {
    super.initState();
    _initVideoControllerIfNeeded();
  }

  @override
  void didUpdateWidget(covariant MediaContainerWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.media?.path != widget.media?.path ||
        oldWidget.media?.type != widget.media?.type) {
      _disposeVideo();
      _initVideoControllerIfNeeded();
    }
  }

  @override
  void dispose() {
    _disposeVideo();
    super.dispose();
  }

  void _initVideoControllerIfNeeded() {
    if (widget.media?.type != MediaType.video) return;

    final mediaPath = widget.media!.path;
    final isNetworkVideo =
        mediaPath.startsWith('http://') || mediaPath.startsWith('https://');

    _videoController = isNetworkVideo
        ? VideoPlayerController.networkUrl(Uri.parse(mediaPath))
        : VideoPlayerController.file(File(mediaPath));
    _videoInitFuture = _videoController!
        .initialize()
        .then(
          (_) => _videoController
            ?..setVolume(0)
            ..pause(),
        )
        .catchError((error) {
          debugPrint('Video preview init failed: $error');
          return null;
        });
  }

  void _disposeVideo() {
    _videoController?.dispose();
    _videoController = null;
    _videoInitFuture = null;
  }

  @override
  Widget build(BuildContext context) {
    final cubit = Di().sl<ImagePickerCubit>();

    if (widget.media == null) {
      return _buildUploadPlaceholder();
    }

    return DragTarget<int>(
      onWillAcceptWithDetails: (details) => details.data != widget.index,
      onAcceptWithDetails: (details) {
        cubit.reorderMedia(details.data, widget.index);
      },
      builder: (context, candidateData, rejectedData) {
        final isActiveDropTarget = candidateData.isNotEmpty;

        return LongPressDraggable<int>(
          data: widget.index,
          maxSimultaneousDrags: 1,
          rootOverlay: true,
          feedback: Material(
            elevation: 8,
            borderRadius: BorderRadius.circular(16),
            child: _buildMediaPreview(),
          ),
          childWhenDragging: _buildDraggingPlaceholder(),
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: widget.isEditMode ? widget.onTapExisting : null,
            child: _buildMediaWithDelete(
              cubit,
              isActiveDropTarget: isActiveDropTarget,
            ),
          ),
        );
      },
    );
  }

  Widget _buildUploadPlaceholder() {
    return GestureDetector(
      onTap: widget.onTapAdd,
      child: Container(
        height: widget.height,
        width: widget.width,
        decoration: BoxDecoration(
          color: isLightTheme(context)
              ? ColorPalette.textGrey
              : ColorPalette.secondary.withValues(alpha: 0.5),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isLightTheme(context)
                ? Colors.black.withValues(alpha: 0.2)
                : Colors.white.withValues(alpha: 0.2),
            width: 1,
          ),
        ),
        child: Center(
          child: SvgPicture.asset(
            Assets.icons.camera.path,
            fit: BoxFit.scaleDown,
            colorFilter: ColorFilter.mode(
              isLightTheme(context)
                  ? ColorPalette.black
                  : Colors.white.withValues(alpha: 0.6),
              BlendMode.srcIn,
            ),
            width: 32,
            height: 32,
          ),
        ),
      ),
    );
  }

  Widget _buildMediaPreview() {
    return Container(
      width: widget.width,
      height: widget.height,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: widget.media!.type == MediaType.image
            ? _buildImageWidget()
            : _buildVideoThumbnail(),
      ),
    );
  }

  Widget _buildDraggingPlaceholder() {
    return Container(
      height: widget.height,
      width: widget.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isLightTheme(context)
              ? Colors.black.withValues(alpha: 0.2)
              : Colors.white.withValues(alpha: 0.2),
          width: 1,
        ),
        color: Colors.black.withValues(alpha: 0.3),
      ),
    );
  }

  Widget _buildMediaWithDelete(
    ImagePickerCubit cubit, {
    bool isActiveDropTarget = false,
  }) {
    final isSelected = widget.isEditMode && widget.isSelected;
    final borderColor = isActiveDropTarget
        ? ColorPalette.primary
        : (isSelected ? Colors.white : Colors.white.withValues(alpha: 0.2));
    final borderWidth = isActiveDropTarget ? 3.0 : (isSelected ? 3.0 : 1.0);

    return Container(
      height: widget.height,
      width: widget.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: borderColor, width: borderWidth),
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: widget.media!.type == MediaType.image
                ? _buildImageWidget()
                : _buildVideoThumbnail(),
          ),
          // Delete button
          if (widget.isDeleteNeeded)
            Positioned(
              top: 8,
              right: 8,
              child: GestureDetector(
                onTap: () =>
                    cubit.removeMedia(widget.media!.id, index: widget.index),
                child: Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: Colors.red.withValues(alpha: 0.8),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.delete_outline,
                    color: Colors.white,
                    size: 16,
                  ),
                ),
              ),
            ),
          // Edit button (images only)
          if (widget.media!.type == MediaType.image)
            Positioned(
              bottom: 8,
              right: 8,
              child: GestureDetector(
                onTap: () => cubit.editMediaAtIndex(widget.index),
                child: Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.6),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.edit, color: Colors.white, size: 16),
                ),
              ),
            ),
          // Video badge
          if (widget.media!.type == MediaType.video)
            Positioned(
              bottom: 8,
              left: 8,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.6),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.play_arrow, color: Colors.white, size: 12),
                    SizedBox(width: 4),
                    Text(
                      'VIDEO',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildVideoThumbnail() {
    if (_videoController == null || _videoInitFuture == null) {
      return _buildVideoPlaceholder();
    }

    return FutureBuilder(
      future: _videoInitFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return _buildVideoPlaceholder(isLoading: true);
        }
        if (snapshot.hasError || !_videoController!.value.isInitialized) {
          return _buildVideoPlaceholder();
        }

        return Stack(
          fit: StackFit.expand,
          children: [
            FittedBox(
              fit: BoxFit.cover,
              child: SizedBox(
                width: _videoController!.value.size.width,
                height: _videoController!.value.size.height,
                child: VideoPlayer(_videoController!),
              ),
            ),
            Container(
              color: Colors.black.withValues(alpha: 0.2),
              child: const Center(
                child: Icon(
                  Icons.play_circle_fill,
                  color: Colors.white,
                  size: 40,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildVideoPlaceholder({bool isLoading = false}) {
    return Container(
      color: ColorPalette.secondary.withValues(alpha: 0.3),
      child: Center(
        child: isLoading
            ? SizedBox(
                width: 24,
                height: 24,
                child: Lottie.asset(Assets.animations.loadingSpinner),
              )
            : Icon(
                Icons.video_camera_back,
                color: Colors.white.withValues(alpha: 0.6),
                size: 40,
              ),
      ),
    );
  }

  Widget _buildErrorWidget() {
    return Container(
      color: ColorPalette.secondary.withValues(alpha: 0.5),
      child: const Icon(Icons.broken_image, color: Colors.white54, size: 30),
    );
  }

  Widget _buildImageWidget() {
    final path = widget.media!.path;
    final isNetwork =
        Uri.tryParse(path)?.hasAbsolutePath == true &&
        (path.startsWith('http://') || path.startsWith('https://'));

    if (isNetwork) {
      return CachedImageHelper(
        imageUrl: path,
        fit: BoxFit.cover,
        errorWidget: _buildErrorWidget(),
        placeholder: Container(
          color: ColorPalette.secondary.withValues(alpha: 0.3),
          child: Center(
            child: SizedBox(
              width: 24,
              height: 24,
              child: Lottie.asset(Assets.animations.loadingSpinner),
            ),
          ),
        ),
      );
    }

    return Image.file(
      File(path),
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) => _buildErrorWidget(),
    );
  }
}
