import 'package:fennac_app/app/constants/app_constants.dart';
import 'package:fennac_app/core/network/api_helper.dart';
import '../model/my_group_model.dart';

abstract class MyGroupDatasource {
  Future<MyGroupModel> fetchGroupById(String groupId);
  Future<MyGroupModel> updateGroupById(
    String groupId,
    Map<String, dynamic> body,
  );
  Future<dynamic> deleteGroupById(String groupId);
  Future<dynamic> unMatchGroupById(String groupId);
  Future<List<dynamic>> fetchGroupMessages(
    String groupId, {
    String? receiverGroupId,
    int? page,
    int? limit,
    String? beforeMessageId,
  });

  Future<List<dynamic>> fetchDirectMessages(
    String userId, {
    int? page,
    int? limit,
    String? beforeMessageId,
  });

  Future<dynamic> sendGroupMessage(
    String groupId, {
    required String content,
    required String type,
    String? receiverGroupId,
    List<String>? attachments,
    String? replyTo,
  });

  Future<dynamic> sendDirectMessage(
    String userId, {
    required String content,
    required String type,
    List<String>? attachments,
    String? replyTo,
  });

  Future<dynamic> reactToGroupMessage(
    String groupId,
    String messageId,
    String emoji, {
    bool isRemove = false,
  });

  Future<dynamic> reactToDirectMessage(
    String userId,
    String messageId,
    String emoji, {
    bool isRemove = false,
  });

  Future<dynamic> deleteGroupMessage(String groupId, String messageId);

  Future<dynamic> deleteDirectMessage(String userId, String messageId);

  Future<dynamic> markGroupMessageAsRead(String groupId, String messageId);

  Future<dynamic> markDirectMessageAsRead(String userId, String messageId);
}

class MyGroupDatasourceImpl extends MyGroupDatasource {
  final ApiHelper apiHelper;

  MyGroupDatasourceImpl(this.apiHelper);

  @override
  Future<MyGroupModel> fetchGroupById(String groupId) async {
    try {
      final response = await apiHelper.get(
        '${AppConstants.groupById}$groupId',
        requiresAuth: true,
      );

      if (groupId.isNotEmpty) {
        final prompts = await apiHelper.get(
          '${AppConstants.userPrompts}?groupId=$groupId',
          requiresAuth: true,
        );
        response['data']["groupPrompts"] = prompts["data"];
      }
      return MyGroupModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<MyGroupModel> updateGroupById(
    String groupId,
    Map<String, dynamic> body,
  ) async {
    try {
      final response = await apiHelper.put(
        '${AppConstants.groupById}$groupId',
        body: body,
        requiresAuth: true,
      );
      return MyGroupModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<dynamic> deleteGroupById(String groupId) async {
    try {
      final response = await apiHelper.delete(
        '${AppConstants.groupById}$groupId',
        requiresAuth: true,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<dynamic> unMatchGroupById(String groupId) async {
    try {
      final response = await apiHelper.post(
        '${AppConstants.groupById}$groupId/unmatch',
        requiresAuth: true,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<dynamic>> fetchGroupMessages(
    String groupId, {
    String? receiverGroupId,
    int? page,
    int? limit,
    String? beforeMessageId,
  }) async {
    try {
      final queryParameters = <String, dynamic>{
        if (receiverGroupId != null) 'receiverGroupId': receiverGroupId,
        if (page != null) 'page': page,
        if (limit != null) 'limit': limit,
        if (beforeMessageId != null) 'beforeMessageId': beforeMessageId,
      };

      final response = await apiHelper.get(
        '${AppConstants.groupById}$groupId/chat/messages',
        queryParameters: queryParameters,
        requiresAuth: true,
      );
      return response as List<dynamic>;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<dynamic>> fetchDirectMessages(
    String userId, {
    int? page,
    int? limit,
    String? beforeMessageId,
  }) async {
    try {
      final queryParameters = <String, dynamic>{
        if (page != null) 'page': page,
        if (limit != null) 'limit': limit,
        if (beforeMessageId != null) 'beforeMessageId': beforeMessageId,
      };

      final response = await apiHelper.get(
        '${AppConstants.directChat}$userId/chat/messages',
        queryParameters: queryParameters,
        requiresAuth: true,
      );
      return response as List<dynamic>;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<dynamic> sendGroupMessage(
    String groupId, {
    required String content,
    required String type,
    String? receiverGroupId,
    List<String>? attachments,
    String? replyTo,
  }) async {
    try {
      final body = {
        'content': content,
        'type': type,
        if (receiverGroupId != null) 'receiverGroupId': receiverGroupId,
        if (attachments != null) 'attachments': attachments,
        if (replyTo != null) 'replyTo': replyTo,
      };

      final response = await apiHelper.post(
        '${AppConstants.groupById}$groupId/chat/messages',
        body: body,
        requiresAuth: true,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<dynamic> sendDirectMessage(
    String userId, {
    required String content,
    required String type,
    List<String>? attachments,
    String? replyTo,
  }) async {
    try {
      final body = {
        'content': content,
        'type': type,
        if (attachments != null) 'attachments': attachments,
        if (replyTo != null) 'replyTo': replyTo,
      };

      final response = await apiHelper.post(
        '${AppConstants.directChat}$userId/chat/messages',
        body: body,
        requiresAuth: true,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<dynamic> reactToGroupMessage(
    String groupId,
    String messageId,
    String emoji, {
    bool isRemove = false,
  }) async {
    try {
      final String url =
          '${AppConstants.groupById}$groupId/chat/messages/$messageId/reactions';
      final response = isRemove
          ? await apiHelper.delete(
              url,
              body: {'emoji': emoji},
              requiresAuth: true,
            )
          : await apiHelper.post(
              url,
              body: {'emoji': emoji},
              requiresAuth: true,
            );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<dynamic> reactToDirectMessage(
    String userId,
    String messageId,
    String emoji, {
    bool isRemove = false,
  }) async {
    try {
      final String url =
          '${AppConstants.directChat}$userId/chat/messages/$messageId/reactions';
      final response = isRemove
          ? await apiHelper.delete(
              url,
              body: {'emoji': emoji},
              requiresAuth: true,
            )
          : await apiHelper.post(
              url,
              body: {'emoji': emoji},
              requiresAuth: true,
            );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<dynamic> deleteGroupMessage(String groupId, String messageId) async {
    try {
      final response = await apiHelper.delete(
        '${AppConstants.groupById}$groupId/chat/messages/$messageId',
        requiresAuth: true,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<dynamic> deleteDirectMessage(String userId, String messageId) async {
    try {
      final response = await apiHelper.delete(
        '${AppConstants.directChat}$userId/chat/messages/$messageId',
        requiresAuth: true,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<dynamic> markGroupMessageAsRead(
    String groupId,
    String messageId,
  ) async {
    try {
      final response = await apiHelper.post(
        '${AppConstants.groupById}$groupId/chat/messages/$messageId/read',
        requiresAuth: true,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<dynamic> markDirectMessageAsRead(
    String userId,
    String messageId,
  ) async {
    try {
      final response = await apiHelper.post(
        '${AppConstants.directChat}$userId/chat/messages/$messageId/read',
        requiresAuth: true,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
