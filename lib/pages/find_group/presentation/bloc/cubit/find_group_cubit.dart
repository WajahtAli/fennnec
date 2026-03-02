import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fennac_app/pages/find_group/domain/usecase/find_group_usecase.dart';
import 'package:fennac_app/pages/my_group/data/model/my_group_model.dart';
import '../state/find_group_state.dart';

class FindGroupCubit extends Cubit<FindGroupState> {
  final FindGroupUsecase _findGroupUsecase;

  FindGroupCubit(this._findGroupUsecase) : super(FindGroupInitial());

  MyGroupModel? myGroupModel;

  Future<void> fetchGroupByQr(String qrCode) async {
    emit(FindGroupLoading());
    try {
      final result = await _findGroupUsecase.fetchGroupByQr(qrCode);
      myGroupModel = result;
      log('Fetched group by QR: ${result.data?.titleMembers}');
      emit(FindGroupLoaded());
    } catch (e) {
      log('Error fetching group by QR: $e');
      emit(FindGroupError(e.toString()));
    }
  }
}
