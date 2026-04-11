import 'dart:async';
import 'dart:developer';
import 'package:equatable/equatable.dart';

import 'package:fennac_app/app/constants/socket_constants.dart';
import 'package:fennac_app/core/di_container.dart';
import 'package:fennac_app/helpers/shared_pref_helper.dart';
import 'package:fennac_app/pages/auth/presentation/bloc/cubit/create_account_cubit.dart';
import 'package:fennac_app/pages/chats/data/models/message_model.dart';
import 'package:fennac_app/pages/chats/data/models/message_type_enum.dart';
import 'package:fennac_app/pages/chats/data/models/reaction_model.dart';
import 'package:fennac_app/pages/my_group/domain/repository/my_group_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

import '../../../../../core/sockets/sockets_service.dart';

part '../state/message_state.dart';

class MessageCubit extends Cubit<MessageState> {
  final MyGroupRepository _myGroupRepository;

  MessageCubit(this._myGroupRepository) : super(MessageInitial());

  final TextEditingController messageController = TextEditingController();
  bool showAttachmentPanel = false;
  bool fieldHaveText = false;
  bool isRecordingAudio = false;
  bool otherUserIsTyping = false;
  Timer? _pollingTimer;

  void _emitLoadingSuccess(void Function() action) {
    emit(MessageLoading());
    action();
    emit(MessageSuccess());
  }

  void toggleAttachmentPanel({bool? close}) {
    _emitLoadingSuccess(() {
      showAttachmentPanel = close == null ? !showAttachmentPanel : !close;
    });
  }

  void toggleRecordingAudio({bool? stop}) {
    _emitLoadingSuccess(() {
      isRecordingAudio = stop == null ? !isRecordingAudio : !stop;
    });
  }

  void updateFieldHaveText(bool haveText) {
    _emitLoadingSuccess(() {
      fieldHaveText = haveText;
      sendTypingStatus(haveText);
    });
  }

  // check is text input is empty
  bool isTextInputEmpty() {
    return messageController.text.trim().isEmpty;
  }

  List<MessageModel> messages = [];
  List<String> getMedias() {
    return messages
        .where(
          (message) =>
              message.type == MessageType.image ||
              message.type == MessageType.video,
        )
        .map((message) => message.imageUrls)
        .expand((list) => list)
        .toList();
  }

  bool isLoading = false;
  bool hasError = false;
  String? errorMessage;
  bool isSendingMessage = false;
  // IDs of messages currently in-flight (added on send, removed on success/error)
  final Set<String> sendingMessageIds = {};
  final _uuid = const Uuid();
  final SharedPreferencesHelper _sharedPreferencesHelper = Di()
      .sl<SharedPreferencesHelper>();

  String currentUserId = '1';
  String currentUserName = 'You';
  String? currentUserAvatar;

  // Pagination
  int _page = 1;
  final int _limit = 20;
  bool _hasMore = true;
  String? _groupId;
  String? _otherGroupId;
  bool _isGroup = true;
  bool isFetchingMore = false;

  Future<List<MessageModel>> _fetchMessages({
    required String chatId,
    required int page,
    required int limit,
  }) {
    return _isGroup
        ? _myGroupRepository.fetchGroupMessages(
            chatId,
            page: page,
            limit: limit,
            receiverGroupId: _otherGroupId,
          )
        : _myGroupRepository.fetchDirectMessages(
            chatId,
            page: page,
            limit: limit,
          );
  }

  Future<void> _sendMessageRequest({
    required String content,
    required String type,
    String? receiverGroupId,
    List<String>? attachments,
    List<double>? wave,
    String? duration,
  }) async {
    final chatId = _groupId;
    if (chatId == null || chatId.isEmpty) {
      throw Exception('Chat id is missing');
    }

    if (_isGroup) {
      final effectiveReceiverGroupId = _resolveEffectiveOtherGroupId(
        receiverGroupId,
      );

      if (_isInvalidGroupReceiverId(effectiveReceiverGroupId)) {
        throw Exception('Invalid receiver group id for group message');
      }

      await _myGroupRepository.sendGroupMessage(
        chatId,
        content: content,
        type: type,
        attachments: attachments,
        wave: wave,
        duration: duration,
        receiverGroupId: effectiveReceiverGroupId,
      );
      return;
    }

    await _myGroupRepository.sendDirectMessage(
      chatId,
      content: content,
      type: type,
      attachments: attachments,
      wave: wave,
      duration: duration,
    );
  }

