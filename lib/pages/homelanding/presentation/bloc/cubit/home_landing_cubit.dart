import 'package:fennac_app/app/constants/app_enums.dart';
import 'package:fennac_app/generated/assets.gen.dart';
import 'package:fennac_app/helpers/gradient_toast.dart';
import 'package:fennac_app/pages/homelanding/data/models/group_invitation_model.dart';
import 'package:fennac_app/pages/homelanding/domain/usecase/accept_decline_group_invitation_usecase.dart';
import 'package:fennac_app/pages/homelanding/domain/usecase/fetch_group_invitations_usecase.dart';
import 'package:fennac_app/pages/homelanding/presentation/bloc/state/home_landing_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeLandingCubit extends Cubit<HomeLandingState> {
  final FetchGroupInvitationsUseCase fetchGroupInvitationsUseCase;
  final AcceptDeclineGroupInvitationUseCase acceptDeclineGroupInvitationUseCase;

  HomeLandingCubit(
    this.fetchGroupInvitationsUseCase,
    this.acceptDeclineGroupInvitationUseCase,
  ) : super(HomeLandingInitial());

  List<Invitation> invitations = [];
  final bool isGroupAudioAvailable = true;
  List<String> groupImages = [
    Assets.dummy.groupNight.path,
    Assets.dummy.groupSunset.path,
    Assets.dummy.groupSunset.path,
    Assets.dummy.groupGlasses.path,
  ];
  InvitationStatus invitationStatus = InvitationStatus.pending;

  bool isLoading = false;

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

  Future<void> acceptDeclineGroupInvitation({
    required String groupId,
    required String type,
  }) async {
    isLoading = true;
    emit(AcceptDeclineInvitationLoading());
    try {
      final response = await acceptDeclineGroupInvitationUseCase(
        groupId: groupId,
        type: type,
      );
      if (response.success == true) {
        isLoading = false;
        VxToast.show(
          message: response.message ?? 'Action completed successfully',
        );
        emit(
          AcceptDeclineInvitationSuccess(
            response.message ?? 'Action completed successfully',
          ),
        );

        await fetchGroupInvitations();
      } else {
        isLoading = false;
        VxToast.show(message: response.message ?? 'Failed to complete action');
        emit(
          AcceptDeclineInvitationError(
            response.message ?? 'Failed to complete action',
          ),
        );
      }
    } catch (e) {
      isLoading = false;
      VxToast.show(message: e.toString());
      emit(AcceptDeclineInvitationError(e.toString()));
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
