import 'dart:ui';
import 'package:fennac_app/app/theme/app_colors.dart';
import 'package:fennac_app/core/di_container.dart';
import 'package:fennac_app/helpers/cached_network_image_helper.dart';
import 'package:fennac_app/pages/home/presentation/bloc/cubit/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'avatar_strip.dart';

class HeroSection extends StatelessWidget {
  final String imagePath;
  final List<String> avatarPaths;
  final List<String>? firstNames;

  const HeroSection({
    super.key,
    required this.imagePath,
    required this.avatarPaths,
    this.firstNames,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: homeCubit,
      builder: (context, state) {
        return Stack(
          clipBehavior: Clip.none,
          children: [
            if (imagePath.isNotEmpty)
              CachedImageHelper(
                imageUrl: imagePath,
                height: 283,
                opacity: 0.8,
                width: double.infinity,
                fit: BoxFit.cover,
                radius: 28,
              ),
            if (imagePath.isEmpty)
              Container(
                height: 283,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: ColorPalette.textGrey,
                  borderRadius: BorderRadius.circular(28),
                ),
              ),
            AnimatedOpacity(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              opacity: homeCubit.selectedProfileIndex != null ? 1.0 : 0.0,
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                child: Container(color: Colors.black.withValues(alpha: 0)),
              ),
            ),
            Positioned(
              bottom: -20,
              left: 0,
              right: 0,
              child: avatarPaths.isNotEmpty
                  ? Center(
                      child: AvatarStrip(
                        avatarPaths: avatarPaths,
                        firstNames: firstNames,
                      ),
                    )
                  : const SizedBox.shrink(),
            ),
          ],
        );
      },
    );
  }
}

final HomeCubit homeCubit = Di().sl<HomeCubit>();
