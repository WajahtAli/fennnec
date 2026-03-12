import '../../data/models/groups_model.dart';
import '../repository/groups_repository.dart';

class GroupsUsecase {
  final GroupsRepository _groupsRepository;
  GroupsUsecase(this._groupsRepository);

  Future<GroupsModel> fetchAllGroups({
    required int page,
    required int limit,
    Map<String, dynamic>? queryParameters,
  }) {
    return _groupsRepository.fetchAllGroups(
      page: page,
      limit: limit,
      queryParameters: queryParameters,
    );
  }

  Future<Map<String, dynamic>> likeDislikeGroup({
    required String groupId,
    required String type,
  }) {
    return _groupsRepository.likeDislikeGroup(groupId: groupId, type: type);
  }

  Future<Map<String, dynamic>> reportGroup({
    required String groupId,
    required String reason,
    String? customReason,
  }) {
    return _groupsRepository.reportGroup(
      groupId: groupId,
      reason: reason,
      customReason: customReason,
    );
  }

  Future<Map<String, dynamic>> reportUser({
    required String userId,
    required String reason,
    String? customReason,
  }) {
    return _groupsRepository.reportUser(
      userId: userId,
      reason: reason,
      customReason: customReason,
    );
  }

  Future<Map<String, dynamic>> acceptGroupReq({
    required String groupId,
    required String type,
  }) {
    return _groupsRepository.acceptGroupReq(groupId: groupId, type: type);
  }
}