  String? _resolveEffectiveOtherGroupId(String? otherGroupId) {
    final normalizedParam = otherGroupId?.trim();
    if (normalizedParam != null && normalizedParam.isNotEmpty) {
      return normalizedParam;
    }

    final normalizedStored = _otherGroupId?.trim();
    if (normalizedStored != null && normalizedStored.isNotEmpty) {
      return normalizedStored;
    }

    return null;
  }

  bool _isInvalidGroupReceiverId(String? receiverGroupId) {
    return _isGroup &&
        (receiverGroupId == null ||
            receiverGroupId.isEmpty ||
            receiverGroupId == _groupId);
  }

  Future<void> _reactToMessageRequest({
    required String messageId,
    required String emoji,
    required bool isRemove,
  }) async {
    final chatId = _groupId;
    if (chatId == null || chatId.isEmpty) return;

    if (_isGroup) {
      await _myGroupRepository.reactToGroupMessage(
        chatId,
        messageId,
        emoji,
        isRemove: isRemove,
      );
      return;
    }

    await _myGroupRepository.reactToDirectMessage(
      chatId,
      messageId,
      emoji,
      isRemove: isRemove,
    );
  }

  Future<void> _markMessageAsReadRequest(String messageId) async {
    final chatId = _groupId;
    if (chatId == null || chatId.isEmpty) return;

    if (_isGroup) {
      await _myGroupRepository.markGroupMessageAsRead(chatId, messageId);
      return;
    }

    await _myGroupRepository.markDirectMessageAsRead(chatId, messageId);
  }

  Future<void> _deleteMessageRequest(String messageId) async {
    final chatId = _groupId;
    if (chatId == null || chatId.isEmpty) {
      throw Exception('Chat id is missing');
    }

    if (_isGroup) {
      await _myGroupRepository.deleteGroupMessage(chatId, messageId);
      return;
    }

    await _myGroupRepository.deleteDirectMessage(chatId, messageId);
  }

  /// Initialize messages (can load from local storage or backend)
  Future<void> initializeMessages(
    String id, {
    bool isGroup = true,
    String? otherGroupId,
  }) async {
    _detachSocketListeners();
    _groupId = id;
    _isGroup = isGroup;
    _otherGroupId = isGroup ? otherGroupId : null;
    otherUserIsTyping = false;
    _page = 1;
    _hasMore = true;
    messages.clear();
    isLoading = true;
    emit(MessageLoading());

    try {
      await _hydrateCurrentUser();
      await loadMoreMessages();

      isLoading = false;
      hasError = false;
      emit(MessageSuccess());

      _attachSocketListeners();
    } catch (e) {
      isLoading = false;
      hasError = true;
      errorMessage = e.toString();
      log("error while getting messages ${e.toString()}");
      emit(MessageError(e.toString()));
    }
  }

  void stopPolling() {
    _pollingTimer?.cancel();
    _pollingTimer = null;
  }

  Future<void> loadMoreMessages() async {
    if (!_hasMore || _groupId == null || isFetchingMore) return;

    final loadingGroupId = _groupId;
    isFetchingMore = true;
    try {
      final newMessages = await _fetchMessages(
        chatId: loadingGroupId!,
        page: _page,
        limit: _limit,
      );

      // Verify that the user still has the same chat open
      if (_groupId != loadingGroupId) {
        log(
          "Load more discarded: User switched chat ($loadingGroupId -> $_groupId)",
        );
        isFetchingMore = false;
        return;
      }

      if (newMessages.length < _limit) {
        _hasMore = false;
      } else {
        _page++;
      }

      final normalizedMessages = newMessages
          .map(_normalizeFetchedMessage)
          .toList();
      messages = _mergeAndSortMessages(messages, normalizedMessages);
      isFetchingMore = false;
      emit(MessageSuccess());
    } catch (e) {
      isFetchingMore = false;
      rethrow;
    }
  }

  @override
  Future<void> close() {
    stopPolling();
    _detachSocketListeners();
    return super.close();
  }

  void _attachSocketListeners() {
    SocketService.on(SocketEvents.newGroupMessage, _handleIncomingMessage);
    SocketService.on(SocketEvents.newDirectMessage, _handleIncomingMessage);

    if (_isGroup) {
      SocketService.on(SocketEvents.groupTyping, _handleTypingEvent);
      SocketService.off(SocketEvents.directTyping);
      return;
    }

    SocketService.on(SocketEvents.directTyping, _handleTypingEvent);
    SocketService.off(SocketEvents.groupTyping);
  }

