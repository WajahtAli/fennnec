import 'package:fennac_app/app/theme/app_colors.dart';
import 'package:fennac_app/app/theme/app_emojis.dart';

import 'package:flutter/material.dart';

class PokeImageCard extends StatelessWidget {
  final String imageUrl;

  const PokeImageCard({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        SizedBox(height: 260, width: 260),
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
                image: AssetImage(imageUrl),
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
