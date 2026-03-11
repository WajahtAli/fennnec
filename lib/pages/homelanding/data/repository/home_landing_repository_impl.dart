import 'package:fennac_app/pages/homelanding/data/datasource/home_landing_datasource.dart';
import 'package:fennac_app/pages/homelanding/data/models/accept_decline_invitation_model.dart';
import 'package:fennac_app/pages/homelanding/domain/repository/home_landing_repository.dart';
import '../models/group_invitation_model.dart';

class HomeLandingRepositoryImpl implements HomeLandingRepository {
  final HomeLandingDatasource datasource;
  HomeLandingRepositoryImpl(this.datasource);

  @override
  Future<GroupInvitationModel> fetchGroupInvitations() async {
    return await datasource.fetchGroupInvitations();
  }

  @override
  Future<AcceptDeclineInvitationModel> acceptDeclineGroupInvitation({
    required String groupId,
    required String type,
  }) async {
    return await datasource.acceptDeclineGroupInvitation(
      groupId: groupId,
      type: type,
    );
  }
}