  void _detachSocketListeners() {
    SocketService.off(SocketEvents.newGroupMessage);
    SocketService.off(SocketEvents.newDirectMessage);
    SocketService.off(SocketEvents.groupTyping);
    SocketService.off(SocketEvents.directTyping);
  }

  void _handleTypingEvent(dynamic data) {
    try {
      if (data is! Map) return;

      final payload = Map<String, dynamic>.from(data);
      final typingChatId =
          payload['chatId'] ?? payload['groupId'] ?? payload['directChatId'];
      final senderId = payload['senderId'];
      final isTyping = payload['isTyping'] == true;

      if (typingChatId == null || senderId == null) return;

      final sameChat = typingChatId.toString() == _groupId;
      final isOtherUser = senderId.toString() != currentUserId;

      if (!sameChat || !isOtherUser) return;

      if (otherUserIsTyping != isTyping) {
        otherUserIsTyping = isTyping;
        emit(MessageSuccess());
      }
    } catch (e) {
      log('Error handling typing event: $e');
    }
  }

  void sendTypingStatus(bool isTyping) {
    if (_groupId == null || _groupId!.isEmpty) return;

    final payload = <String, dynamic>{
      'chatId': _groupId,
      'senderId': currentUserId,
      'isTyping': isTyping,
    };

    if (_isGroup) {
      payload['groupId'] = _groupId;
      SocketService.emit(SocketEvents.groupTyping, payload);
      return;
    }

    SocketService.emit(SocketEvents.directTyping, payload);
  }

  /// Handle incoming real-time messages from socket events.
  void _handleIncomingMessage(dynamic data) {
    try {
      if (data == null) return;

      final json = _extractSocketMessageJson(data);
      if (json == null) {
        log('Socket message ignored: invalid payload type');
        return;
      }

      if (!_isSocketMessageForCurrentChat(json)) {
        log('Socket message ignored: not for current chat $_groupId');
        return;
      }

      final message = MessageModel.fromJson(json);

      if (message.id.isEmpty) {
        log('Socket message ignored: empty id');
        return;
      }

      final normalized = _normalizeFetchedMessage(message);

      // Prevent exact duplicate by server id.
      if (messages.any((m) => m.id == normalized.id)) {
        log('Socket message ignored: duplicate id ${normalized.id}');
        return;
      }

      // Replace optimistic message when the confirmed server message
      // arrives for the same content + sender, avoiding a visual duplicate.
      if (normalized.isMe) {
        final optimisticIndex = messages.indexWhere(
          (m) =>
              sendingMessageIds.contains(m.id) &&
              m.senderId == normalized.senderId &&
              m.content.trim() == normalized.content.trim() &&
              m.type == normalized.type,
        );
        if (optimisticIndex != -1) {
          final optimisticId = messages[optimisticIndex].id;
          messages[optimisticIndex] = normalized;
          sendingMessageIds.remove(optimisticId);
          emit(MessageSuccess());
          return;
        }
      }

      messages.insert(0, normalized);
      hasError = false;
      isLoading = false;
      emit(MessageSuccess());
    } catch (e) {
      log('Error handling incoming socket message: $e');
    }
  }

  bool _isSocketMessageForCurrentChat(Map<String, dynamic> json) {
    final activeChatId = _groupId;
    if (activeChatId == null || activeChatId.isEmpty) return false;

    final rawChatId =
        json['chatId'] ??
        json['groupId'] ??
        json['directChatId'] ??
        json['roomId'];
    if (_isGroup) {
      if (rawChatId == null) return false;
      return rawChatId.toString() == activeChatId;
    }

    if (rawChatId != null && rawChatId.toString() == activeChatId) return true;

    final senderMap = json['senderId'] is Map
        ? Map<String, dynamic>.from(json['senderId'])
        : null;
    final receiverMap = json['receiverId'] is Map
        ? Map<String, dynamic>.from(json['receiverId'])
        : null;

    final senderId = senderMap?['_id'] ?? json['senderId'];
    final receiverId = receiverMap?['_id'] ?? json['receiverId'];

    final sender = senderId?.toString();
    final receiver = receiverId?.toString();

    if (sender == null || receiver == null) {
      return false;
    }

    final isBetweenCurrentPair =
        (sender == currentUserId && receiver == activeChatId) ||
        (sender == activeChatId && receiver == currentUserId);

    return isBetweenCurrentPair;
  }

