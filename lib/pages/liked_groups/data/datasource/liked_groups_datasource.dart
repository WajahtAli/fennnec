import 'package:fennac_app/pages/home/data/models/groups_model.dart';
import 'package:fennac_app/core/network/api_helper.dart';
import 'package:fennac_app/app/constants/app_constants.dart';

abstract class LikedGroupsDataSource {
  Future<GroupsModel> peopleWhoLikedMe();
}

class LikedGroupsDataSourceImpl extends LikedGroupsDataSource {
  final ApiHelper apiHelper;
  LikedGroupsDataSourceImpl(this.apiHelper);

  @override
  Future<GroupsModel> peopleWhoLikedMe() async {
    final response = await apiHelper.get(
      AppConstants.peopleWhoLikedYou,
      requiresAuth: true,
    );
    return GroupsModel.fromJson(response);
  }
}
