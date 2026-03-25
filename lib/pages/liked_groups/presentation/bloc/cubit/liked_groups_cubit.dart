import 'package:fennac_app/pages/liked_groups/presentation/bloc/state/like_groups_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fennac_app/pages/home/data/models/groups_model.dart';
import '../../../domain/usecase/liked_groups_usecase.dart';

class LikedGroupsCubit extends Cubit<LikedGroupsState> {
  final LikedGroupsUsecase usecase;
  LikedGroupsCubit(this.usecase) : super(LikedGroupsInitial());

  GroupsModel? groupsModel;

  Future<void> fetchPeopleWhoLikedMe() async {
    emit(LikedGroupsLoading());
    try {
      final result = await usecase.peopleWhoLikedMe();
      groupsModel = result;
      emit(LikedGroupsSuccess());
    } catch (e) {
      emit(LikedGroupsError(e.toString()));
    }
  }
}
