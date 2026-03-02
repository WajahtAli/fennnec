import 'package:fennac_app/app/constants/app_enums.dart';
import 'package:fennac_app/generated/assets.gen.dart';
import 'package:fennac_app/pages/homelanding/data/models/group_invitation_model.dart';
import 'package:fennac_app/pages/homelanding/domain/usecase/fetch_group_invitations_usecase.dart';
import 'package:fennac_app/pages/homelanding/presentation/bloc/state/home_landing_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeLandingCubit extends Cubit<HomeLandingState> {
  final FetchGroupInvitationsUseCase fetchGroupInvitationsUseCase;
  HomeLandingCubit(this.fetchGroupInvitationsUseCase)
    : super(HomeLandingInitial());

  List<Invitation> invitations = [];
  final bool isGroupAudioAvailable = true;
  List<String> groupImages = [
    Assets.dummy.groupNight.path,
    Assets.dummy.groupSunset.path,
    Assets.dummy.groupSunset.path,
    Assets.dummy.groupGlasses.path,
  ];
  InvitationStatus invitationStatus = InvitationStatus.pending;

  Future<void> fetchGroupInvitations() async {
    emit(HomeLandingLoading());
    try {
      final response = await fetchGroupInvitationsUseCase();
      if (response.success == true && response.data != null) {
        invitations = response.data!.invitations ?? [];
        emit(HomeLandingLoaded());
      } else {
        emit(HomeLandingError());
      }
    } catch (e) {
      emit(HomeLandingError());
    }
  }

  // int? selectedIndex;

  // void selectGroupIndex(int? index) {
  //   emit(HomeLandingLoading());
  //   selectedIndex = index;
  //   emit(HomeLandingLoaded());
  // }

  void selectDeclined(InvitationStatus value) {
    emit(HomeLandingLoading());
    invitationStatus = value;
    emit(HomeLandingLoaded());
  }
}
