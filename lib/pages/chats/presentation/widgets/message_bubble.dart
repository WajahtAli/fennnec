import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:fennac_app/app/constants/media_query_constants.dart';
import 'package:fennac_app/app/theme/app_colors.dart';
import 'package:fennac_app/app/theme/text_styles.dart';
import 'package:fennac_app/core/di_container.dart';
import 'package:fennac_app/generated/assets.gen.dart';
import 'package:fennac_app/helpers/cached_network_image_helper.dart';
import 'package:fennac_app/pages/chats/data/models/message_model.dart';
import 'package:fennac_app/pages/chats/data/models/message_type_enum.dart';
import 'package:fennac_app/pages/chats/presentation/bloc/cubit/message_cubit.dart';
import 'package:fennac_app/widgets/prompt_audio_row.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:video_player/video_player.dart';

import '../../../../routes/routes_imports.gr.dart';

class MessageBubble extends StatelessWidget {
  final MessageModel message;
  final bool isMineSide;
  final VoidCallback onLongPress;
  final GlobalKey messageKey;

  const MessageBubble({
    super.key,
    required this.message,
    required this.isMineSide,
    required this.onLongPress,
    required this.messageKey,
  });

  @override
  Widget build(BuildContext context) {
    Widget bubble;

    switch (message.type) {
      case MessageType.audio:
        bubble = GestureDetector(
          onLongPress: onLongPress,
          child: VoiceMessageBubble(message: message, isMineSide: isMineSide),
        );
        break;

      case MessageType.image:
        bubble = GestureDetector(
          onLongPress: onLongPress,
          child: ImageMessageBubble(message: message),
        );
        break;

      case MessageType.video:
        bubble = GestureDetector(
          onLongPress: onLongPress,
          child: VideoMessageBubble(message: message),
        );
        break;

      default:
        bubble = TextMessageBubble(message: message, isMineSide: isMineSide);
    }

    return MessageWithReactions(
      message: message,
      isMineSide: isMineSide,
      messageKey: messageKey,
      child: bubble,
    );
  }
}

class TextMessageBubble extends StatelessWidget {
  final MessageModel message;
  final bool isMineSide;

  const TextMessageBubble({
    super.key,
    required this.message,
    required this.isMineSide,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: isMineSide
          ? CrossAxisAlignment.end
          : CrossAxisAlignment.start,
      children: [
        if (!isMineSide)
          Text(message.senderName, style: AppTextStyles.body(context)),
        Container(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.75,
          ),
          margin: message.reactions.isNotEmpty
              ? const EdgeInsets.only(bottom: 10)
              : EdgeInsets.zero,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: isMineSide
                ? isLightTheme(context)
                      ? ColorPalette.primary
                      : ColorPalette.primary
                : (isLightTheme(context)
                      ? ColorPalette.textGrey
                      : ColorPalette.secondary.withValues(alpha: 0.5)),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            message.content,
            style: AppTextStyles.body(context).copyWith(
              color: isMineSide
                  ? Colors.white
                  : (isLightTheme(context) ? Colors.black : Colors.white),
            ),
          ),
        ),
      ],
    );
  }
}

class ChatImage extends StatelessWidget {
  final String path;
  final double height;
  final double? width;

  const ChatImage({
    super.key,
    required this.path,
    required this.height,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    final isNetwork = path.startsWith('http');
    final isFile = !isNetwork && File(path).existsSync();

    if (isNetwork) {
      return CachedImageHelper(
        imageUrl: path,
        fit: BoxFit.cover,
        height: height,
        width: width,
        radius: 16,
      );
    }

    if (isFile) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Image.file(
          File(path),
          fit: BoxFit.cover,
          height: height,
          width: width,
        ),
      );
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Image.asset(path, fit: BoxFit.cover, height: height, width: width),
    );
  }
}

class ImageMessageBubble extends StatelessWidget {
  final MessageModel message;

  const ImageMessageBubble({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    final images = message.imageUrls;
    if (images.isEmpty) return const SizedBox.shrink();

    return Container(
      constraints: BoxConstraints(
        maxWidth: MediaQuery.of(context).size.width * 0.75,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: LayoutBuilder(
          builder: (context, constraints) {
            const spacing = 4.0;
            final isMulti = images.length > 1;
            final size = isMulti
                ? (constraints.maxWidth - spacing) / 2
                : constraints.maxWidth;

            return Wrap(
              spacing: spacing,
              runSpacing: spacing,
              children: List.generate(images.length > 4 ? 4 : images.length, (
                index,
              ) {
                return Stack(
                  children: [
                    GestureDetector(
                      onTap: () {
                        context.router.navigate(
                          MediaPreviewRoute(
                            messages: context.read<MessageCubit>().messages,
                            initialIndex: index,
                            messageCubit: context.read<MessageCubit>(),
                          ),
                        );
                      },
                      child: ChatImage(
                        path: images[index],
                        height: images.length == 1 ? 250 : size,
                        width: size,
                      ),
                    ),
                    if (index == 3 && images.length > 4)
                      Positioned.fill(
                        child: Container(
                          color: Colors.black.withOpacity(0.6),
                          child: Center(
                            child: Text(
                              '+${images.length - 4}',
                              style: AppTextStyles.h3(context),
                            ),
                          ),
                        ),
                      ),
                  ],
                );
              }),
            );
          },
        ),
      ),
    );
  }
}

class VideoMessageBubble extends StatefulWidget {
  final MessageModel message;

  const VideoMessageBubble({super.key, required this.message});

