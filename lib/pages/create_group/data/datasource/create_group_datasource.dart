import 'package:fennac_app/app/constants/app_constants.dart';

import '../../../../core/network/api_helper.dart';
import '../model/create_group_model.dart';
import '../model/get_members_model.dart';

abstract class CreateGroupDatasource {
  Future<CreateGroupResponseModel> createGroup({
    required String title,
    required List<dynamic> members,
    required String bio,
    required String fitsForGroup,
    required Map<String, dynamic> groupSettings,
    required List<String> photosVideos,
  });

  Future<GetMembersModel> getAllMembers({required List<String> contacts});

  Future<dynamic> sendGroupInvite({
    String? email,
    String? phone,
    String? groupId,
  });
}

class CreateGroupDatasourceImpl extends CreateGroupDatasource {
  final ApiHelper apiHelper;
  CreateGroupDatasourceImpl(this.apiHelper);

  @override
  Future<CreateGroupResponseModel> createGroup({
    required String title,
    required List<dynamic> members,
    required String bio,
    required String fitsForGroup,
    required Map<String, dynamic> groupSettings,
    required List<String> photosVideos,
  }) async {
    final data = await apiHelper.post(
      'groups',
      requiresAuth: true,
      body: {
        "title": title,
        "members": members,
        "bio": bio,
        "fitsForGroup": fitsForGroup,
        "groupSettings": groupSettings,
        "photosVideos": photosVideos,
      },
    );
    return CreateGroupResponseModel.fromJson(data);
  }

  @override
  Future<GetMembersModel> getAllMembers({
    required List<String> contacts,
  }) async {
    final data = await apiHelper.post(
      AppConstants.groupsMembers,
      requiresAuth: true,
      body: {"contacts": contacts},
    );
    return GetMembersModel.fromJson(data);
  }

  @override
  Future<dynamic> sendGroupInvite({
    String? email,
    String? phone,
    String? groupId,
  }) async {
    final body = <String, dynamic>{};
    if (email != null && email.trim().isNotEmpty) {
      body['email'] = email.trim();
    }
    if (phone != null && phone.trim().isNotEmpty) {
      body['phone'] = phone.trim();
    }
    if (groupId != null && groupId.trim().isNotEmpty) {
      body['groupId'] = groupId.trim();
    }
    final data = await apiHelper.post(
      AppConstants.groupInvite,
      requiresAuth: true,
      body: body,
    );
    return data;
  }
}
