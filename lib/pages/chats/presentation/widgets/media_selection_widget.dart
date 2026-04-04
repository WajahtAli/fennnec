import 'dart:io';

import 'package:fennac_app/core/di_container.dart';
import 'package:fennac_app/generated/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:video_player/video_player.dart';

import 'package:fennac_app/pages/chats/data/models/message_type_enum.dart';
import 'package:fennac_app/pages/chats/presentation/bloc/cubit/message_cubit.dart';
import 'package:fennac_app/bloc/state/imagepicker_state.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../bloc/cubit/imagepicker_cubit.dart';
import '../../../../widgets/custom_sized_box.dart';

class MediaSelectionWidget extends StatelessWidget {
  const MediaSelectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final imagePickerCubit = Di().sl<ImagePickerCubit>();
    return BlocBuilder(
      bloc: imagePickerCubit,
      builder: (context, state) {
        return Column(
          children: [
            const CustomSizedBox(height: 12),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: ColorPalette.secondary.withValues(alpha: 0.15),
                border: Border(
                  top: BorderSide(
                    color: ColorPalette.grey.withValues(alpha: 0.2),
                    width: 1,
                  ),
                ),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Column(
                children: [
                  if (state is ImagePickerLoaded &&
                      state.mediaList != null &&
                      state.mediaList!.isNotEmpty) ...[
                    SizedBox(
                      height: 100,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: state.mediaList!.length,
                        itemBuilder: (context, index) {
                          final media = state.mediaList![index];

                          return MediaPreviewTile(
                            media: media,
                            onRemove: () {
                              imagePickerCubit.removeMedia(
                                media.id,
                                index: index,
                              );
                            },
                          );
                        },
                      ),
                    ),
                    const CustomSizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            imagePickerCubit.clearAllMedia();
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 10,
                            ),
                            decoration: BoxDecoration(
                              color: ColorPalette.grey.withValues(alpha: 0.3),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: ColorPalette.white.withValues(
                                  alpha: 0.1,
                                ),
                                width: 1,
                              ),
                            ),
                            child: Text(
                              'Clear',
                              style: TextStyle(
                                color: ColorPalette.white,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            final mediaList = state.mediaList ?? [];

                            if (mediaList.isEmpty) return;

                            final mediaType =
                                mediaList.first.type == MediaType.image
                                ? MessageType.image
                                : MessageType.video;

                            Di().sl<MessageCubit>().sendMediaMessage(
                              mediaPath: mediaList.map((e) => e.path).toList(),
                              type: mediaType,
                            );
                            imagePickerCubit.clearAllMedia();
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 24,
                              vertical: 10,
                            ),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  ColorPalette.primary,
                                  ColorPalette.primary.withValues(alpha: 0.7),
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: ColorPalette.primary.withValues(
                                    alpha: 0.35,
                                  ),
                                  blurRadius: 8,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Text(
                              'Send',
                              style: TextStyle(
                                color: ColorPalette.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

class MediaPreviewTile extends StatelessWidget {
  final MediaItem media;
  final VoidCallback onRemove;

  const MediaPreviewTile({
    super.key,
    required this.media,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 12),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: SizedBox(width: 100, height: 100, child: _buildPreview()),
          ),
          Positioned(
            top: 4,
            right: 4,
            child: GestureDetector(
              onTap: onRemove,
              child: Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.6),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.close, size: 16, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPreview() {
    switch (media.type) {
      case MediaType.image:
        return Image.file(File(media.path), fit: BoxFit.cover);

      case MediaType.video:
        return Stack(
          alignment: Alignment.center,
          children: [
            _VideoThumbnail(path: media.path),
            Container(
              width: 36,
              height: 36,
              decoration: const BoxDecoration(
                color: Colors.black54,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.play_arrow,
                color: Colors.white,
                size: 20,
              ),
            ),
          ],
        );
    }
  }
}

class _VideoThumbnail extends StatefulWidget {
  final String path;

  const _VideoThumbnail({required this.path});

  @override
  State<_VideoThumbnail> createState() => _VideoThumbnailState();
}

class _VideoThumbnailState extends State<_VideoThumbnail> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.file(File(widget.path))
      ..initialize().then((_) => setState(() {}));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _controller.value.isInitialized
        ? VideoPlayer(_controller)
        : Container(
            color: Colors.black12,
            child: Lottie.asset(Assets.animations.loadingSpinner),
          );
  }
}
