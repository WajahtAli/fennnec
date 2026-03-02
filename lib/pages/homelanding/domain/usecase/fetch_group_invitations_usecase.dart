import 'package:fennac_app/pages/homelanding/data/models/group_invitation_model.dart';
import 'package:fennac_app/pages/homelanding/domain/repository/home_landing_repository.dart';

class FetchGroupInvitationsUseCase {
  final HomeLandingRepository repository;

  FetchGroupInvitationsUseCase(this.repository);

  Future<GroupInvitationModel> call() async {
    return await repository.fetchGroupInvitations();
  }
}
