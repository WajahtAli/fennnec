import 'package:auto_route/auto_route.dart';
import 'package:fennac_app/app/theme/app_colors.dart';
import 'package:fennac_app/app/theme/text_styles.dart';
import 'package:fennac_app/core/di_container.dart';
import 'package:fennac_app/pages/filter/presentation/bloc/cubit/filter_cubit.dart';
import 'package:fennac_app/pages/filter/presentation/widgets/map_widget.dart';
import 'package:fennac_app/widgets/custom_back_button.dart';
import 'package:fennac_app/widgets/custom_elevated_button.dart';
import 'package:fennac_app/widgets/custom_sized_box.dart';
import 'package:fennac_app/widgets/custom_text.dart';
import 'package:fennac_app/widgets/movable_background.dart';
import 'package:flutter/material.dart';

@RoutePage()
class DistanceScreen extends StatelessWidget {
  const DistanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MovableBackground(
        backgroundType: MovableBackgroundType.dark,
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CustomSizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const CustomBackButton(),
                    AppText(
                      text: 'Distance',
                      style: AppTextStyles.h1Large(
                        context,
                      ).copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(width: 48),
                  ],
                ),
              ),
              const CustomSizedBox(height: 24),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: const _DistanceContent(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DistanceContent extends StatefulWidget {
  const _DistanceContent();

  @override
  State<_DistanceContent> createState() => _DistanceContentState();
}

class _DistanceContentState extends State<_DistanceContent> {
  static const int _min = 1;
  static const int _max = 50;
  late int _current;
  final FilterCubit _filterCubit = Di().sl<FilterCubit>();

  @override
  void initState() {
    super.initState();
    final parsed = int.tryParse(
      _filterCubit.selectedDistance?.replaceAll(RegExp(r'[^0-9]'), '') ?? '0',
    );
    _current = (parsed ?? 15).clamp(_min, _max);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MapWidget(distanceMiles: _current),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AppText(
              text: _current.toString(),
              style: AppTextStyles.h1Large(
                context,
              ).copyWith(fontWeight: FontWeight.w700, fontSize: 48),
            ),
            const CustomSizedBox(width: 8),
            AppText(
              text: 'miles',
              style: AppTextStyles.bodyLarge(
                context,
              ).copyWith(fontWeight: FontWeight.w600, fontSize: 20),
            ),
          ],
        ),
        const CustomSizedBox(height: 24),
        _HorizontalPillSlider(
          min: _min,
          max: _max,
          value: _current,
          onChanged: (v) => setState(() => _current = v),
        ),
        const Spacer(),
        CustomElevatedButton(
          text: 'Done',
          onTap: () {
            _filterCubit.updateDistance('Max $_current miles');
            Navigator.of(context).pop();
          },
          width: double.infinity,
        ),
        const CustomSizedBox(height: 8),
      ],
    );
  }
}

class _HorizontalPillSlider extends StatelessWidget {
  final int min;
  final int max;
  final int value;
  final ValueChanged<int> onChanged;

  const _HorizontalPillSlider({
    required this.min,
    required this.max,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final primary = ColorPalette.primary;
    return SizedBox(
      height: 72,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final trackWidth = constraints.maxWidth;
          final progress = (value - min) / (max - min);
          final fillWidth = (trackWidth - 8) * progress;

          return Stack(
            alignment: Alignment.centerLeft,
            children: [
              Container(
                height: 72,
                width: trackWidth,
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(36),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.15),
                    width: 1,
                  ),
                ),
              ),
              AnimatedContainer(
                duration: const Duration(milliseconds: 120),
                height: 64,
                width: fillWidth.clamp(16.0, trackWidth),
                margin: const EdgeInsets.symmetric(horizontal: 4),
                decoration: BoxDecoration(
                  color: primary,
                  borderRadius: BorderRadius.circular(32),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.2),
                    width: 1.5,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: primary.withValues(alpha: 0.35),
                      blurRadius: 18,
                      spreadRadius: 2,
                    ),
                  ],
                ),
              ),
              Positioned(
                left: (fillWidth - 32).clamp(0.0, trackWidth - 64),
                child: Container(
                  height: 64,
                  width: 64,
                  decoration: BoxDecoration(
                    color: primary,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.25),
                      width: 1.5,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: primary.withValues(alpha: 0.45),
                        blurRadius: 18,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                ),
              ),
              Positioned.fill(
                child: GestureDetector(
                  onHorizontalDragUpdate: (details) {
                    final box = context.findRenderObject() as RenderBox?;
                    if (box == null) return;
                    final local = box.globalToLocal(details.globalPosition);
                    final x = local.dx.clamp(0.0, trackWidth);
                    final t = x / trackWidth;
                    final v = (min + t * (max - min)).round().clamp(min, max);
                    onChanged(v);
                  },
                  onTapDown: (details) {
                    final box = context.findRenderObject() as RenderBox?;
                    if (box == null) return;
                    final local = box.globalToLocal(details.globalPosition);
                    final x = local.dx.clamp(0.0, trackWidth);
                    final t = x / trackWidth;
                    final v = (min + t * (max - min)).round().clamp(min, max);
                    onChanged(v);
                  },
                  behavior: HitTestBehavior.opaque,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