  Map<String, dynamic>? _extractSocketMessageJson(dynamic payload) {
    emit(MessageLoading());
    if (payload is! Map) return null;

    final root = Map<String, dynamic>.from(payload);

    dynamic nested = root['message'] ?? root['data'] ?? root['payload'];
    if (nested is Map) {
      final json = Map<String, dynamic>.from(nested);
      json['chatId'] ??=
          root['chatId'] ?? root['groupId'] ?? root['directChatId'];
      json['_id'] ??= root['_id'] ?? root['id'] ?? root['messageId'];
      json['senderId'] ??= root['senderId'];
      json['receiverId'] ??= root['receiverId'];
      json['groupId'] ??= root['groupId'];
      return json;
    }

    root['_id'] ??= root['id'] ?? root['messageId'];
    emit(MessageSuccess());
    return root;
  }

  Future<void> _hydrateCurrentUser() async {
    final savedUserId = _sharedPreferencesHelper.getUserId();
    if (savedUserId != null && savedUserId.isNotEmpty) {
      currentUserId = savedUserId;
    }

    final loginModel = await _sharedPreferencesHelper.getUserData();
    final user = loginModel?.data?.user;
    if (user == null) return;

    final userId = user.id;
    if (userId != null && userId.isNotEmpty) {
      currentUserId = userId;
    }

    final fullName = '${user.firstName ?? ''} ${user.lastName ?? ''}'.trim();
    if (fullName.isNotEmpty) {
      currentUserName = fullName;
    }

    if (user.userImage != null && user.userImage!.isNotEmpty) {
      currentUserAvatar = user.userImage;
    }
  }

  MessageModel _normalizeFetchedMessage(MessageModel message) {
    final normalizedReactions = _normalizeReactions(message.reactions);
    final resolvedIsMe =
        message.isMe ||
        (currentUserId.isNotEmpty && message.senderId == currentUserId);

    return message.copyWith(isMe: resolvedIsMe, reactions: normalizedReactions);
  }

  List<ReactionModel> _normalizeReactions(List<ReactionModel> reactions) {
    final Map<String, ReactionModel> latestByUser = {};

    for (final reaction in reactions) {
      final existing = latestByUser[reaction.userId];
      if (existing == null || reaction.reactedAt.isAfter(existing.reactedAt)) {
        latestByUser[reaction.userId] = reaction;
      }
    }

    final normalized = latestByUser.values.toList();
    normalized.sort((a, b) => a.reactedAt.compareTo(b.reactedAt));
    return normalized;
  }

  List<MessageModel> _mergeAndSortMessages(
    List<MessageModel> existing,
    List<MessageModel> incoming,
  ) {
    final Map<String, MessageModel> byId = {
      for (final message in existing) message.id: message,
    };

    for (final message in incoming) {
      final current = byId[message.id];
      if (current == null || message.sentAt.isAfter(current.sentAt)) {
        byId[message.id] = message;
      }
    }

    final merged = byId.values.toList();
    merged.sort((a, b) => b.sentAt.compareTo(a.sentAt));
    return merged;
  }

  /// Send a text message
  Future<void> sendTextMessage({
    bool? isGroupMessage,
    String? otherGroupId,
  }) async {
    final content = messageController.text;
    if (content.trim().isEmpty) return;
    emit(MessageLoading());

    final effectiveOtherGroupId = (isGroupMessage ?? false)
        ? _resolveEffectiveOtherGroupId(otherGroupId)
        : null;

    if ((isGroupMessage ?? false) &&
        _isInvalidGroupReceiverId(effectiveOtherGroupId)) {
      emit(MessageError('Invalid receiver group id for group message'));
      return;
    }

    final message = MessageModel(
      id: _uuid.v4(),
      senderId: currentUserId,
      senderName: currentUserName,
      senderAvatar: currentUserAvatar,
      content: content,
      type: MessageType.text,
      sentAt: DateTime.now(),
      isMe: true,
      isSending: true,
      isGroup: isGroupMessage ?? false,
      reciverId: effectiveOtherGroupId,
    );

    log("Sending message ${message.id} with content: ${message.reciverId}");

    _addMessage(message);
    sendingMessageIds.add(message.id);

    messageController.clear();
    sendTypingStatus(false);

    final index = messages.indexWhere((m) => m.id == message.id);
    if (index != -1) {
      try {
        await _sendMessageRequest(
          content: content,
          type: 'text',
          receiverGroupId: effectiveOtherGroupId,
        );
        // Keep optimistic message in sending state until socket confirmation
        // arrives, so it can be replaced instead of duplicated.
        emit(MessageSuccess());
      } catch (e) {
        messages[index] = message.copyWith(isSending: false, hasFailed: true);
        sendingMessageIds.remove(message.id);
        emit(MessageError(e.toString()));
      }

      log('sendTextMessage completed for ${message.id}');
    }
  }

