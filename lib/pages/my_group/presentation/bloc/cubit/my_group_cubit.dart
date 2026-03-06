import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/model/my_group_model.dart';
import '../../../domain/usecase/my_group_usecase.dart';
import '../state/my_group_state.dart';

class MyGroupCubit extends Cubit<MyGroupState> {
  final MyGroupUsecase _myGroupUsecase;
  MyGroupCubit(this._myGroupUsecase) : super(MyGroupInitial());

  // ========== DATA VARIABLES ==========
  MyGroupModel? myGroupModel;
  MyGroupModel? myGroupList;

  // ========== FETCH GROUP BY ID ==========
  Future<void> fetchGroupById(String groupId) async {
    if (groupId.isEmpty &&
        myGroupList != null &&
        myGroupList!.groupList != null &&
        myGroupList!.groupList!.isNotEmpty) {
      log('Using cached group list: ${myGroupList!.groupList?.length}');
      emit(MyGroupLoaded());
      return;
    }

    emit(MyGroupLoading());
    try {
      final result = await _myGroupUsecase.fetchGroupById(groupId);
      if (groupId.isEmpty) {
        myGroupList = result;
      } else {
        myGroupModel = result;
      }
      log('Fetched Group: ${result.groupList?.length}');
      emit(MyGroupLoaded());
    } catch (e) {
      log('Error fetching group: $e');
      emit(MyGroupError(e.toString()));
    }
  }

  // update my group data local
  void updateMyGroupDataLocal(MyGroupData data) {
    emit(MyGroupLoading());
    myGroupModel = myGroupModel?.copyWith(data: data);
    emit(MyGroupLoaded());
  }

  // ========== UPDATE GROUP BY ID ==========
  Future<void> updateGroupById(
    String groupId,
    Map<String, dynamic> body,
  ) async {
    emit(MyGroupLoading());
    try {
      final result = await _myGroupUsecase.updateGroupById(groupId, body);
      myGroupModel = result;
      log('Updated Group: ${result.data?.titleMembers}');
      emit(MyGroupLoaded());
    } catch (e) {
      log('Error updating group: $e');
      emit(MyGroupError(e.toString()));
    }
  }

  void clearGroupData() {
    emit(MyGroupLoading());
    myGroupModel = null;
    myGroupList = null;
    emit(MyGroupLoaded());
  }
}
