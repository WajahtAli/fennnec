import 'package:fennac_app/core/network/api_helper.dart';
import 'package:fennac_app/app/constants/app_constants.dart';
import '../models/groups_model.dart';

abstract class GroupsDataSource {
  Future<GroupsModel> fetchAllGroups({
    required int page,
    required int limit,
    Map<String, dynamic>? queryParameters,
  });

  Future<Map<String, dynamic>> likeDislikeGroup({
    required String groupId,
    required String type,
  });

  Future<Map<String, dynamic>> reportGroup({
    required String groupId,
    required String reason,
    String? customReason,
  });

  Future<Map<String, dynamic>> acceptGroupReq({
    required String groupId,
    required String type,
  });
}

class GroupsDataSourceImpl extends GroupsDataSource {
  ApiHelper apiHelper;
  GroupsDataSourceImpl(this.apiHelper);

  @override
  Future<GroupsModel> fetchAllGroups({
    required int page,
    required int limit,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final params = {'page': page, 'limit': limit, ...?queryParameters};
      final response = await apiHelper.get(
        AppConstants.groupsAll,
        queryParameters: params,
      );
      return GroupsModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Map<String, dynamic>> likeDislikeGroup({
    required String groupId,
    required String type,
  }) async {
    try {
      final response = await apiHelper.post(
        'groups/like-dislike',
        body: {'groupId': groupId, 'type': type},
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Map<String, dynamic>> reportGroup({
    required String groupId,
    required String reason,
    String? customReason,
  }) async {
    try {
      final body = <String, dynamic>{'reason': reason};
      if (customReason != null && customReason.trim().isNotEmpty) {
        body['customReason'] = customReason.trim();
      }
      final response = await apiHelper.post(
        'groups/$groupId/report',
        body: body,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Map<String, dynamic>> acceptGroupReq({
    required String groupId,
    required String type,
  }) async {
    try {
      final response = await apiHelper.post(
        AppConstants.acceptGroupRequest,
        body: {'groupId': groupId, 'type': type},
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
