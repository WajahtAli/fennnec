import 'dart:developer';
import 'package:equatable/equatable.dart';

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

part '../state/message_state.dart';

class MessageCubit extends Cubit<MessageState> {
  final MyGroupRepository _myGroupRepository;

  MessageCubit(this._myGroupRepository) : super(MessageInitial());

  final TextEditingController messageController = TextEditingController();
  bool showAttachmentPanel = false;
  bool fieldHaveText = false;
  bool isRecordingAudio = false;

  void toggleAttachmentPanel({bool? close}) {
    emit(MessageLoading());
    if (close != null) {
      showAttachmentPanel = !close;
      emit(MessageSuccess());
      return;
    } else {
      showAttachmentPanel = !showAttachmentPanel;
    }
    emit(MessageSuccess());
  }

  void toggleRecordingAudio({bool? stop}) {
    emit(MessageLoading());
    if (stop != null) {
      isRecordingAudio = !stop;
      emit(MessageSuccess());
      return;
    } else {
      isRecordingAudio = !isRecordingAudio;
    }
    emit(MessageSuccess());
  }

  void updateFieldHaveText(bool haveText) {
    emit(MessageLoading());
    fieldHaveText = haveText;
    emit(MessageSuccess());
  }

  // check is text input is empty
  bool isTextInputEmpty() {
    return messageController.text.trim().isEmpty;
  }

  // Variables in cubit (not in state)
  List<MessageModel> messages = [];
  // get all medias from messages
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
  final _uuid = const Uuid();
  final SharedPreferencesHelper _sharedPreferencesHelper = Di()
      .sl<SharedPreferencesHelper>();

  // Current user ID (should be fetched from auth in real app)
  String currentUserId = '1';
  String currentUserName = 'You';
  String? currentUserAvatar;

  // Pagination
  int _page = 1;
  final int _limit = 20;
  bool _hasMore = true;
  String? _groupId; // used as chat id (group or user depending on _isGroup)
  bool _isGroup = true;
  bool isFetchingMore = false;

  /// Initialize messages (can load from local storage or backend)
  Future<void> initializeMessages(String id, {bool isGroup = true}) async {
    _groupId = id;
    _isGroup = isGroup;
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
    } catch (e) {
      isLoading = false;
      hasError = true;
      errorMessage = e.toString();
      log("error while getting messages ${e.toString()}");
      emit(MessageError(e.toString()));
    }
  }

  Future<void> loadMoreMessages() async {
    if (!_hasMore || _groupId == null || isFetchingMore) return;

    isFetchingMore = true;
    try {
      final newMessages = _isGroup
          ? await _myGroupRepository.fetchGroupMessages(
              _groupId!,
              page: _page,
              limit: _limit,
            )
          : await _myGroupRepository.fetchDirectMessages(
              _groupId!,
              page: _page,
              limit: _limit,
            );

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
  Future<void> sendTextMessage() async {
    emit(MessageLoading());
    final content = messageController.text;
    if (content.trim().isEmpty) return;

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
    );

    _addMessage(message);

    messageController.clear();

    final index = messages.indexWhere((m) => m.id == message.id);
    if (index != -1) {
      try {
        if (_isGroup) {
          await _myGroupRepository.sendGroupMessage(
            _groupId!,
            content: content,
            type: 'text',
          );
        } else {
          await _myGroupRepository.sendDirectMessage(
            _groupId!,
            content: content,
            type: 'text',
          );
        }
        messages[index] = message.copyWith(isSending: false);
        emit(MessageSuccess());
      } catch (e) {
        messages[index] = message.copyWith(isSending: false, hasFailed: true);
        emit(MessageError(e.toString()));
      }
    }
  }

  /// Send a media message (image, video, audio, file)
  Future<void> sendMediaMessage({
    required List<String> mediaPath,
    List<double>? waveformData,
    required MessageType type,
    String? caption,
    String? duration,
  }) async {
    emit(MessageLoading());
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
    );

    _addMessage(message);

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
            ? " "
            : caption;

        if (_isGroup) {
          await _myGroupRepository.sendGroupMessage(
            _groupId!,
            content: effectiveContent,
            type: type.name,
            attachments: uploadedUrls,
            wave: waveformData,
            duration: duration,
          );
        } else {
          await _myGroupRepository.sendDirectMessage(
            _groupId!,
            content: effectiveContent,
            type: type.name,
            attachments: uploadedUrls,
            wave: waveformData,
            duration: duration,
          );
        }
        messages[index] = message.copyWith(
          isSending: false,
          imageUrls: uploadedUrls,
          mediaUrl: uploadedUrls.length == 1 ? uploadedUrls.first : null,
        );
        emit(MessageSuccess());
      } catch (e) {
        messages[index] = message.copyWith(isSending: false, hasFailed: true);
        emit(MessageError(e.toString()));
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
      if (_groupId != null) {
        if (_isGroup) {
          await _myGroupRepository.reactToGroupMessage(
            _groupId!,
            messageId,
            emoji,
            isRemove: isRemove,
          );
        } else {
          await _myGroupRepository.reactToDirectMessage(
            _groupId!,
            messageId,
            emoji,
            isRemove: isRemove,
          );
        }
      }
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
      if (_groupId != null) {
        if (_isGroup) {
          await _myGroupRepository.reactToGroupMessage(
            _groupId!,
            messageId,
            emoji,
            isRemove: true,
          );
        } else {
          await _myGroupRepository.reactToDirectMessage(
            _groupId!,
            messageId,
            emoji,
            isRemove: true,
          );
        }
      }
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
        if (_groupId != null) {
          if (_isGroup) {
            await _myGroupRepository.markGroupMessageAsRead(
              _groupId!,
              messageId,
            );
          } else {
            await _myGroupRepository.markDirectMessageAsRead(
              _groupId!,
              messageId,
            );
          }
        }
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
    final messageIndex = messages.indexWhere((m) => m.id == messageId);
    if (messageIndex == -1) return false;
    if (_groupId == null || _groupId!.isEmpty) return false;

    // Optimistically update UI
    final deletedMessage = messages.removeAt(messageIndex);
    emit(MessageSuccess());

    try {
      if (_isGroup) {
        await _myGroupRepository.deleteGroupMessage(_groupId!, messageId);
      } else {
        await _myGroupRepository.deleteDirectMessage(_groupId!, messageId);
      }
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
    emit(MessageLoading());
    messages.insert(0, message);
    emit(MessageSuccess());
  }

  /// Get grouped reactions for display
  Map<String, List<String>> getGroupedReactions(String messageId) {
    final message = messages.firstWhere(
      (m) => m.id == messageId,
      orElse: () => messages.first,
    );

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
