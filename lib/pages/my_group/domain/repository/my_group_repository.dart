import 'package:fennac_app/pages/chats/data/models/message_model.dart';
import 'package:fennac_app/pages/my_group/data/model/my_group_model.dart';

abstract class MyGroupRepository {
  Future<dynamic> unMatchGroup(String groupId);
  Future<dynamic> setActiveGroup(String groupId);
  Future<MyGroupModel> fetchGroupById(String groupId);
  Future<MyGroupModel> updateGroupById(
    String groupId,
    Map<String, dynamic> body,
  );
  Future<dynamic> deleteGroupById(String groupId);
  Future<dynamic> unMatchGroupById(String groupId);
  Future<List<MessageModel>> fetchGroupMessages(
    String groupId, {
    String? receiverGroupId,
    int? page,
    int? limit,
    String? beforeMessageId,
  });

  Future<List<MessageModel>> fetchDirectMessages(
    String userId, {
    int? page,
    int? limit,
    String? beforeMessageId,
  });

  Future<void> sendGroupMessage(
    String groupId, {
    required String content,
    required String type,
    String? receiverGroupId,
    List<String>? attachments,
    List<double>? wave,
    String? duration,
    String? replyTo,
  });

  Future<void> sendDirectMessage(
    String userId, {
    required String content,
    required String type,
    List<String>? attachments,
    List<double>? wave,
    String? duration,
    String? replyTo,
  });

  Future<void> reactToGroupMessage(
    String groupId,
    String messageId,
    String emoji, {
    bool isRemove = false,
  });

  Future<void> reactToDirectMessage(
    String userId,
    String messageId,
    String emoji, {
    bool isRemove = false,
  });

  Future<void> deleteGroupMessage(String groupId, String messageId);

  Future<void> deleteDirectMessage(String userId, String messageId);

  Future<void> markGroupMessageAsRead(String groupId, String messageId);

  Future<void> markDirectMessageAsRead(String userId, String messageId);
}
