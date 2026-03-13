import 'package:equatable/equatable.dart';
import 'package:fennac_app/pages/chats/data/models/message_model.dart';
import 'package:fennac_app/pages/chats/data/models/message_type_enum.dart';
import 'package:fennac_app/pages/chats/data/models/reaction_model.dart';
import 'package:fennac_app/pages/my_group/domain/repository/my_group_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

import 'package:fennac_app/app/constants/app_constants.dart';
import 'package:fennac_app/core/network/api_helper.dart';

part '../state/message_state.dart';

class MessageCubit extends Cubit<MessageState> {
  final MyGroupRepository _myGroupRepository;
  final ApiHelper _apiHelper;

  MessageCubit(this._myGroupRepository, this._apiHelper)
    : super(MessageInitial());

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
      await loadMoreMessages();

      isLoading = false;
      hasError = false;
      emit(MessageSuccess());
    } catch (e) {
      isLoading = false;
      hasError = true;
      errorMessage = e.toString();
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

      messages.addAll(newMessages);
      isFetchingMore = false;
      emit(MessageSuccess());
    } catch (e) {
      isFetchingMore = false;
      rethrow;
    }
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

    // Upload files if they are local paths
    List<String> uploadedUrls = [];
    try {
      for (String path in mediaPath) {
        if (path.startsWith('http')) {
          uploadedUrls.add(path);
        } else {
          final uploadResponse = await _apiHelper.uploadFile(
            AppConstants.uploadSingle,
            fileFieldName: 'file',
            filePath: path,
          );

          if (uploadResponse != null) {
            String? url;
            if (uploadResponse is Map<String, dynamic>) {
              if (uploadResponse.containsKey('data') &&
                  uploadResponse['data'] is Map) {
                final data = uploadResponse['data'] as Map<String, dynamic>;
                url = data['url'] as String?;
              } else if (uploadResponse.containsKey('url')) {
                url = uploadResponse['url'] as String?;
              }
            }

            if (url != null && url.isNotEmpty) {
              uploadedUrls.add(url);
            } else {
              throw Exception("Failed to get URL from upload response");
            }
          } else {
            throw Exception("Upload failed: No response from server");
          }
        }
      }
    } catch (e) {
      emit(MessageError("Media upload failed: ${e.toString()}"));
      return;
    }

    final message = MessageModel(
      id: _uuid.v4(),
      senderId: currentUserId,
      senderName: currentUserName,
      senderAvatar: currentUserAvatar,
      content: caption ?? '',
      type: type,
      mediaUrl: uploadedUrls.length == 1 ? uploadedUrls.first : null,
      imageUrls: uploadedUrls,
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
        if (_isGroup) {
          await _myGroupRepository.sendGroupMessage(
            _groupId!,
            content: caption ?? '',
            type: type.name,
            attachments: uploadedUrls,
          );
        } else {
          await _myGroupRepository.sendDirectMessage(
            _groupId!,
            content: caption ?? '',
            type: type.name,
            attachments: uploadedUrls,
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
  Future<void> deleteMessage(String messageId) async {
    final messageIndex = messages.indexWhere((m) => m.id == messageId);
    if (messageIndex == -1) return;

    // Optimistically update UI
    final deletedMessage = messages.removeAt(messageIndex);
    emit(MessageSuccess());

    try {
      if (_groupId != null) {
        if (_isGroup) {
          await _myGroupRepository.deleteGroupMessage(_groupId!, messageId);
        } else {
          await _myGroupRepository.deleteDirectMessage(_groupId!, messageId);
        }
      }
    } catch (e) {
      // Revert if API call fails
      messages.insert(messageIndex, deletedMessage);
      emit(MessageError(e.toString()));
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
