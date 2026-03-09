import 'dart:developer';

import 'package:fennac_app/helpers/gradient_toast.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fennac_app/pages/find_group/domain/usecase/find_group_usecase.dart';
import 'package:fennac_app/pages/my_group/data/model/my_group_model.dart';
import 'package:fennac_app/pages/find_group/data/model/qr_member_model.dart';
import '../state/find_group_state.dart';

class FindGroupCubit extends Cubit<FindGroupState> {
  final FindGroupUsecase _findGroupUsecase;

  FindGroupCubit(this._findGroupUsecase) : super(FindGroupInitial());

  MyGroupModel? myGroupModel;
  QrMemberModel? qrMemberModel;
  bool isJoining = false;
  String? currentQrCode;

  Future<void> fetchGroupByQr(String qrCode) async {
    emit(FindGroupLoading());
    try {
      currentQrCode = qrCode;
      final result = await _findGroupUsecase.fetchGroupByQr(qrCode);
      myGroupModel = result;
      log('Fetched group by QR: ${result.data?.titleMembers}');
      emit(FindGroupLoaded());
    } catch (e) {
      log('Error fetching group by QR: $e');
      emit(FindGroupError(e.toString()));
    }
  }

  Future<void> fetchMemberByQr(String qrCode) async {
    emit(FindGroupLoading());
    try {
      currentQrCode = qrCode;
      final result = await _findGroupUsecase.fetchMemberByQr(qrCode);
      qrMemberModel = result;
      log('Fetched member by QR: ${result.data?.firstName}');
      emit(FindGroupLoaded());
    } catch (e) {
      log('Error fetching member by QR: $e');
      emit(FindGroupError(e.toString()));
    }
  }

  Future<bool> joinGroupByQr(String qrCode) async {
    isJoining = true;
    emit(FindGroupLoading());
    try {
      final response = await _findGroupUsecase.joinGroupByQr(qrCode);
      final message = response['message'] ?? 'Successfully joined the group';
      VxToast.show(message: message);
      isJoining = false;
      emit(FindGroupLoaded());
      return true;
    } catch (e) {
      log('Error joining group by QR: $e');
      VxToast.show(message: e.toString());
      isJoining = false;
      emit(FindGroupError(e.toString()));
      return false;
    }
  }
}
