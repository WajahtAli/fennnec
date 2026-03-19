import 'package:fennac_app/app/theme/app_colors.dart';
import 'package:fennac_app/app/theme/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:ui';

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
  CustomBottomNavigationBarState createState() =>
      CustomBottomNavigationBarState();
}

class CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
      height: 64,
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(32)),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(32),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).brightness == Brightness.light
                  ? Colors.white.withOpacity(0.7)
                  : const Color(0xFF2A2A2A).withOpacity(0.7),
              borderRadius: BorderRadius.circular(32),
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.1),
                width: 1,
              ),
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: widget.items.asMap().entries.map((entry) {
                int index = entry.key;
                BottomNavItem item = entry.value;
                bool isSelected = widget.currentIndex == index;

                return Expanded(
                  child: GestureDetector(
                    onTap: () => widget.onTap(index),
                    child: AnimatedContainer(
                      height: 56,
                      // constraints: const BoxConstraints(
                      //   minWidth: 110,
                      //   maxWidth: 140,
                      // ),
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                      padding: EdgeInsets.symmetric(
                        horizontal: isSelected ? 20 : 16,
                        vertical: 12,
                      ),
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
                        borderRadius: BorderRadius.circular(36),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            item.iconPath,
                            colorFilter: ColorFilter.mode(
                              Theme.of(context).brightness ==
                                          Brightness.light &&
                                      !isSelected
                                  ? ColorPalette.primary
                                  : isSelected
                                  ? ColorPalette.white
                                  : ColorPalette.white,
                              BlendMode.srcIn,
                            ),
                            width: 24,
                            height: 24,
                          ),
                          if (isSelected && item.label != null) ...[
                            const SizedBox(width: 8),
                            Text(
                              item.label!,
                              style: AppTextStyles.bodyRegular(context),
                            ),
                          ],
                        ],
                      ),
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

  BottomNavItem({required this.iconPath, this.label});
}
