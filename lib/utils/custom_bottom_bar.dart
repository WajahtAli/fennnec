import 'dart:ui';
import 'package:fennac_app/pages/chats/presentation/bloc/cubit/chat_landing_cubit.dart';
import 'package:fennac_app/pages/chats/presentation/bloc/state/chat_landing_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fennac_app/app/theme/app_colors.dart';
import 'package:fennac_app/app/theme/text_styles.dart';

import '../core/di_container.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  final List<BottomNavItem> items;
  final int currentIndex;
  final ValueChanged<int> onTap;

  const CustomBottomNavigationBar({
    super.key,
    required this.items,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  State<CustomBottomNavigationBar> createState() =>
      CustomBottomNavigationBarState();
}

class CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    final isLight = Theme.of(context).brightness == Brightness.light;

    final safeBottom = mq.padding.bottom;

    return Container(
      margin: EdgeInsets.fromLTRB(8, 12, 8, 12 + safeBottom),
      height: 64,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(32),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            decoration: BoxDecoration(
              color: isLight
                  ? Colors.white.withOpacity(0.7)
                  : const Color(0xFF2A2A2A).withOpacity(0.7),
              borderRadius: BorderRadius.circular(32),
              border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.2),
                  blurRadius: 3,
                  spreadRadius: 3,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Row(
              children: widget.items.asMap().entries.map((entry) {
                final index = entry.key;
                final item = entry.value;
                final isSelected = widget.currentIndex == index;

                return Expanded(
                  child: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () => widget.onTap(index),
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        final maxPillWidth = constraints.maxWidth - 16;

                        return Center(
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 250),
                            curve: Curves.easeInOut,
                            height: 48,

                            width: isSelected ? maxPillWidth : 48,
                            decoration: BoxDecoration(
                              gradient: isSelected
                                  ? LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [
                                        ColorPalette.primary,
                                        ColorPalette.secondary,
                                      ],
                                    )
                                  : null,
                              borderRadius: BorderRadius.circular(24),
                            ),

                            child: ClipRect(
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Stack(
                                    clipBehavior: Clip.none,
                                    children: [
                                      SvgPicture.asset(
                                        item.iconPath,
                                        width: 22,
                                        height: 22,
                                        colorFilter: ColorFilter.mode(
                                          isSelected
                                              ? ColorPalette.white
                                              : isLight
                                              ? ColorPalette.primary
                                              : ColorPalette.white,
                                          BlendMode.srcIn,
                                        ),
                                      ),

                                      if (item.badgeCount > 0)
                                        Positioned(
                                          right: -8,
                                          top: -8,
                                          child:
                                              BlocBuilder<
                                                ChatLandingCubit,
                                                ChatLandingState
                                              >(
                                                bloc: Di()
                                                    .sl<ChatLandingCubit>(),
                                                builder: (context, state) {
                                                  return Container(
                                                    alignment: Alignment.center,
                                                    constraints:
                                                        const BoxConstraints(
                                                          minWidth: 20,
                                                          minHeight: 20,
                                                        ),
                                                    decoration: BoxDecoration(
                                                      color: Colors.red,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            20,
                                                          ),
                                                    ),
                                                    child: Center(
                                                      child: Text(
                                                        item.badgeCount > 99
                                                            ? '99+'
                                                            : item.badgeCount
                                                                  .toString(),
                                                        style:
                                                            AppTextStyles.inputLabel(
                                                              context,
                                                            ).copyWith(
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                      ),
                                                    ),
                                                  );
                                                },
                                              ),
                                        ),
                                    ],
                                  ),

                                  AnimatedSize(
                                    duration: const Duration(milliseconds: 250),
                                    curve: Curves.easeInOut,
                                    child: isSelected && item.label != null
                                        ? Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              const SizedBox(width: 6),

                                              ConstrainedBox(
                                                constraints: BoxConstraints(
                                                  maxWidth:
                                                      maxPillWidth -
                                                      22 -
                                                      6 -
                                                      16,
                                                ),
                                                child: Text(
                                                  item.label!,
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  softWrap: false,
                                                  style:
                                                      AppTextStyles.bodyRegular(
                                                        context,
                                                      ).copyWith(
                                                        color:
                                                            ColorPalette.white,
                                                      ),
                                                ),
                                              ),
                                            ],
                                          )
                                        : const SizedBox.shrink(),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }
}

class BottomNavItem {
  final String iconPath;
  final String? label;
  final int badgeCount;

  BottomNavItem({required this.iconPath, this.label, this.badgeCount = 0});
}
