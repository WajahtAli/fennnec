import 'package:fennac_app/pages/homelanding/data/models/group_invitation_model.dart';

abstract class HomeLandingRepository {
  Future<GroupInvitationModel> fetchGroupInvitations();
}
