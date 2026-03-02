import 'package:fennac_app/app/constants/media_query_constants.dart';
import 'package:fennac_app/core/di_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fennac_app/generated/assets.gen.dart';

import '../bloc/cubit/background_cubit.dart';

enum MovableBackgroundType {
  light,
  medium,
  dark;

  List<AssetGenImage> get assets {
    switch (this) {
      case MovableBackgroundType.light:
        return [
          Assets.images.background.bg115,
          Assets.images.background.bg215,
          Assets.images.background.bg315,
        ];
      case MovableBackgroundType.medium:
        return [
          Assets.images.background.bg130,
          Assets.images.background.bg230,
          Assets.images.background.bg330,
        ];
      case MovableBackgroundType.dark:
        return [
          Assets.images.background.bg150,
          Assets.images.background.bg250,
          Assets.images.background.bg350,
        ];
    }
  }
}

class MovableBackground extends StatefulWidget {
  final Widget child;
  final MovableBackgroundType backgroundType;
  final bool forceShowBackground;

  static const defaultBackgroundType = MovableBackgroundType.medium;

  const MovableBackground({
    super.key,
    required this.child,
    this.backgroundType = defaultBackgroundType,
    this.forceShowBackground = false,
  });

  @override
  State<MovableBackground> createState() => _MovableBackgroundState();
}

class _MovableBackgroundState extends State<MovableBackground>
    with SingleTickerProviderStateMixin {
  final MoveAbleBackgroundCubit _cubit = Di().sl<MoveAbleBackgroundCubit>();
  final GlobalKey _rowKey = GlobalKey();
  double _rowWidth = 0.0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _measureRowWidth();
    });
  }

  void _measureRowWidth() {
    final RenderBox? renderBox =
        _rowKey.currentContext?.findRenderObject() as RenderBox?;
    if (renderBox != null) {
      setState(() {
        _rowWidth = renderBox.size.width;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // If forceShowBackground is true, always treat as dark mode (show background)
    // Otherwise, only show background in dark mode
    final showBackground = widget.forceShowBackground
        ? true
        : !isLightTheme(context);
    return BlocBuilder(
      bloc: _cubit,
      builder: (context, state) {
        return Builder(
          builder: (context) {
            final size = MediaQuery.of(context).size;
            return Scaffold(
              backgroundColor: widget.forceShowBackground
                  ? Colors.black
                  : (isLightTheme(context) ? Colors.white : Colors.black),
              body: MouseRegion(
                onHover: (event) {},
                child: GestureDetector(
                  onPanUpdate: (details) {},
                  child: SizedBox.expand(
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        Positioned.fill(
                          child: showBackground
                              ? BlocBuilder<
                                  MoveAbleBackgroundCubit,
                                  BackgroundState
                                >(
                                  bloc: _cubit,
                                  builder: (context, state) {
                                    final totalWidth = _rowWidth > 0
                                        ? _rowWidth
                                        : size.width *
                                              widget
                                                  .backgroundType
                                                  .assets
                                                  .length;

                                    final maxOffset = totalWidth > size.width
                                        ? totalWidth - size.width
                                        : 0.0;

                                    return AnimatedBuilder(
                                      animation: _cubit.animation,
                                      builder: (context, child) {
                                        final offset =
                                            _cubit.animation.value *
                                            maxOffset *
                                            -1;

                                        return Transform.translate(
                                          offset: Offset(offset, 0),
                                          child: child,
                                        );
                                      },
                                      child: OverflowBox(
                                        minWidth: 0,
                                        maxWidth: double.infinity,
                                        minHeight: size.height,
                                        maxHeight: size.height,
                                        alignment: Alignment.topLeft,
                                        child: Row(
                                          key: _rowKey,
                                          mainAxisSize: MainAxisSize.min,
                                          children: widget.backgroundType.assets
                                              .map((asset) {
                                                return SizedBox(
                                                  height: size.height,
                                                  child: asset.image(
                                                    fit: BoxFit.fitHeight,
                                                    height: size.height,
                                                  ),
                                                );
                                              })
                                              .toList(),
                                        ),
                                      ),
                                    );
                                  },
                                )
                              : const SizedBox.shrink(),
                        ),

                        /// Child content on top
                        widget.child,
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
