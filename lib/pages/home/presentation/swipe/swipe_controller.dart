import 'package:fennac_app/pages/home/presentation/bloc/cubit/home_cubit.dart';
import 'package:flutter/material.dart';

import '../../../../app/constants/app_enums.dart' show SwipeResult;
import '../../../../core/di_container.dart';

class SwipeController {
  SwipeController({required TickerProvider vsync, this.swipeThreshold = 100}) {
    animationController = AnimationController(
      vsync: vsync,
      duration: const Duration(milliseconds: 300),
    );
  }

  final double swipeThreshold;
  late AnimationController animationController;
  Animation<Offset>? animation;

  Offset dragOffset = Offset.zero;
  bool isDragging = false;

  // 🔹 Finger follows card 1:1
  void onDragUpdate(DragUpdateDetails details) {
    isDragging = true;
    dragOffset = Offset(dragOffset.dx + details.delta.dx, 0);
  }

  SwipeResult onDragEnd(Size screenSize) {
    isDragging = false;
    animationController.duration = const Duration(milliseconds: 300);
    final dx = dragOffset.dx;
    final absDx = dx.abs();

    if (absDx >= swipeThreshold) {
      final isRight = dx > 0;
      _animateOut(isRight ? 1 : -1, screenSize);
      return isRight ? SwipeResult.right : SwipeResult.left;
    }

    // 🔹 Not enough → go back smoothly
    _animateBack();
    return SwipeResult.none;
  }

  void _animateOut(int direction, Size size) {
    animation =
        Tween<Offset>(
          begin: dragOffset,
          end: Offset(direction * size.width * 1.4, 0),
        ).animate(
          CurvedAnimation(parent: animationController, curve: Curves.easeInOut),
        );
    animationController.forward(from: 0).whenComplete(() {
      dragOffset = Offset.zero;
    });
  }

  void _animateBack() {
    animation = Tween<Offset>(begin: dragOffset, end: Offset.zero).animate(
      CurvedAnimation(parent: animationController, curve: Curves.easeOut),
    );

    animationController.forward(from: 0).whenComplete(() {
      dragOffset = Offset.zero;
      Di().sl<HomeCubit>().updateCardPosition(0);
    });
  }

  // reset controller to initial state
  void reset() {
    dragOffset = Offset.zero;
    isDragging = false;
    animationController.reset();
    animation = null;
  }

  Offset get currentOffset {
    if (isDragging || animation == null) {
      return dragOffset;
    }
    return animation!.value;
  }

  void swipeProgrammatically({
    required bool toRight,
    required Size screenSize,
  }) {
    if (animationController.isAnimating) return;

    final direction = toRight ? 1 : -1;

    // 👇 set 1 second duration
    animationController.duration = const Duration(seconds: 2);

    dragOffset = Offset(direction * swipeThreshold, 0);
    isDragging = false;

    _animateOut(direction, screenSize);
  }

  void dispose() {
    animationController.dispose();
  }
}
