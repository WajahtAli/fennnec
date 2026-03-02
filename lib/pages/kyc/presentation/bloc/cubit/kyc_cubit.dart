import 'dart:developer';

import 'package:fennac_app/app/constants/dummy_constants.dart';
import 'package:fennac_app/pages/kyc/presentation/bloc/state/kyc_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class KycCubit extends Cubit<KycState> {
  KycCubit() : super(KycInitial()) {
    shortBioController = TextEditingController();
    jobTitleController = TextEditingController();
    educationController = TextEditingController();
  }
  DateTime? selectedDate;
  String? selectedGender;
  List<String> selectedSexualOrientations = [];

  String? selectedPronoun;
  List<String> selectedLifestyles = [];
  List<String> selectedInterests = [];

  late final TextEditingController shortBioController;
  late final TextEditingController jobTitleController;
  late final TextEditingController educationController;

  FixedExtentScrollController? dayController;
  FixedExtentScrollController? monthController;
  FixedExtentScrollController? yearController;

  void toggleLifestyle(String lifestyle) {
    emit(KycLoading());
    if (selectedLifestyles.contains(lifestyle)) {
      selectedLifestyles.remove(lifestyle);
    } else {
      selectedLifestyles.add(lifestyle);
    }
    emit(KycLoaded());
  }

  void selectSexualOrientations(List<String> orientations) {
    log('Selected sexual orientations: $orientations');
    emit(KycLoading());
    selectedSexualOrientations = List.from(orientations);
    emit(KycLoaded());
  }

  void toggleInterest(String interest) {
    emit(KycLoading());
    if (selectedInterests.contains(interest)) {
      selectedInterests.remove(interest);
    } else {
      selectedInterests.add(interest);
    }
    emit(KycLoaded());
  }

  /// Strip emojis from text
  String _stripEmojis(String text) {
    return text.replaceAll(RegExp(r'[\p{Emoji}]+', unicode: true), '').trim();
  }

  Map<String, List<String>> getSelectedVibes() {
    final Map<String, List<String>> vibes = {};

    // Map UI category names to backend format
    final categoryMapping = {
      'Sports & Outdoors': 'sports and outdoor',
      'Food & Drink': 'food and drink',
      'Music & Arts': 'music and arts',
      'Travel & Adventure': 'travel and adventure',
      'Tech & Gaming': 'tech and gaming',
      'Reading & Learning': 'reading and learning',
      'Other Fun Interests': 'other fun interests',
    };

    DummyConstants.interestCategories.forEach((category, interests) {
      final selected = interests
          .where((interest) => selectedInterests.contains(interest))
          .toList();

      if (selected.isNotEmpty) {
        // Transform category key and strip emojis from values
        final backendKey = categoryMapping[category] ?? category.toLowerCase();
        final cleanedValues = selected
            .map((v) => _stripEmojis(v).toLowerCase())
            .toList();
        vibes[backendKey] = cleanedValues;
      }
    });

    return vibes;
  }

  void selectGender(String gender) {
    emit(KycLoading());
    selectedGender = gender;
    emit(KycLoaded());
  }

  void setSelectedDate(DateTime? date) {
    emit(KycLoading());
    selectedDate = date;
    emit(KycLoaded());
  }

  void selectPronouns(String pronouns) {
    emit(KycLoading());
    selectedPronoun = pronouns;
    emit(KycLoaded());
  }

  // In your Cubit
  void updateDate(Function(DateTime)? onDateSelected) {
    if (selectedDate == null ||
        dayController == null ||
        monthController == null ||
        yearController == null) {
      return;
    }

    emit(KycLoading());
    final daysInMonth = DateTime(
      selectedDate!.year,
      selectedDate!.month + 1,
      0,
    ).day;
    final day = (dayController!.selectedItem % daysInMonth) + 1;
    final month = (monthController!.selectedItem % 12) + 1;
    final year = DateTime.now().year - (yearController!.selectedItem % 100);

    selectedDate = DateTime(year, month, day);
    onDateSelected?.call(selectedDate!);
    emit(KycLoaded());
  }

  @override
  Future<void> close() {
    shortBioController.dispose();
    jobTitleController.dispose();
    educationController.dispose();
    dayController?.dispose();
    monthController?.dispose();
    yearController?.dispose();
    return super.close();
  }
}
