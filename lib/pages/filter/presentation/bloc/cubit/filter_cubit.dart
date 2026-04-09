import 'package:fennac_app/core/di_container.dart';
import 'package:fennac_app/pages/filter/presentation/bloc/state/filter_state.dart';
import 'package:fennac_app/pages/home/presentation/bloc/cubit/groups_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FilterCubit extends Cubit<FilterState> {
  FilterCubit() : super(FilterInitial());

  // Filter state variables with null defaults (not selected)
  String? selectedCategory;
  String? selectedGender;
  String? selectedGroupSize;
  int? selectedGroupSizeValue;
  String? selectedDistance;
  int? selectedDistanceValue;
  String? selectedAgeRange;
  int? selectedAgeMin;
  int? selectedAgeMax;
  List<String>? selectedSexualOrientations;
  String? selectedPronoun;
  double? selectedLatitude;
  double? selectedLongitude;
  String? selectedLocationAddress;

  // Helper to check if any filter is applied
  bool get hasActiveFilters {
    return selectedCategory != null ||
        selectedGender != null ||
        selectedGroupSize != null ||
        selectedDistance != null ||
        selectedLatitude != null ||
        selectedLongitude != null ||
        selectedAgeRange != null ||
        (selectedSexualOrientations != null &&
            selectedSexualOrientations!.isNotEmpty) ||
        selectedPronoun != null;
  }

  // Computed property to display all selected "Who's in the Group?" filters
  String get groupMemberFiltersDisplay {
    final List<String> filters = [];

    if (selectedGender != null && selectedGender!.isNotEmpty) {
      filters.add(selectedGender!);
    }

    if (selectedSexualOrientations != null &&
        selectedSexualOrientations!.isNotEmpty) {
      filters.add(selectedSexualOrientations!.join(', '));
    }

    if (selectedPronoun != null && selectedPronoun!.isNotEmpty) {
      filters.add(selectedPronoun!);
    }

    return filters.isEmpty ? '' : filters.join(' • ');
  }

  // Filter update methods
  void updateCategory(String? category) {
    emit(FilterLoading());

    if (selectedCategory == category) {
      selectedCategory = '';
    } else {
      selectedCategory = category;
    }

    emit(FilterLoaded());
  }

  void updateGender(String? gender) {
    emit(FilterLoading());
    selectedGender = gender;
    emit(FilterLoaded());
  }

  void updateGroupSize(String? size) {
    emit(FilterLoading());
    selectedGroupSize = size;
    if (size != null) {
      final parsed = int.tryParse(size.replaceAll(RegExp(r'[^0-9]'), ''));
      selectedGroupSizeValue = parsed;
    } else {
      selectedGroupSizeValue = null;
    }
    emit(FilterLoaded());
  }

  void updateGroupSizeValue(int? value) {
    emit(FilterLoading());
    if (value != null) {
      selectedGroupSizeValue = value;
      selectedGroupSize = 'Max $value people';
    } else {
      selectedGroupSize = null;
      selectedGroupSizeValue = null;
    }
    emit(FilterLoaded());
  }

  void updateDistance(String? distance) {
    emit(FilterLoading());
    selectedDistance = distance;
    if (distance != null) {
      selectedDistanceValue = _extractDistanceValue(distance);
    } else {
      selectedDistanceValue = null;
    }
    emit(FilterLoaded());
  }

  void updateAgeRange(String? ageRange) {
    emit(FilterLoading());
    selectedAgeRange = ageRange;
    if (ageRange != null) {
      // Check if it's a "55+" format
      if (ageRange.contains('+')) {
        final minStr = ageRange.replaceAll(RegExp(r'[^0-9]'), '').trim();
        selectedAgeMin = minStr.isNotEmpty ? int.tryParse(minStr) : null;
        selectedAgeMax = 80; // Set max age for "55+" case
      } else {
        final ages = ageRange.split('-');
        // Extract only digits from each part to handle "18 - 25 years old" format
        final minStr = ages.first.replaceAll(RegExp(r'[^0-9]'), '').trim();
        final maxStr = ages.length > 1
            ? ages.last.replaceAll(RegExp(r'[^0-9]'), '').trim()
            : '';

        selectedAgeMin = minStr.isNotEmpty ? int.tryParse(minStr) : null;
        selectedAgeMax = maxStr.isNotEmpty ? int.tryParse(maxStr) : null;
      }
    } else {
      selectedAgeMin = null;
      selectedAgeMax = null;
    }
    emit(FilterLoaded());
  }

  void updateAgeRangeValues(int? minAge, int? maxAge) {
    emit(FilterLoading());
    if (minAge != null && maxAge != null) {
      selectedAgeMin = minAge;
      selectedAgeMax = maxAge;
      selectedAgeRange = '$minAge - $maxAge years old';
    } else {
      selectedAgeRange = null;
      selectedAgeMin = null;
      selectedAgeMax = null;
    }
    emit(FilterLoaded());
  }

  void updateSexualOrientations(List<String>? orientations) {
    emit(FilterLoading());
    selectedSexualOrientations = orientations != null && orientations.isNotEmpty
        ? List.from(orientations)
        : null;
    emit(FilterLoaded());
  }

  void updatePronoun(String? pronoun) {
    emit(FilterLoading());
    selectedPronoun = pronoun;
    emit(FilterLoaded());
  }

  void updateSelectedLocation({
    double? latitude,
    double? longitude,
    String? address,
  }) {
    emit(FilterLoading());
    selectedLatitude = latitude;
    selectedLongitude = longitude;
    selectedLocationAddress = address;
    emit(FilterLoaded());
  }

  // Reset all filters
  void resetFilters() {
    emit(FilterLoading());

    selectedCategory = null;
    selectedGender = null;
    selectedGroupSize = null;
    selectedGroupSizeValue = null;
    selectedDistance = null;
    selectedDistanceValue = null;
    selectedAgeRange = null;
    selectedAgeMin = null;
    selectedAgeMax = null;
    selectedSexualOrientations = null;
    selectedPronoun = null;
    selectedLatitude = null;
    selectedLongitude = null;
    selectedLocationAddress = null;

    // Fetch groups without any filter parameters
    Di().sl<GroupsCubit>().fetchAllGroups(
      page: 1,
      limit: 10,
      queryParameters: null,
    );

    emit(FilterLoaded());
  }

  // Apply filters - only include selected filters
  void applyFilters() {
    emit(FilterLoading());

    // Build query parameters from selected filters
    final Map<String, dynamic> queryParameters = _buildQueryParameters();

    // Fetch groups with applied filters (or all if no filters)
    Di().sl<GroupsCubit>().fetchAllGroups(
      page: 1,
      limit: 10,
      queryParameters: queryParameters.isNotEmpty ? queryParameters : null,
    );

    emit(FilterLoaded());
  }

  // Build query parameters - ONLY include filters that are actually selected
  Map<String, dynamic> _buildQueryParameters() {
    final params = <String, dynamic>{};

    // Add category only if selected (lowercase format)
    if (selectedCategory != null && selectedCategory!.isNotEmpty) {
      final categoryName = _extractFilterName(selectedCategory!);
      if (categoryName.isNotEmpty) {
        params['fitsForGroup'] = categoryName.toLowerCase();
      }
    }

    // Add gender only if selected and not "All genders" (lowercase format)
    if (selectedGender != null &&
        selectedGender!.isNotEmpty &&
        selectedGender != 'All genders') {
      params['gender'] = selectedGender!.toLowerCase();
    }

    // Add group size only if explicitly selected
    if (selectedGroupSizeValue != null && selectedGroupSizeValue! > 0) {
      params['groupSize'] = selectedGroupSizeValue;
    }

    // Add distance only if explicitly selected
    if (selectedDistanceValue != null && selectedDistanceValue! > 0) {
      params['maxDistance'] = selectedDistanceValue;
    }

    if (selectedLatitude != null && selectedLongitude != null) {
      params['latitude'] = selectedLatitude;
      params['longitude'] = selectedLongitude;
    }

    if (selectedLocationAddress != null &&
        selectedLocationAddress!.isNotEmpty) {
      params['address'] = selectedLocationAddress;
    }

    // Add age range only if both min and max are set
    if (selectedAgeMin != null &&
        selectedAgeMax != null &&
        selectedAgeMin! > 0 &&
        selectedAgeMax! > 0) {
      params['ageRange'] = '$selectedAgeMin-$selectedAgeMax';
    }

    // Add sexual orientations only if available (lowercase format)
    if (selectedSexualOrientations != null &&
        selectedSexualOrientations!.isNotEmpty) {
      final lowercaseOrientations = selectedSexualOrientations!
          .map((orientation) => orientation.toLowerCase())
          .toList();
      params['sexualOrientation'] = lowercaseOrientations.join(',');
    }

    // Add pronouns only if selected (keep original case)
    if (selectedPronoun != null && selectedPronoun!.isNotEmpty) {
      params['pronouns'] = selectedPronoun;
    }

    return params;
  }

  // Helper method to extract filter name without emoji (preserves &)
  String _extractFilterName(String filterValue) {
    // Remove emoji but preserve special characters like &
    return filterValue
        .replaceAll(RegExp(r'[\p{Emoji}]+', unicode: true), '')
        .trim();
  }

  // Helper method to extract distance value from string
  int? _extractDistanceValue(String distanceStr) {
    if (distanceStr == 'Any distance') {
      return null;
    }
    final match = RegExp(r'(\d+)').firstMatch(distanceStr);
    return match != null ? int.tryParse(match.group(1)!) : null;
  }
}
