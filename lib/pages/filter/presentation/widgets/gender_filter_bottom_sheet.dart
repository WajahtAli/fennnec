import 'package:fennac_app/app/constants/app_enums.dart';
import 'package:fennac_app/app/constants/dummy_constants.dart';
import 'package:fennac_app/app/constants/media_query_constants.dart';
import 'package:fennac_app/app/theme/app_colors.dart';
import 'package:fennac_app/app/theme/text_styles.dart';
import 'package:fennac_app/pages/filter/presentation/bloc/cubit/filter_cubit.dart';
import 'package:fennac_app/reusable_widgets/dropdown_field_widget.dart';
import 'package:fennac_app/reusable_widgets/gender_selection_widget.dart';
import 'package:fennac_app/widgets/custom_elevated_button.dart';
import 'package:fennac_app/widgets/custom_sized_box.dart';
import 'package:fennac_app/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class GenderFilterBottomSheet extends StatefulWidget {
  final FilterCubit filterCubit;
  final ValueNotifier<bool>? blurNotifier;

  const GenderFilterBottomSheet({
    super.key,
    required this.filterCubit,
    this.blurNotifier,
  });

  @override
  State<GenderFilterBottomSheet> createState() =>
      _GenderFilterBottomSheetState();
}

class _GenderFilterBottomSheetState extends State<GenderFilterBottomSheet> {
  String? _tempSelectedGender;
  String? _tempSelectedPronoun;
  late List<String> _tempSelectedSexualOrientations;

  @override
  void initState() {
    super.initState();
    _tempSelectedGender = widget.filterCubit.selectedGender;
    _tempSelectedPronoun = widget.filterCubit.selectedPronoun;
    _tempSelectedSexualOrientations = List<String>.from(
      widget.filterCubit.selectedSexualOrientations ?? <String>[],
    );
  }

  void _applyAndClose() {
    widget.filterCubit.updateGender(_tempSelectedGender);
    widget.filterCubit.updatePronoun(_tempSelectedPronoun);
    widget.filterCubit.updateSexualOrientations(
      _tempSelectedSexualOrientations,
    );
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Container(
      height: height * 0.63,
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
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: isLightTheme(context)
                        ? Colors.black.withValues(alpha: 0.2)
                        : Colors.white.withValues(alpha: 0.3),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              AppText(
                text: "Adjust the type of members you'd like to meet.",
                textAlign: TextAlign.center,
                style: AppTextStyles.h3(context).copyWith(
                  color: isLightTheme(context) ? Colors.black : Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              CustomSizedBox(height: 20),
              AppText(
                text: 'Select Gender',
                style: AppTextStyles.inputLabel(context).copyWith(
                  color: isLightTheme(context) ? Colors.black : Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              CustomSizedBox(height: 12),
              GenderSelectionWidget(
                genders: DummyConstants.genders,
                selectedGender: _tempSelectedGender,
                onGenderSelected: (value) {
                  setState(() {
                    _tempSelectedGender = value;
                  });
                },
              ),
              CustomSizedBox(height: 24),
              DropdownFieldWidget(
                label: 'Your Sexual Orientation',
                subtitle: 'Select',
                selectedValues: _tempSelectedSexualOrientations,
                options: DummyConstants.sexualOrientations,
                selectionType: SelectionType.multiple,
                onMultipleSelected: (values) {
                  setState(() {
                    _tempSelectedSexualOrientations = List<String>.from(values);
                  });
                },
                blurNotifier: widget.blurNotifier,
              ),
              CustomSizedBox(height: 20),
              DropdownFieldWidget(
                label: 'Your Pronouns',
                subtitle: 'Select',
                selectedValue: _tempSelectedPronoun,
                options: DummyConstants.pronouns,
                selectionType: SelectionType.single,
                onSelected: (value) {
                  setState(() {
                    _tempSelectedPronoun = value;
                  });
                },
                blurNotifier: widget.blurNotifier,
              ),
              const Spacer(),
              CustomElevatedButton(
                text: 'Done',
                onTap: _applyAndClose,
                width: double.infinity,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
