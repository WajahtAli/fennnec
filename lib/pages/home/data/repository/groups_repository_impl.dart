import '../../domain/repository/groups_repository.dart';
import '../datasource/groups_datasource.dart';
import '../models/groups_model.dart';

class GroupsRepositoryImpl extends GroupsRepository {
  final GroupsDataSource _groupsDataSource;
  GroupsRepositoryImpl(this._groupsDataSource);

  @override
  Future<GroupsModel> fetchAllGroups({
    required int page,
    required int limit,
    Map<String, dynamic>? queryParameters,
  }) async {
    return await _groupsDataSource.fetchAllGroups(
      page: page,
      limit: limit,
      queryParameters: queryParameters,
    );
  }

  @override
  Future<Map<String, dynamic>> likeDislikeGroup({
    required String groupId,
    required String type,
  }) async {
    return await _groupsDataSource.likeDislikeGroup(
      groupId: groupId,
      type: type,
    );
  }

  @override
  Future<Map<String, dynamic>> reportGroup({
    required String groupId,
    required String reason,
    String? customReason,
  }) async {
    return await _groupsDataSource.reportGroup(
      groupId: groupId,
      reason: reason,
      customReason: customReason,
    );
  }

  @override
  Future<Map<String, dynamic>> acceptGroupReq({
    required String groupId,
    required String type,
  }) async {
    return await _groupsDataSource.acceptGroupReq(groupId: groupId, type: type);
  }
}