  /// Send a media message (image, video, audio, file)
  Future<void> sendMediaMessage({
    String? otherGroupId,
    required List<String> mediaPath,
    List<double>? waveformData,
    required MessageType type,
    String? caption,
    String? duration,
  }) async {
    emit(MessageLoading());

    final effectiveOtherGroupId = _resolveEffectiveOtherGroupId(otherGroupId);
    if (_isGroup && _isInvalidGroupReceiverId(effectiveOtherGroupId)) {
      emit(MessageError('Invalid receiver group id for group message'));
      return;
    }

    final message = MessageModel(
      id: _uuid.v4(),
      senderId: currentUserId,
      senderName: currentUserName,
      senderAvatar: currentUserAvatar,
      content: caption ?? '',
      type: type,
      mediaUrl: mediaPath.length == 1 ? mediaPath.first : null,
      imageUrls: mediaPath,
      mediaDuration: duration,
      waveformData: waveformData ?? [],
      sentAt: DateTime.now(),
      isMe: true,
      isSending: true,
      isGroup: _isGroup,
      reciverId: _isGroup ? effectiveOtherGroupId : null,
    );

    _addMessage(message);
    sendingMessageIds.add(message.id);

    final index = messages.indexWhere((m) => m.id == message.id);
    if (index != -1) {
      try {
        final List<String> uploadedUrls = [];
        final createAccountCubit = Di().sl<CreateAccountCubit>();

        for (final path in mediaPath) {
          if (path.startsWith('http')) {
            uploadedUrls.add(path);
          } else {
            final url = await createAccountCubit.uploadMedia(filePath: path);
            if (url.isNotEmpty) {
              uploadedUrls.add(url);
            } else {
              throw Exception('Failed to upload media: $path');
            }
          }
        }

        final String effectiveContent = (caption == null || caption.isEmpty)
            ? (type == MessageType.audio ? 'Audio message' : ' ')
            : caption;

        await _sendMessageRequest(
          content: effectiveContent,
          type: type.name,
          receiverGroupId: effectiveOtherGroupId,
          attachments: uploadedUrls,
          wave: type == MessageType.audio ? null : waveformData,
          duration: type == MessageType.audio ? null : duration,
        );
        messages[index] = message.copyWith(
          isSending: false,
          imageUrls: uploadedUrls,
          mediaUrl: uploadedUrls.length == 1 ? uploadedUrls.first : null,
        );
        emit(MessageSuccess());
      } catch (e) {
        messages[index] = message.copyWith(isSending: false, hasFailed: true);
        emit(MessageError(e.toString()));
      } finally {
        emit(MessageSuccess());
        Future.delayed(const Duration(seconds: 1), () {
          messages.removeWhere((m) => m.id == message.id);
          sendingMessageIds.remove(message.id);
        });
        emit(MessageSuccess());
      }
    }
  }

  /// Add a reaction to a message
  Future<void> addReaction(String messageId, String emoji) async {
    emit(MessageLoading());
    final messageIndex = messages.indexWhere((m) => m.id == messageId);
    if (messageIndex == -1) return;

    final message = messages[messageIndex];
    final reactions = List<ReactionModel>.from(message.reactions);

    bool isRemove = false;

    // Check if user already reacted with this emoji
    final existingReactionIndex = reactions.indexWhere(
      (r) => r.userId == currentUserId && r.emoji == emoji,
    );

    if (existingReactionIndex != -1) {
      // Remove reaction if already exists
      reactions.removeAt(existingReactionIndex);
      isRemove = true;
    } else {
      // Remove any other reaction from this user first
      reactions.removeWhere((r) => r.userId == currentUserId);

      // Add new reaction
      reactions.add(
        ReactionModel(
          userId: currentUserId,
          userName: currentUserName,
          emoji: emoji,
          reactedAt: DateTime.now(),
        ),
      );
    }

    messages[messageIndex] = message.copyWith(reactions: reactions);
    emit(MessageSuccess());

    try {
      await _reactToMessageRequest(
        messageId: messageId,
        emoji: emoji,
        isRemove: isRemove,
      );
    } catch (e) {
      emit(MessageError(e.toString()));
    }
  }