  @override
  State<VideoMessageBubble> createState() => _VideoMessageBubbleState();
}

class _VideoMessageBubbleState extends State<VideoMessageBubble> {
  VideoPlayerController? _controller;
  bool _isInitializing = false;

  String _normalizeMediaPath(String value) {
    var normalized = value.trim();

    while (normalized.startsWith('/http') || normalized.startsWith('/https')) {
      normalized = normalized.substring(1);
    }

    if (normalized.startsWith('http:/') && !normalized.startsWith('http://')) {
      normalized = normalized.replaceFirst('http:/', 'http://');
    }

    if (normalized.startsWith('https:/') &&
        !normalized.startsWith('https://')) {
      normalized = normalized.replaceFirst('https:/', 'https://');
    }

    return normalized;
  }

  bool _isNetworkSource(String normalizedPath) {
    final uri = Uri.tryParse(normalizedPath);
    return uri != null && (uri.scheme == 'http' || uri.scheme == 'https');
  }

  Future<VideoPlayerController> _buildController(String rawMediaPath) async {
    final normalizedPath = _normalizeMediaPath(rawMediaPath);
    final isNetwork = _isNetworkSource(normalizedPath);

    if (isNetwork) {
      final cachedFile = await DefaultCacheManager().getSingleFile(
        normalizedPath,
      );
      return VideoPlayerController.file(cachedFile);
    }

    return VideoPlayerController.file(File(normalizedPath));
  }

  Future<void> _initializeVideo() async {
    if (!mounted) return;
    setState(() {
      _isInitializing = true;
    });

    try {
      final controller = await _buildController(widget.message.mediaUrl ?? '');
      await controller.initialize();
      if (!mounted) {
        controller.dispose();
        return;
      }

      setState(() {
        _controller = controller;
      });
    } finally {
      if (mounted) {
        setState(() {
          _isInitializing = false;
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _initializeVideo();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = _controller;

    if (_isInitializing ||
        controller == null ||
        !controller.value.isInitialized) {
      return const SizedBox(
        height: 200,
        child: Center(child: CircularProgressIndicator()),
      );
    }

    return GestureDetector(
      onTap: () {
        context.router.navigate(
          MediaPreviewRoute(
            messages: context.read<MessageCubit>().messages,
            initialIndex: 0,
            messageCubit: context.read<MessageCubit>(),
          ),
        );
      },
      child: Container(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.sizeOf(context).width * 0.75,
          maxHeight: 400,
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: AspectRatio(
                aspectRatio: controller.value.aspectRatio,
                child: VideoPlayer(controller),
              ),
            ),
            IconButton(
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all(ColorPalette.primary),
              ),
              icon: Icon(
                controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
                color: Colors.white,
                size: 20,
              ),
              onPressed: () {
                setState(() {
                  controller.value.isPlaying
                      ? controller.pause()
                      : controller.play();
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}

class ReactionRow extends StatelessWidget {
  final List<dynamic> reactions;

  const ReactionRow({super.key, required this.reactions});

  @override
  Widget build(BuildContext context) {
    final Map<String, int> grouped = {};

    for (final r in reactions) {
      grouped[r.emoji] = (grouped[r.emoji] ?? 0) + 1;
    }

    return Wrap(
      spacing: 6,
      children: grouped.entries.map((e) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: ColorPalette.primary,
            borderRadius: BorderRadius.circular(14),
          ),
          child: Text(
            '${e.key} ${e.value}',
            style: AppTextStyles.bodySmall(
              context,
            ).copyWith(color: Colors.white),
          ),
        );
      }).toList(),
    );
  }
}

class VoiceMessageBubble extends StatelessWidget {
  final MessageModel message;
  final bool isMineSide;

  const VoiceMessageBubble({
    super.key,
    required this.message,
    required this.isMineSide,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxWidth: MediaQuery.of(context).size.width * 0.75,
      ),
      child: PromptAudioRow(
        audioPath: message.mediaUrl ?? Assets.dummy.audio.group,
        duration: message.mediaDuration ?? '00:00',
        waveformData: message.waveformData,
        height: 72,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        backgroundColor: isLightTheme(context)
            ? ColorPalette.primary
            : ColorPalette.primary.withValues(alpha: 0.2),
        playButtonColor: !isLightTheme(context)
            ? ColorPalette.secondary
            : Colors.white,
        waveformColor: ColorPalette.white,
        borderRadius: BorderRadius.circular(20),
      ),
    );
  }
}

class MessageWithReactions extends StatelessWidget {
  final Widget child;
  final MessageModel message;
  final bool isMineSide;
  final GlobalKey messageKey;

  const MessageWithReactions({
    super.key,
    required this.child,
    required this.message,
    required this.isMineSide,
    required this.messageKey,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      key: messageKey,
      crossAxisAlignment: isMineSide
          ? CrossAxisAlignment.end
          : CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: isMineSide
                  ? CrossAxisAlignment.end
                  : CrossAxisAlignment.start,
              children: [
                child,
                const SizedBox(height: 5),
                if (isMineSide)
                  Text(
                    DateFormat('hh:mm a').format(message.sentAt),
                    style: AppTextStyles.description(context),
                  ),
              ],
            ),
            if (message.reactions.isNotEmpty)
              Positioned(
                bottom: isMineSide ? 15 : 0,
                right: isMineSide ? 0 : null,
                left: isMineSide ? null : 0,
                child: ReactionRow(reactions: message.reactions),
              ),
          ],
        ),
      ],
    );
  }
}
