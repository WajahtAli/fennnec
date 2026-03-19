import 'dart:io';
import 'package:fennac_app/app/theme/app_colors.dart';
import 'package:fennac_app/helpers/cached_network_image_helper.dart';
import 'package:flutter/material.dart';

class DynamicRatioImageWidget extends StatefulWidget {
  final String imageUrl;
  final bool isAsset;
  final bool isFile;
  final double height;
  final double borderRadius;

  const DynamicRatioImageWidget({
    super.key,
    required this.imageUrl,
    this.isAsset = false,
    this.isFile = false,
    this.height = 450,
    this.borderRadius = 24,
  });

  @override
  State<DynamicRatioImageWidget> createState() =>
      _DynamicRatioImageWidgetState();
}

class _DynamicRatioImageWidgetState extends State<DynamicRatioImageWidget> {
  bool isSquare = true;

  @override
  Widget build(BuildContext context) {
    final double currentRatio = isSquare ? 1.0 : (9 / 16);

    Widget imageContent;

    if (widget.isFile) {
      imageContent = Image.file(
        File(widget.imageUrl),
        width: double.infinity,
        height: widget.height,
        fit: BoxFit.cover,
      );
    } else if (widget.isAsset) {
      imageContent = Image.asset(
        widget.imageUrl,
        width: double.infinity,
        height: widget.height,
        fit: BoxFit.cover,
      );
    } else {
      imageContent = CachedImageHelper(
        imageUrl: widget.imageUrl,
        width: double.infinity,
        height: widget.height,
        fit: BoxFit.cover,
        radius: 0,
      );
    }

    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(widget.borderRadius),
          child: AnimatedSize(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            child: AspectRatio(aspectRatio: currentRatio, child: imageContent),
          ),
        ),
        Positioned(
          top: 16,
          left: 16,
          child: GestureDetector(
            onTap: () {
              setState(() {
                isSquare = !isSquare;
              });
            },
            child: Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                color: ColorPalette.primary.withValues(alpha: 0.8),
                shape: BoxShape.circle,
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Icon(
                isSquare ? Icons.crop_portrait : Icons.crop_square,
                color: Colors.white,
                size: 20,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
