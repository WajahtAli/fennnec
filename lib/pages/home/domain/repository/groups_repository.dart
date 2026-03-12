import 'package:fennac_app/pages/home/data/models/groups_model.dart';

abstract class GroupsRepository {
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

  Future<Map<String, dynamic>> reportUser({
    required String userId,
    required String reason,
    String? customReason,
  });

  Future<Map<String, dynamic>> acceptGroupReq({
    required String groupId,
    required String type,
  });
}