  /// Remove a reaction from a message
  Future<void> removeReaction(String messageId, String emoji) async {
    final messageIndex = messages.indexWhere((m) => m.id == messageId);
    if (messageIndex == -1) return;

    final message = messages[messageIndex];
    final reactions = List<ReactionModel>.from(message.reactions);

    reactions.removeWhere((r) => r.userId == currentUserId && r.emoji == emoji);

    messages[messageIndex] = message.copyWith(reactions: reactions);
    emit(MessageSuccess());

    try {
      await _reactToMessageRequest(
        messageId: messageId,
        emoji: emoji,
        isRemove: true,
      );
    } catch (e) {
      emit(MessageError(e.toString()));
    }
  }

  /// Mark message as read
  Future<void> markMessageAsRead(String messageId) async {
    final messageIndex = messages.indexWhere((m) => m.id == messageId);
    if (messageIndex == -1) return;

    final message = messages[messageIndex];
    if (!message.isRead && !message.isMe) {
      messages[messageIndex] = message.copyWith(
        isRead: true,
        readAt: DateTime.now(),
      );
      emit(MessageSuccess());

      try {
        await _markMessageAsReadRequest(messageId);
      } catch (e) {
        messages[messageIndex] = message.copyWith(isRead: false, readAt: null);
        emit(MessageError(e.toString()));
      }
    }
  }

  /// Retry failed message
  Future<void> retryFailedMessage(String messageId) async {
    final messageIndex = messages.indexWhere((m) => m.id == messageId);
    if (messageIndex == -1) return;

    final message = messages[messageIndex];
    messages[messageIndex] = message.copyWith(
      isSending: true,
      hasFailed: false,
    );
    emit(MessageSuccess());

    // Simulate sending
    await Future.delayed(const Duration(milliseconds: 500));

    messages[messageIndex] = message.copyWith(
      isSending: false,
      hasFailed: false,
    );
    emit(MessageSuccess());
  }

  /// Delete a message
  Future<bool> deleteMessage(String messageId) async {
    emit(MessageLoading());
    final messageIndex = messages.indexWhere((m) => m.id == messageId);
    if (messageIndex == -1) return false;
    if (_groupId == null || _groupId!.isEmpty) return false;

    // Optimistically update UI
    final deletedMessage = messages.removeAt(messageIndex);
    emit(MessageSuccess());

    try {
      await _deleteMessageRequest(messageId);
      return true;
    } catch (e) {
      // Revert if API call fails
      messages.insert(messageIndex, deletedMessage);
      emit(MessageError(e.toString()));
      return false;
    }
  }

  /// Receive a message from another user (for testing)
  void receiveMessage({
    required String senderId,
    required String senderName,
    String? senderAvatar,
    required String content,
    required MessageType type,
    String? mediaUrl,
    String? duration,
  }) {
    final message = MessageModel(
      id: _uuid.v4(),
      senderId: senderId,
      senderName: senderName,
      senderAvatar: senderAvatar,
      content: content,
      type: type,
      mediaUrl: mediaUrl,
      mediaDuration: duration,
      sentAt: DateTime.now(),
      isMe: false,
    );

    _addMessage(message);
  }

  /// Private helper to add message and emit state
  void _addMessage(MessageModel message) {
    _emitLoadingSuccess(() {
      messages.insert(0, message);
    });
  }

  /// Get grouped reactions for display
  Map<String, List<String>> getGroupedReactions(String messageId) {
    final index = messages.indexWhere((m) => m.id == messageId);
    if (index == -1) return {};

    final message = messages[index];

    final grouped = <String, List<String>>{};
    for (var reaction in message.reactions) {
      grouped.putIfAbsent(reaction.emoji, () => []);
      grouped[reaction.emoji]!.add(reaction.userId);
    }

    return grouped;
  }

  /// Clear all messages
  void clearMessages() {
    messages.clear();
    emit(MessageSuccess());
  }
}
