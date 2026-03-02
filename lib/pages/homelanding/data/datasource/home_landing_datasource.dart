import 'package:fennac_app/app/constants/app_constants.dart';
import 'package:fennac_app/core/network/api_helper.dart';
import 'package:fennac_app/pages/homelanding/data/models/group_invitation_model.dart';

abstract class HomeLandingDatasource {
  Future<GroupInvitationModel> fetchGroupInvitations();
}

class HomeLandingDatasourceImpl implements HomeLandingDatasource {
  final ApiHelper apiHelper;

  HomeLandingDatasourceImpl(this.apiHelper);

  @override
  Future<GroupInvitationModel> fetchGroupInvitations() async {
    final response = await apiHelper.get(AppConstants.fetchGroupInvitations);
    return GroupInvitationModel.fromJson(response);
  }
}
