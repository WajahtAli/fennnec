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
    emit(MessageLoading(messages: messages, isOtherUserTyping: otherUserIsTyping));
    action();
    emit(MessageSuccess(messages: messages, isOtherUserTyping: otherUserIsTyping));
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

  Future<List<String>> checkBlockedWords(String text) async {
    final normalizedText = text.trim();
    if (normalizedText.isEmpty) {
      return [];
    }

    return await _myGroupRepository.checkBlockedWords(normalizedText);
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
    log(
      'before mark as read: chatId=$chatId, messageId=$messageId, isGroup=$_isGroup, otherGroupId=$_otherGroupId',
    );
    if (chatId == null || chatId.isEmpty) return;

    if (_isGroup) {
      log(
        "Marking group message as read: chatId=$chatId, messageId=$messageId, otherGroupId=$_otherGroupId",
      );
      final receiverGroupId = _resolveEffectiveOtherGroupId(_otherGroupId);
      await _myGroupRepository.markGroupMessageAsRead(
        receiverGroupId ?? '',
        messageId,
      );
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
    log(
      "📨 Initialized messages: _groupId=$_groupId, _isGroup=$_isGroup, _otherGroupId=$_otherGroupId",
    );
    _page = 1;
    _hasMore = true;
    messages = const [];
    isLoading = true;
    emit(MessageLoading(messages: messages, isOtherUserTyping: otherUserIsTyping));

    try {
      await _hydrateCurrentUser();
      await loadMoreMessages();

      isLoading = false;
      hasError = false;
      emit(MessageSuccess(messages: messages, isOtherUserTyping: otherUserIsTyping));

      _attachSocketListeners();
    } catch (e) {
      isLoading = false;
      hasError = true;
      errorMessage = e.toString();
      log("error while getting messages ${e.toString()}");
      emit(MessageError(e.toString(), messages: messages, isOtherUserTyping: otherUserIsTyping));
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
      messages = List.unmodifiable(_mergeAndSortMessages(messages, normalizedMessages));
      isFetchingMore = false;
      emit(MessageSuccess(messages: messages, isOtherUserTyping: otherUserIsTyping));
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
    log("🔌 Attaching socket listeners (isGroup=$_isGroup)");
    SocketService.on(SocketEvents.newGroupMessage, _handleIncomingMessage);
    SocketService.on(SocketEvents.newDirectMessage, _handleIncomingMessage);
    SocketService.on(SocketEvents.messagesReaction, _handleReactionEvent);
    SocketService.on(SocketEvents.groupMessagesReaction, _handleReactionEvent);

    if (_isGroup) {
      log("🔌 Attaching group:typing listener");
      SocketService.on(SocketEvents.groupTyping, _handleTypingEvent);
      SocketService.off(SocketEvents.directTyping);
      return;
    }

    log("🔌 Attaching direct:typing listener");
    SocketService.on(SocketEvents.directTyping, _handleTypingEvent);
    SocketService.off(SocketEvents.groupTyping);
  }

  void _detachSocketListeners() {
    log("🔌 Detaching socket listeners");
    SocketService.off(SocketEvents.newGroupMessage);
    SocketService.off(SocketEvents.newDirectMessage);
    SocketService.off(SocketEvents.messagesReaction);
    SocketService.off(SocketEvents.groupMessagesReaction);
    SocketService.off(SocketEvents.groupTyping);
    SocketService.off(SocketEvents.directTyping);
  }

  void _handleReactionEvent(dynamic data) {
    try {
      if (data is! Map) return;
      emit(MessageLoading(messages: messages, isOtherUserTyping: otherUserIsTyping));

      final payload = Map<String, dynamic>.from(data);

      Map<String, dynamic>? messageJson;
      final nested =
          payload['message'] ?? payload['data'] ?? payload['payload'];
      if (nested is Map) {
        messageJson = Map<String, dynamic>.from(nested);
      }

      if (!_isReactionEventForCurrentChat(payload, messageJson: messageJson)) {
        return;
      }

      if (messageJson != null) {
        final message = _normalizeFetchedMessage(
          MessageModel.fromJson(messageJson),
        );
        final index = messages.indexWhere((m) => m.id == message.id);
        if (index == -1) {
          return;
        }

        final updatedList = List<MessageModel>.from(messages);
        updatedList[index] = message;
        messages = List.unmodifiable(updatedList);
        emit(MessageSuccess(messages: messages, isOtherUserTyping: otherUserIsTyping));
        return;
      }

      final messageId =
          payload['messageId']?.toString() ??
          payload['_id']?.toString() ??
          payload['id']?.toString();
      final emoji = payload['emoji']?.toString();
      final action = payload['action']?.toString().toLowerCase();
      final reactedByUserId =
          payload['reactedByUserId']?.toString() ??
          payload['userId']?.toString() ??
          payload['senderId']?.toString();

      if (messageId == null || messageId.isEmpty) return;
      if (emoji == null || emoji.isEmpty) return;
      if (reactedByUserId == null || reactedByUserId.isEmpty) return;

      final index = messages.indexWhere((m) => m.id == messageId);
      if (index == -1) return;

      final message = messages[index];
      final updated = List<ReactionModel>.from(message.reactions);

      if (action == 'removed') {
        updated.removeWhere(
          (reaction) =>
              reaction.userId == reactedByUserId && reaction.emoji == emoji,
        );
      } else {
        updated.removeWhere((reaction) => reaction.userId == reactedByUserId);
        updated.add(
          ReactionModel(
            userId: reactedByUserId,
            userName:
                payload['senderName']?.toString() ??
                payload['userName']?.toString() ??
                '',
            emoji: emoji,
            reactedAt:
                DateTime.tryParse(payload['at']?.toString() ?? '') ??
                DateTime.now(),
          ),
        );
      }

      final updatedList = List<MessageModel>.from(messages);
      updatedList[index] = message.copyWith(
        reactions: _normalizeReactions(updated),
      );
      messages = List.unmodifiable(updatedList);
      emit(MessageSuccess(messages: messages, isOtherUserTyping: otherUserIsTyping));
    } catch (e) {
      log('Error handling reaction event: $e');
    }
  }

  bool _isReactionEventForCurrentChat(
    Map<String, dynamic> payload, {
    Map<String, dynamic>? messageJson,
  }) {
    final activeChatId = _groupId;
    if (activeChatId == null || activeChatId.isEmpty) return false;

    if (messageJson != null) {
      if (_isSocketMessageForCurrentChat(messageJson)) {
        return true;
      }
    }

    if (_isGroup) {
      final groupId = payload['groupId']?.toString();
      final receiverGroupId = payload['receiverGroupId']?.toString();
      return groupId == activeChatId || receiverGroupId == activeChatId;
    }

    final senderId =
        payload['reactedByUserId']?.toString() ??
        payload['userId']?.toString() ??
        payload['senderId']?.toString();

    return senderId == activeChatId;
  }

  void _handleTypingEvent(dynamic data) {
    try {
      log("🔔 Received typing event: $data");
      final payload = Map<String, dynamic>.from(data);
      final typingGroupId = payload['groupId'];
      final typingReceiverGroupId = payload['receiverGroupId'];
      final typingChatId = payload['chatId'] ?? payload['directChatId'];
      final senderId = payload['userId'] ?? payload['senderId'];
      final isTyping = payload['isTyping'] == true;

      log(
        "🔔 Typing payload: groupId=$typingGroupId, receiverGroupId=$typingReceiverGroupId, chatId=$typingChatId, senderId=$senderId, isTyping=$isTyping, activeChatId=$_groupId, isGroup=$_isGroup",
      );

      if (senderId == null) {
        log("❌ Typing: senderId is null");
        return;
      }

      final activeChatId = _groupId;
      if (activeChatId == null || activeChatId.isEmpty) {
        log("❌ Typing: no active chat id");
        return;
      }

      final bool sameChat;
      if (_isGroup) {
        // For group chats, match by groupId or receiverGroupId
        sameChat =
            typingGroupId?.toString() == activeChatId ||
            typingReceiverGroupId?.toString() == activeChatId;
        log(
          "🔔 Typing: isGroup=true, sameChat=$sameChat (groupId match: ${typingGroupId?.toString() == activeChatId}, receiverGroupId match: ${typingReceiverGroupId?.toString() == activeChatId})",
        );
      } else {
        // For direct chats, the senderId (userId from backend) IS the chat identifier
        // OR match by explicit chatId field if present
        sameChat =
            senderId.toString() == activeChatId ||
            typingChatId?.toString() == activeChatId;
        log(
          "🔔 Typing: isGroup=false, sameChat=$sameChat (senderId match: ${senderId.toString() == activeChatId}, chatId match: ${typingChatId?.toString() == activeChatId})",
        );
      }

      final isOtherUser = senderId.toString() != currentUserId;
      log(
        "🔔 Typing: isOtherUser=$isOtherUser (senderId=$senderId, currentUserId=$currentUserId)",
      );

      if (!sameChat || !isOtherUser) {
        log(
          "❌ Typing: rejected (sameChat=$sameChat, isOtherUser=$isOtherUser)",
        );
        return;
      }

      if (otherUserIsTyping != isTyping) {
        log(
          "✅ Typing: updating otherUserIsTyping from $otherUserIsTyping to $isTyping",
        );
        otherUserIsTyping = isTyping;
      } else {
        log("⏭️ Typing: no change needed (already $isTyping)");
      }
      // Always emit to trigger UI rebuild on any valid typing event
      emit(MessageSuccess(messages: messages, isOtherUserTyping: otherUserIsTyping));
    } catch (e) {
      log('❌ Error handling typing event: $e');
    }
  }

  void sendTypingStatus(bool isTyping) {
    log(
      "📤 Emitting typing status: isTyping=$isTyping for groupId=$_groupId, isGroup=$_isGroup",
    );
    final activeChatId = _groupId;
    if (activeChatId == null || activeChatId.isEmpty) {
      log("❌ Send typing: no active chat id");
      return;
    }

    if (_isGroup) {
      final payload = <String, dynamic>{
        'groupId': activeChatId,
        'isTyping': isTyping,
      };

      final receiverGroupId = _resolveEffectiveOtherGroupId(_otherGroupId);
      if (receiverGroupId != null && receiverGroupId.isNotEmpty) {
        payload['receiverGroupId'] = receiverGroupId;
      }

      log("📤 Emitting group:typing: $payload");
      SocketService.emit(SocketEvents.groupTyping, payload);
      return;
    }

    final payload = <String, dynamic>{
      'receiverId': activeChatId,
      'isTyping': isTyping,
    };

    log("📤 Emitting direct:typing: $payload");
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
              m.type == normalized.type &&
              (m.content.trim() == normalized.content.trim() ||
                  (m.mediaUrl != null && m.mediaUrl == normalized.mediaUrl) ||
                  (m.imageUrls.isNotEmpty &&
                      normalized.imageUrls.isNotEmpty &&
                      m.imageUrls.first == normalized.imageUrls.first)),
        );
        if (optimisticIndex != -1) {
          final optimisticId = messages[optimisticIndex].id;
          final updatedList = List<MessageModel>.from(messages);
          updatedList[optimisticIndex] = normalized;
          messages = List.unmodifiable(updatedList);
          sendingMessageIds.remove(optimisticId);
          log('✅ Deduplicated message: replaced optimistic $optimisticId with server ${normalized.id}');
          emit(MessageSuccess(messages: messages, isOtherUserTyping: otherUserIsTyping));
          return;
        }
      }

      messages = List.unmodifiable([normalized, ...messages]);
      hasError = false;
      isLoading = false;
      emit(MessageSuccess(messages: messages, isOtherUserTyping: otherUserIsTyping));
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
      if (rawChatId == null && json['receiverGroupId'] == null) return false;
      return rawChatId.toString() == activeChatId ||
          (json['receiverGroupId']?.toString() == activeChatId);
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
    emit(MessageLoading(messages: messages, isOtherUserTyping: otherUserIsTyping));
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
    emit(MessageSuccess(messages: messages, isOtherUserTyping: otherUserIsTyping));
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
  Future<List<String>> sendTextMessage({
    bool? isGroupMessage,
    String? otherGroupId,
  }) async {
    final content = messageController.text;
    if (content.trim().isEmpty) return [];

    final blockedWords = await checkBlockedWords(content);
    if (blockedWords.isNotEmpty) {
      emit(MessageSuccess(messages: messages, isOtherUserTyping: otherUserIsTyping));
      return blockedWords;
    }

    emit(MessageLoading(messages: messages, isOtherUserTyping: otherUserIsTyping));

    final effectiveOtherGroupId = (isGroupMessage ?? false)
        ? _resolveEffectiveOtherGroupId(otherGroupId)
        : null;

    if ((isGroupMessage ?? false) &&
        _isInvalidGroupReceiverId(effectiveOtherGroupId)) {
      emit(MessageError('Invalid receiver group id for group message'));
      return [];
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
    _startOptimisticCleanup(message.id);

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
        emit(MessageSuccess(messages: messages, isOtherUserTyping: otherUserIsTyping));
      } catch (e) {
        final updatedList = List<MessageModel>.from(messages);
        updatedList[index] = message.copyWith(isSending: false, hasFailed: true);
        messages = List.unmodifiable(updatedList);
        sendingMessageIds.remove(message.id);
        emit(MessageError(e.toString(), messages: messages, isOtherUserTyping: otherUserIsTyping));
      }

      log('sendTextMessage completed for ${message.id}');
    }

    return [];
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
    emit(MessageLoading(messages: messages, isOtherUserTyping: otherUserIsTyping));

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
    _startOptimisticCleanup(message.id);

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
            ? _defaultMediaPreview(type)
            : caption;

        // PRE-EMPTIVE UPDATE: Update local list with web URLs BEFORE request
        // This prevents a race condition where the socket confirmation arrives
        // before the local list is updated.
        final syncList = List<MessageModel>.from(messages);
        final syncIndex = syncList.indexWhere((m) => m.id == message.id);
        if (syncIndex != -1) {
          syncList[syncIndex] = message.copyWith(
            imageUrls: uploadedUrls,
            mediaUrl: uploadedUrls.length == 1 ? uploadedUrls.first : null,
          );
          messages = List.unmodifiable(syncList);
          emit(MessageSuccess(messages: messages, isOtherUserTyping: otherUserIsTyping));
        }

        await _sendMessageRequest(
          content: effectiveContent,
          type: type.name,
          receiverGroupId: effectiveOtherGroupId,
          attachments: uploadedUrls,
          wave: type == MessageType.audio ? null : waveformData,
          duration: type == MessageType.audio ? null : duration,
        );

        // Final transition to non-sending state
        final finalIndex = messages.indexWhere((m) => m.id == message.id);
        if (finalIndex != -1) {
          final updatedList = List<MessageModel>.from(messages);
          updatedList[finalIndex] = messages[finalIndex].copyWith(isSending: false);
          messages = List.unmodifiable(updatedList);
          emit(MessageSuccess(messages: messages, isOtherUserTyping: otherUserIsTyping));
        }
      } catch (e) {
        log('❌ Error sending message: $e');
        final index = messages.indexWhere((m) => m.id == message.id);
        if (index != -1) {
          final updatedList = List<MessageModel>.from(messages);
          updatedList[index] = message.copyWith(isSending: false, hasFailed: true);
          messages = List.unmodifiable(updatedList);
          emit(MessageError(e.toString(), messages: messages, isOtherUserTyping: otherUserIsTyping));
        }
        sendingMessageIds.remove(message.id);
      }
    }
  }

  String _defaultMediaPreview(MessageType type) {
    switch (type) {
      case MessageType.image:
        return 'Photo';
      case MessageType.video:
        return 'Video';
      case MessageType.audio:
        return 'Audio message';
      case MessageType.file:
        return 'File';
      case MessageType.text:
        return '';
    }
  }

  /// Add a reaction to a message
  Future<void> addReaction(String messageId, String emoji) async {
    emit(MessageLoading(messages: messages, isOtherUserTyping: otherUserIsTyping));
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

    final updatedList = List<MessageModel>.from(messages);
    updatedList[messageIndex] = message.copyWith(reactions: reactions);
    messages = List.unmodifiable(updatedList);
    emit(MessageSuccess(messages: messages, isOtherUserTyping: otherUserIsTyping));

    try {
      await _reactToMessageRequest(
        messageId: messageId,
        emoji: emoji,
        isRemove: isRemove,
      );
    } catch (e) {
      emit(MessageError(e.toString(), messages: messages, isOtherUserTyping: otherUserIsTyping));
    }
  }

  /// Remove a reaction from a message
  Future<void> removeReaction(String messageId, String emoji) async {
    final messageIndex = messages.indexWhere((m) => m.id == messageId);
    if (messageIndex == -1) return;

    final message = messages[messageIndex];
    final reactions = List<ReactionModel>.from(message.reactions);

    reactions.removeWhere((r) => r.userId == currentUserId && r.emoji == emoji);

    final updatedList = List<MessageModel>.from(messages);
    updatedList[messageIndex] = message.copyWith(reactions: reactions);
    messages = List.unmodifiable(updatedList);
    emit(MessageSuccess(messages: messages, isOtherUserTyping: otherUserIsTyping));

    try {
      await _reactToMessageRequest(
        messageId: messageId,
        emoji: emoji,
        isRemove: true,
      );
    } catch (e) {
      emit(MessageError(e.toString(), messages: messages, isOtherUserTyping: otherUserIsTyping));
    }
  }

  /// Mark message as read
  Future<void> markMessageAsRead(String messageId) async {
    log("Marking message $messageId as read");
    final messageIndex = messages.indexWhere((m) => m.id == messageId);
    if (messageIndex == -1) return;

    final message = messages[messageIndex];
    if (!message.isRead && !message.isMe) {
      final updatedList = List<MessageModel>.from(messages);
      updatedList[messageIndex] = message.copyWith(
        isRead: true,
        readAt: DateTime.now(),
      );
      messages = List.unmodifiable(updatedList);
      emit(MessageSuccess(messages: messages, isOtherUserTyping: otherUserIsTyping));

      try {
        await _markMessageAsReadRequest(messageId);
      } catch (e) {
        final revertList = List<MessageModel>.from(messages);
        revertList[messageIndex] = message.copyWith(isRead: false, readAt: null);
        messages = List.unmodifiable(revertList);
        emit(MessageError(e.toString(), messages: messages, isOtherUserTyping: otherUserIsTyping));
      }
    }
  }

  /// Retry failed message
  Future<void> retryFailedMessage(String messageId) async {
    final messageIndex = messages.indexWhere((m) => m.id == messageId);
    if (messageIndex == -1) return;

    final message = messages[messageIndex];
    final updatedList1 = List<MessageModel>.from(messages);
    updatedList1[messageIndex] = message.copyWith(
      isSending: true,
      hasFailed: false,
    );
    messages = List.unmodifiable(updatedList1);
    emit(MessageSuccess(messages: messages, isOtherUserTyping: otherUserIsTyping));

    // Simulate sending
    await Future.delayed(const Duration(milliseconds: 500));

    final updatedList2 = List<MessageModel>.from(messages);
    updatedList2[messageIndex] = message.copyWith(
      isSending: false,
      hasFailed: false,
    );
    messages = List.unmodifiable(updatedList2);
    emit(MessageSuccess(messages: messages, isOtherUserTyping: otherUserIsTyping));
  }

  /// Delete a message
  Future<bool> deleteMessage(String messageId) async {
    emit(MessageLoading(messages: messages, isOtherUserTyping: otherUserIsTyping));
    final messageIndex = messages.indexWhere((m) => m.id == messageId);
    if (messageIndex == -1) return false;
    if (_groupId == null || _groupId!.isEmpty) return false;

    // Optimistically update UI
    final updatedList = List<MessageModel>.from(messages);
    final deletedMessage = updatedList.removeAt(messageIndex);
    messages = List.unmodifiable(updatedList);
    emit(MessageSuccess(messages: messages, isOtherUserTyping: otherUserIsTyping));

    try {
      await _deleteMessageRequest(messageId);
      return true;
    } catch (e) {
      // Revert if API call fails
      final revertList = List<MessageModel>.from(messages);
      revertList.insert(messageIndex, deletedMessage);
      messages = List.unmodifiable(revertList);
      emit(MessageError(e.toString(), messages: messages, isOtherUserTyping: otherUserIsTyping));
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
    messages = List.unmodifiable([message, ...messages]);
    emit(MessageSuccess(messages: messages, isOtherUserTyping: otherUserIsTyping));
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
    messages = const [];
    emit(MessageSuccess(messages: messages, isOtherUserTyping: otherUserIsTyping));
  }

  void _startOptimisticCleanup(String messageId) {
    Future.delayed(const Duration(seconds: 30), () {
      if (!isClosed && sendingMessageIds.contains(messageId)) {
        log('⚠️ Safety cleanup: removing stuck message ID $messageId after timeout');
        sendingMessageIds.remove(messageId);
      }
    });
  }

  /// Calculates the global index in the flattened media list for a specific message and local index
  int getGlobalMediaIndex(String messageId, int localImageIndex) {
    final mediaList = getMedias();
    final List<String> targetUrls = [];

    // Find the specific message and its URLs
    final msgIndex = messages.indexWhere((m) => m.id == messageId);
    if (msgIndex == -1) return 0;

    final targetMsg = messages[msgIndex];
    if (targetMsg.type == MessageType.image) {
      targetUrls.addAll(targetMsg.imageUrls);
    } else if (targetMsg.type == MessageType.video && targetMsg.mediaUrl != null) {
      targetUrls.add(targetMsg.mediaUrl!);
    }

    if (localImageIndex >= targetUrls.length) return 0;
    final targetUrl = targetUrls[localImageIndex];

    // Find this exact URL in the flattened list
    final globalIndex = mediaList.indexOf(targetUrl);
    return globalIndex != -1 ? globalIndex : 0;
  }
}
