import '../../domain/repository/my_group_repository.dart';
import '../datasource/my_group_datasource.dart';
import 'package:fennac_app/pages/chats/data/models/message_model.dart';
import '../model/my_group_model.dart';

class MyGroupRepositoryImpl extends MyGroupRepository {
  @override
  Future<dynamic> unMatchGroup(String groupId) async {
    return await _datasource.unMatchGroup(groupId);
  }

  @override
  Future<dynamic> setActiveGroup(String groupId) async {
    return await _datasource.setActiveGroup(groupId);
  }

  final MyGroupDatasource _datasource;

  MyGroupRepositoryImpl(this._datasource);

  @override
  Future<MyGroupModel> fetchGroupById(String groupId) async {
    return await _datasource.fetchGroupById(groupId);
  }

  @override
  Future<MyGroupModel> updateGroupById(
    String groupId,
    Map<String, dynamic> body,
  ) async {
    return await _datasource.updateGroupById(groupId, body);
  }

  @override
  Future<dynamic> deleteGroupById(String groupId) async {
    return await _datasource.deleteGroupById(groupId);
  }

  @override
  Future<dynamic> unMatchGroupById(String groupId) async {
    return await _datasource.unMatchGroupById(groupId);
  }

  @override
  Future<List<MessageModel>> fetchGroupMessages(
    String groupId, {
    String? receiverGroupId,
    int? page,
    int? limit,
    String? beforeMessageId,
  }) async {
    final response = await _datasource.fetchGroupMessages(
      groupId,
      receiverGroupId: receiverGroupId,
      page: page,
      limit: limit,
      beforeMessageId: beforeMessageId,
    );
    return response.map((e) => MessageModel.fromJson(e)).toList();
  }

  @override
  Future<List<MessageModel>> fetchDirectMessages(
    String userId, {
    int? page,
    int? limit,
    String? beforeMessageId,
  }) async {
    final response = await _datasource.fetchDirectMessages(
      userId,
      page: page,
      limit: limit,
      beforeMessageId: beforeMessageId,
    );
    return response.map((e) => MessageModel.fromJson(e)).toList();
  }

  @override
  Future<void> sendGroupMessage(
    String groupId, {
    required String content,
    required String type,
    String? receiverGroupId,
    List<String>? attachments,
    String? replyTo,
  }) async {
    await _datasource.sendGroupMessage(
      groupId,
      content: content,
      type: type,
      receiverGroupId: receiverGroupId,
      attachments: attachments,
      replyTo: replyTo,
    );
  }

  @override
  Future<void> sendDirectMessage(
    String userId, {
    required String content,
    required String type,
    List<String>? attachments,
    String? replyTo,
  }) async {
    await _datasource.sendDirectMessage(
      userId,
      content: content,
      type: type,
      replyTo: replyTo,
    );
  }

  @override
  Future<void> reactToGroupMessage(
    String groupId,
    String messageId,
    String emoji, {
    bool isRemove = false,
  }) async {
    await _datasource.reactToGroupMessage(
      groupId,
      messageId,
      emoji,
      isRemove: isRemove,
    );
  }

  @override
  Future<void> reactToDirectMessage(
    String userId,
    String messageId,
    String emoji, {
    bool isRemove = false,
  }) async {
    await _datasource.reactToDirectMessage(
      userId,
      messageId,
      emoji,
      isRemove: isRemove,
    );
  }

  @override
  Future<void> deleteGroupMessage(String groupId, String messageId) async {
    await _datasource.deleteGroupMessage(groupId, messageId);
  }

  @override
  Future<void> deleteDirectMessage(String userId, String messageId) async {
    await _datasource.deleteDirectMessage(userId, messageId);
  }

  @override
  Future<void> markGroupMessageAsRead(String groupId, String messageId) async {
    await _datasource.markGroupMessageAsRead(groupId, messageId);
  }

  @override
  Future<void> markDirectMessageAsRead(String userId, String messageId) async {
    await _datasource.markDirectMessageAsRead(userId, messageId);
  }
}
