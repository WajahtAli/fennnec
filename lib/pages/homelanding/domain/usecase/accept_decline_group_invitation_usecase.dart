import 'package:fennac_app/pages/homelanding/data/models/accept_decline_invitation_model.dart';
import 'package:fennac_app/pages/homelanding/domain/repository/home_landing_repository.dart';

class AcceptDeclineGroupInvitationUseCase {
  final HomeLandingRepository repository;

  AcceptDeclineGroupInvitationUseCase(this.repository);

  Future<AcceptDeclineInvitationModel> call({
    required String groupId,
    required String type,
  }) async {
    return await repository.acceptDeclineGroupInvitation(
      groupId: groupId,
      type: type,
    );
  }
}
