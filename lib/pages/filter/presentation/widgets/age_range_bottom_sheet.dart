import 'package:fennac_app/app/constants/media_query_constants.dart';
import 'package:fennac_app/app/theme/app_colors.dart';
import 'package:fennac_app/app/theme/text_styles.dart';
import 'package:fennac_app/pages/filter/presentation/bloc/cubit/filter_cubit.dart';
import 'package:fennac_app/pages/filter/presentation/widgets/dual_border_range_thumb_shape.dart';
import 'package:fennac_app/utils/validators.dart';
import 'package:fennac_app/widgets/custom_elevated_button.dart';
import 'package:fennac_app/widgets/custom_sized_box.dart';
import 'package:fennac_app/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class AgeRangeBottomSheet extends StatefulWidget {
  final FilterCubit filterCubit;

  const AgeRangeBottomSheet({super.key, required this.filterCubit});

  @override
  State<AgeRangeBottomSheet> createState() => _AgeRangeBottomSheetState();
}

class _AgeRangeBottomSheetState extends State<AgeRangeBottomSheet> {
  late RangeValues _values;
  static const double _minAge = 18;
  static const double _maxAge = 80;

  @override
  void initState() {
    super.initState();
    final startValue = validateDouble(widget.filterCubit.selectedAgeMin);
    final endValue = validateDouble(widget.filterCubit.selectedAgeMax);

    _values = RangeValues(
      startValue.clamp(_minAge, _maxAge),
      endValue.clamp(_minAge, _maxAge),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: getHeight(context) * 0.5,
      decoration: BoxDecoration(
        gradient: isLightTheme(context)
            ? null
            : LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [ColorPalette.secondary, ColorPalette.black],
              ),
        color: isLightTheme(context) ? Colors.white : null,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(32),
          topRight: Radius.circular(32),
        ),
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 24, 24, 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: isLightTheme(context)
                      ? Colors.black.withValues(alpha: 0.2)
                      : Colors.white.withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 32),
              AppText(
                text: "What's the preferred age group?",
                textAlign: TextAlign.center,
                style: AppTextStyles.h3(context).copyWith(
                  color: isLightTheme(context) ? Colors.black : Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 32),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AppText(
                    text: _values.start.round().toString(),
                    style: AppTextStyles.h1(context).copyWith(
                      color: isLightTheme(context)
                          ? Colors.black
                          : Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Container(
                      width: 32,
                      height: 2,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: isLightTheme(context)
                              ? [
                                  Colors.black.withValues(alpha: 0.7),
                                  Colors.black.withValues(alpha: 0.3),
                                ]
                              : [
                                  Colors.white.withValues(alpha: 0.7),
                                  Colors.white.withValues(alpha: 0.3),
                                ],
                        ),
                      ),
                    ),
                  ),
                  AppText(
                    text: _values.end.round().toString(),
                    style: AppTextStyles.h1(context).copyWith(
                      color: isLightTheme(context)
                          ? Colors.black
                          : Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(36),
                  border: Border.all(color: ColorPalette.grey, width: 2),
                ),
                child: Container(
                  height: 60,
                  padding: const EdgeInsets.symmetric(
                    // horizontal: 12,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(32),
                    border: Border.all(color: ColorPalette.grey, width: 1.5),
                  ),
                  child: SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                      trackHeight: 60,
                      activeTrackColor: ColorPalette.primary.withValues(
                        alpha: 0.8,
                      ),
                      inactiveTrackColor: Colors.transparent,
                      overlayColor: ColorPalette.primary.withValues(
                        alpha: 0.16,
                      ),
                      rangeThumbShape: DualBorderRangeThumbShape(
                        radius: 32,
                        strokeWidth: 2,
                        fillColor: ColorPalette.primary,
                        outerBorderColor: ColorPalette.secondary,
                        innerBorderColor: ColorPalette.primary,
                      ),
                      rangeTrackShape: const RectangularRangeSliderTrackShape(),
                    ),
                    child: RangeSlider(
                      values: _values,
                      min: _minAge,
                      max: _maxAge,
                      divisions: (_maxAge - _minAge).round(),
                      labels: RangeLabels(
                        _values.start.round().toString(),
                        _values.end.round().toString(),
                      ),
                      onChanged: (values) {
                        setState(() {
                          _values = RangeValues(
                            values.start.roundToDouble(),
                            values.end.roundToDouble(),
                          );
                        });
                      },
                    ),
                  ),
                ),
              ),

              CustomSizedBox(height: 20),

              CustomElevatedButton(
                text: 'Done',
                onTap: () {
                  widget.filterCubit.updateAgeRangeValues(
                    _values.start.round(),
                    _values.end.round(),
                  );
                  Navigator.of(context).pop();
                },
                width: double.infinity,
              ),
              const CustomSizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }
}
