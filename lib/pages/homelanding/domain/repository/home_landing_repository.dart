import 'package:fennac_app/pages/homelanding/data/models/accept_decline_invitation_model.dart';
import 'package:fennac_app/pages/homelanding/data/models/group_invitation_model.dart';

abstract class HomeLandingRepository {
  Future<GroupInvitationModel> fetchGroupInvitations();
  Future<AcceptDeclineInvitationModel> acceptDeclineGroupInvitation({
    required String groupId,
    required String type,
  });
}
