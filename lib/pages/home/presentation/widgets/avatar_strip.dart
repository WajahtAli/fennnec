import 'package:fennac_app/app/theme/app_colors.dart';
import 'package:fennac_app/core/di_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/cubit/home_cubit.dart';

class AvatarStrip extends StatefulWidget {
  final List<String> avatarPaths;
  final List<String>? avatarIds;
  final List<String>? firstNames;

  const AvatarStrip({
    super.key,
    required this.avatarPaths,
    this.avatarIds,
    this.firstNames,
  });

  @override
  State<AvatarStrip> createState() => _AvatarStripState();
}

class _AvatarStripState extends State<AvatarStrip> {
  @override
  Widget build(BuildContext context) {
    const double baseSize = 48;
    const double selectedSize = 128;
    const double overlap = 40;
    const double spacing = 8;

    return BlocBuilder(
      bloc: _homeCubit,
      builder: (context, state) {
        return SizedBox(
          height: selectedSize.toDouble(),
          child: LayoutBuilder(
            builder: (context, constraints) {
              final totalAvatars = widget.avatarPaths.length;

              double totalWidth;
              if (_homeCubit.selectedProfileIndex == null) {
                totalWidth = baseSize + (totalAvatars - 1) * overlap;
              } else {
                totalWidth = 0;
                for (int i = 0; i < totalAvatars; i++) {
                  totalWidth += (_homeCubit.selectedProfileIndex == i
                      ? selectedSize
                      : baseSize);
                  if (i != totalAvatars - 1) totalWidth += spacing;
                }
              }

              final startLeft = (constraints.maxWidth - totalWidth) / 2;

              return Stack(
                children: List.generate(totalAvatars, (index) {
                  final bool isSelected =
                      _homeCubit.selectedProfileIndex == index;
                  final double size = isSelected ? selectedSize : baseSize;
                  final bool hasSelection =
                      _homeCubit.selectedProfileIndex != null;

                  double left = startLeft;
                  if (_homeCubit.selectedProfileIndex == null) {
                    left += index * overlap;
                  } else {
                    for (int i = 0; i < index; i++) {
                      left +=
                          (_homeCubit.selectedProfileIndex == i
                              ? selectedSize
                              : baseSize) +
                          spacing;
                    }
                  }

                  return AnimatedPositioned(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    left: left,
                    bottom: 0,
                    width: size,
                    height: size,
                    child: GestureDetector(
                      onTap: () {
                        if (widget.avatarIds != null &&
                            index < (widget.avatarIds!.length)) {
                          final id = widget.avatarIds![index];
                          _homeCubit.selectProfileById(isSelected ? null : id);
                        } else {
                          _homeCubit.selectProfileIndex(
                            isSelected ? null : index,
                          );
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.black, width: 2),
                        ),
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            Builder(
                              builder: (context) {
                                final hasImage = widget.avatarPaths[index]
                                    .trim()
                                    .isNotEmpty;
                                final firstName =
                                    widget.firstNames != null &&
                                        index < widget.firstNames!.length
                                    ? widget.firstNames![index].trim()
                                    : '';
                                final initial = firstName.isNotEmpty
                                    ? firstName[0].toUpperCase()
                                    : '?';

                                return CircleAvatar(
                                  backgroundImage: hasImage
                                      ? NetworkImage(widget.avatarPaths[index])
                                      : null,
                                  backgroundColor: ColorPalette.textGrey,
                                  child: hasImage
                                      ? null
                                      : Text(
                                          initial,
                                          style: TextStyle(
                                            color: ColorPalette.primary,
                                            fontWeight: FontWeight.bold,
                                            fontSize: isSelected ? 40 : 18,
                                          ),
                                        ),
                                );
                              },
                            ),
                            if (hasSelection && !isSelected)
                              Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: ColorPalette.primary.withValues(
                                    alpha: 0.4,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
              );
            },
          ),
        );
      },
    );
  }
}

final HomeCubit _homeCubit = Di().sl<HomeCubit>();
