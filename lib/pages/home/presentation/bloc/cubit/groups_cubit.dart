import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fennac_app/pages/home/data/models/groups_model.dart';
import 'package:fennac_app/core/di_container.dart';
import 'package:fennac_app/pages/home/presentation/bloc/cubit/home_cubit.dart';
import '../../../../liked_groups/presentation/bloc/cubit/liked_groups_cubit.dart';
import '../../../domain/usecase/groups_usecase.dart';
import '../state/groups_state.dart';

class GroupsCubit extends Cubit<GroupsState> {
  final GroupsUsecase _groupsUsecase;

  GroupsCubit(this._groupsUsecase) : super(GroupsInitial());

  GroupsModel? groupsModel;
  GroupsModel? backupGroupsModel;
  Map<String, dynamic>? acceptGroupReqResponse;

  Future<void> fetchAllGroups({
    int page = 1,
    int limit = 10,
    Map<String, dynamic>? queryParameters,
    final bool isLikedGroups = false,
  }) async {
    emit(GroupsLoading());
    try {
      if (isLikedGroups) {
        await Di().sl<LikedGroupsCubit>().fetchPeopleWhoLikedMe();
        final groups =
            Di().sl<LikedGroupsCubit>().groupsModel?.data?.groups ?? [];
        Di().sl<HomeCubit>().updateGroups(groups);
      } else {
        final result = await _groupsUsecase.fetchAllGroups(
          page: page,
          limit: limit,
          queryParameters: queryParameters,
        );
        backupGroupsModel = result;
        groupsModel = result;
        final groups = groupsModel?.data?.groups ?? [];
        log("home groups  ${groups.length}");
        Di().sl<HomeCubit>().updateGroups(groups);
      }
      log('Fetched Groups: ${groupsModel?.data?.groups?.first.groupTag}');
      emit(GroupsSuccess());
    } catch (e) {
      emit(GroupsError(e.toString()));
    }
  }

  // reset groups
  void resetGroups() {
    log("resetGroups ${groupsModel?.data?.groups?.length}");
    emit(GroupsLoading());
    groupsModel = backupGroupsModel;
    Di().sl<HomeCubit>().updateGroups(groupsModel?.data?.groups ?? []);
    emit(GroupsSuccess());
  }

  // backup groups
  void backupGroups() {
    emit(GroupsLoading());
    backupGroupsModel = groupsModel;
    groupsModel = null;
    Di().sl<HomeCubit>().resetGroups();
    emit(GroupsSuccess());
  }

  Future<void> likeDislikeGroup({
    required String groupId,
    required String type,
  }) async {
    try {
      await _groupsUsecase.likeDislikeGroup(groupId: groupId, type: type);
      log('Group $type action successful for groupId: $groupId');
    } catch (e) {
      log('Error in $type action: $e');
      rethrow;
    }
  }

  Future<Map<String, dynamic>> reportGroup({
    required String groupId,
    required String reason,
    String? customReason,
  }) async {
    try {
      emit(GroupsLoading());
      final response = await _groupsUsecase.reportGroup(
        groupId: groupId,
        reason: reason,
        customReason: customReason,
      );
      log('Report submitted for groupId: $groupId');
      emit(GroupsSuccess());
      return response;
    } catch (e) {
      log(e.toString());
      emit(GroupsError(e.toString()));
      rethrow;
    }
  }

  Future<Map<String, dynamic>> reportUser({
    required String userId,
    required String reason,
    String? customReason,
  }) async {
    try {
      emit(GroupsLoading());
      final response = await _groupsUsecase.reportUser(
        userId: userId,
        reason: reason,
        customReason: customReason,
      );
      log('Report submitted for userId: $userId');
      emit(GroupsSuccess());
      return response;
    } catch (e) {
      log(e.toString());
      emit(GroupsError(e.toString()));
      rethrow;
    }
  }

  Future<void> acceptGroupReq({
    required String groupId,
    required String type,
  }) async {
    try {
      final response = await _groupsUsecase.acceptGroupReq(
        groupId: groupId,
        type: type,
      );
      acceptGroupReqResponse = response;
      log('Group request $type for groupId: $groupId');
    } catch (e) {
      log('Error $type group request: $e');
      rethrow;
    }
  }

  void clearGroupData() {
    emit(GroupsLoading());
    groupsModel = null;
    acceptGroupReqResponse = null;
    emit(GroupsSuccess());
  }
}
