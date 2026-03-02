import 'dart:io';

import 'package:fennac_app/app/theme/app_colors.dart';
import 'package:fennac_app/core/extensions/string_extension.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class ThumbnailTile extends StatelessWidget {
  final String message;
  final bool isSelected;
  final VoidCallback onTap;

  const ThumbnailTile({
    super.key,
    required this.message,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isVideo = message.isVideo;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 64, // Square thumbnail
        margin: const EdgeInsets.only(right: 8),
        decoration: BoxDecoration(
          border: isSelected
              ? Border.all(color: ColorPalette.white, width: 2)
              : null,
          borderRadius: BorderRadius.circular(8),
          image: message.isNotEmpty
              ? DecorationImage(
                  image: FileImage(File(message)),
                  fit: BoxFit.cover,
                )
              : null,
          color: message.isEmpty ? ColorPalette.secondary : null,
        ),
        child: isVideo
            ? Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      VideoPlayer(
                        VideoPlayerController.file(File(message))..initialize(),
                      ),

                      Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: ColorPalette.black.withValues(alpha: 0.5),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.play_arrow,
                          color: ColorPalette.white,
                          size: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            : null,
      ),
    );
  }
}
