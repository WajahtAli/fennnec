import 'dart:io';

import 'package:fennac_app/app/theme/app_colors.dart';
import 'package:fennac_app/core/extensions/string_extension.dart';
import 'package:flutter/material.dart';

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

  String _normalizePath(String value) {
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

  ImageProvider? _thumbnailProvider(String value) {
    final normalized = _normalizePath(value);
    if (normalized.isEmpty) return null;

    final uri = Uri.tryParse(normalized);
    final isNetwork =
        uri != null && (uri.scheme == 'http' || uri.scheme == 'https');
    if (isNetwork) {
      return NetworkImage(uri.toString());
    }

    return FileImage(File(normalized));
  }

  @override
  Widget build(BuildContext context) {
    final normalizedMessage = _normalizePath(message);
    final isVideo = normalizedMessage.isVideo;
    final thumbnailProvider = isVideo
        ? null
        : _thumbnailProvider(normalizedMessage);

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
          image: thumbnailProvider != null
              ? DecorationImage(image: thumbnailProvider, fit: BoxFit.cover)
              : null,
          color: message.isEmpty || isVideo ? ColorPalette.secondary : null,
        ),
        child: isVideo
            ? Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
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
