import 'dart:developer';
import 'package:fennac_app/helpers/gradient_toast.dart';
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
    log(
      'Updated local group data: ${data.members?.map((e) {
        return e.image;
      }).toList()}',
    );
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
      emit(MyGroupLoaded());
      rethrow;
    }
  }

  Future<bool> deleteGroupById(String groupId) async {
    emit(MyGroupLoading());
    try {
      final response = await _myGroupUsecase.deleteGroupById(groupId);
      final String message = response is Map<String, dynamic>
          ? (response['message']?.toString() ?? 'Group deleted successfully')
          : 'Group deleted successfully';

      if (myGroupModel?.data?.id == groupId) {
        myGroupModel = null;
      }

      if (myGroupList?.groupList != null) {
        final updatedGroupList = myGroupList!.groupList!
            .where((group) => group.id != groupId)
            .toList();
        myGroupList = MyGroupModel(
          success: myGroupList?.success,
          message: myGroupList?.message,
          groupList: updatedGroupList,
        );
      }

      VxToast.show(message: message);
      emit(MyGroupLoaded());
      return true;
    } catch (e) {
      final String errorMessage = e.toString();
      VxToast.show(message: errorMessage);
      emit(MyGroupError(errorMessage));
      return false;
    }
  }

  Future<bool> unMatchGroupById(String groupId) async {
    emit(MyGroupLoading());
    try {
      final response = await _myGroupUsecase.unMatchGroupById(groupId);
      final String message = response is Map<String, dynamic>
          ? (response['message']?.toString() ?? 'Group unmatched successfully')
          : 'Group unmatched successfully';

      if (myGroupModel?.data?.id == groupId) {
        myGroupModel = null;
      }

      if (myGroupList?.groupList != null) {
        final updatedGroupList = myGroupList!.groupList!
            .where((group) => group.id != groupId)
            .toList();
        myGroupList = MyGroupModel(
          success: myGroupList?.success,
          message: myGroupList?.message,
          groupList: updatedGroupList,
        );
      }

      VxToast.show(message: message);
      emit(MyGroupLoaded());
      return true;
    } catch (e) {
      final String errorMessage = e.toString();
      VxToast.show(message: errorMessage);
      emit(MyGroupError(errorMessage));
      return false;
    }
  }

  void clearGroupData() {
    emit(MyGroupLoading());
    myGroupModel = null;
    myGroupList = null;
    emit(MyGroupLoaded());
  }
}
