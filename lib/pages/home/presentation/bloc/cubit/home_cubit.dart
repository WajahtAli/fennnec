import 'dart:developer';

import 'package:fennac_app/pages/buy_poke/domain/usecase/send_poke_usecase.dart';
import 'package:fennac_app/pages/home/data/models/groups_model.dart';
import 'package:fennac_app/pages/home/presentation/bloc/state/home_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';

import '../../../../../app/constants/app_enums.dart';
import '../../widgets/group_gallery_widget.dart';

class HomeCubit extends Cubit<HomeState> {
  final SendPokeUseCase _sendPokeUseCase;

  HomeCubit(this._sendPokeUseCase) : super(HomeInitial());

  // ========== BOOLEAN VARIABLES ==========
  final bool isGroupAudioAvailable = true;

  final cardSwiperController = CardSwiperController();

  ScrollController sController = ScrollController();

  double xAxisCardValue = 0;

  bool isEnd = false;

  // update values
  void updateCardPosition(double x) {
    emit(HomeLoading());
    xAxisCardValue = x;
    emit(HomeLoaded());
  }

  // is disliking
  bool isDisliking() {
    return xAxisCardValue < -100;
  }

  // is liking
  bool isLiking() {
    return xAxisCardValue > 100;
  }

  // is value reset
  bool isValueReset() {
    return xAxisCardValue < 100 && xAxisCardValue > -100;
  }

  // ========== NUMERIC VARIABLES ==========
  int? selectedProfileIndex;
  int isDeclined = 0;

  int selectedGroupIndex = 0;
  // ========== CUSTOM OBJECTS ==========
  List<Member> get selectedProfiles => selectedGroupIndex < groups.length
      ? (groups[selectedGroupIndex].members ?? [])
      : [];
  Member? selectedProfile;
  SelectedProfile? selectedProfileType;

  // ========== METHODS ==========
  void selectProfileIndex(int? index) {
    emit(HomeLoading());
    selectedProfileIndex = index;
    // Update selected profile based on index
    if (index != null && index < selectedProfiles.length) {
      selectedProfile = selectedProfiles[index];
    } else {
      selectedProfile = null;
      emit(HomeLoaded());
    }
    emit(HomeLoaded());
  }

  final List<Group> groups = [];
  int currentIndex = 0;

  bool get isEndOfList => currentIndex >= groups.length;

  void onSwipeCompleted(SwipeResult result) {
    emit(HomeLoading());
    if (isEndOfList) return;
    // Move to next card
    currentIndex++;
    selectedGroupIndex = currentIndex;
    log("currentIndex: $currentIndex");
    emit(HomeLoaded());
  }

  Group? get currentGroup =>
      currentIndex < groups.length ? groups[currentIndex] : null;

  Group? get nextGroup =>
      currentIndex + 1 < groups.length ? groups[currentIndex + 1] : null;

  void updateGroups(List<Group> newGroups) {
    emit(HomeLoading());
    groups
      ..clear()
      ..addAll(newGroups);
    currentIndex = 0;
    selectedGroupIndex = 0;
    selectedProfileIndex = null;
    selectedProfile = null;
    isEnd = false;
    emit(HomeLoaded());
  }

  void removeGroupById(String groupId) {
    emit(HomeLoading());
    groups.removeWhere((group) => group.id == groupId);
    emit(HomeLoaded());
  }

  void removeGroupAt(int index) {
    emit(HomeLoading());
    if (index >= 0 && index < groups.length) {
      groups.removeAt(index);
      // Adjust selectedGroupIndex if necessary
      if (selectedGroupIndex >= groups.length) {
        selectedGroupIndex = groups.isEmpty ? 0 : groups.length - 1;
      }
    }
    emit(HomeLoaded());
  }

  void selectGroupIndex(int? index) {
    emit(HomeLoading());
    selectedGroupIndex = index ?? 0;
    emit(HomeLoaded());
  }

  void selectProfileById(String? id) {
    emit(HomeLoading());
    if (id == null) {
      selectedProfile = null;
      selectedProfileIndex = null;
      emit(HomeLoaded());
      return;
    }

    final idx = selectedProfiles.indexWhere((p) => p.id == id);
    if (idx != -1) {
      selectedProfileIndex = idx;
      selectedProfile = selectedProfiles[idx];
    } else {
      selectedProfileIndex = null;
      selectedProfile = null;
    }
    emit(HomeLoaded());
  }

  void selectDeclined(int value) {
    emit(HomeLoading());
    isDeclined = value;
    emit(HomeLoaded());
  }

  void markEndReached() {
    emit(HomeLoading());
    isEnd = true;
    emit(HomeLoaded());
  }

  void restartFromBeginning() {
    emit(HomeLoading());
    isEnd = false;
    selectedGroupIndex = 0;
    selectedProfileIndex = null;
    selectedProfile = null;
    cardSwiperController.moveTo(0);
    currentIndex = 0;
    emit(HomeLoaded());
  }

  Member? getProfileById(String id) {
    try {
      return selectedProfiles.firstWhere((profile) => profile.id == id);
    } catch (e) {
      return null;
    }
  }

  // ========== SEND POKE METHOD ==========
  Future<void> sendPoke({required String toUserId}) async {
    emit(HomeLoading());
    try {
      final response = await _sendPokeUseCase(toUserId: toUserId);
      log('Poke sent successfully: $response');
      emit(HomeLoaded());
    } catch (e) {
      log('Error sending poke: $e');
      emit(HomeLoaded());
      rethrow;
    }
  }
}
