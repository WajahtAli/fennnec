import 'package:fennac_app/app/theme/app_colors.dart';
import 'package:fennac_app/app/theme/app_emojis.dart';

import 'package:flutter/material.dart';

class PokeImageCard extends StatelessWidget {
  final String imageUrl;
  final bool isAsset;

  final bool isCircular;

  const PokeImageCard({super.key, required this.imageUrl, this.isAsset = true, this.isCircular = false});

  @override
  Widget build(BuildContext context) {
    if (isCircular) {
      return _buildCircular();
    }
    return _buildCard();
  }

  Widget _buildCircular() {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        const SizedBox(height: 260, width: 260),
        Container(
          height: 240,
          width: 240,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: ColorPalette.white.withValues(alpha: 0.3),
              width: 3,
            ),
            image: DecorationImage(
              image: isAsset ? AssetImage(imageUrl) as ImageProvider : NetworkImage(imageUrl),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          right: 5,
          child: Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: ColorPalette.primary,
              border: Border.all(color: ColorPalette.white, width: 2),
            ),
            alignment: Alignment.center,
            child: Text(
              AppEmojis.pointingRight,
              style: const TextStyle(fontSize: 24),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCard() {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        const SizedBox(height: 260, width: 260),
        Transform.rotate(
          angle: -0.1,
          child: Container(
            height: 250,
            width: 240,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(40),
              border: Border.all(
                color: ColorPalette.white.withValues(alpha: 0.2),
                width: 1,
              ),
              image: DecorationImage(
                image: isAsset ? AssetImage(imageUrl) as ImageProvider : NetworkImage(imageUrl),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          right: 5,
          child: Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: ColorPalette.primary,
              border: Border.all(color: ColorPalette.white, width: 1),
            ),
            alignment: Alignment.center,
            child: Text(
              AppEmojis.pointingRight,
              style: const TextStyle(fontSize: 24),
            ),
          ),
        ),
      ],
    );
  }
}
