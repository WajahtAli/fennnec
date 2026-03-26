import 'package:fennac_app/pages/chats/data/models/message_type_enum.dart';
import 'package:fennac_app/pages/chats/data/models/reaction_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'message_model.freezed.dart';

@freezed
abstract class MessageModel with _$MessageModel {
  const factory MessageModel({
    required String id,
    required String senderId,
    required String senderName,
    String? senderAvatar,
    required String content,
    required MessageType type,
    String? mediaUrl,
    @Default([]) List<String> imageUrls,
    @Default([]) List<double> waveformData,
    String? mediaDuration,
    String? mentionedUserId,
    String? mentionedUserName,
    required DateTime sentAt,
    required bool isMe,
    @Default(false) bool isGroup,
    @Default([]) List<ReactionModel> reactions,
    @Default(false) bool isRead,
    DateTime? readAt,
    @Default(false) bool isSending,
    @Default(false) bool hasFailed,
  }) = _MessageModel;

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    final senderObj =
        json['senderId'] is Map ? json['senderId'] as Map<String, dynamic> : null;

    return MessageModel(
      id: json['_id'] ?? json['id'] ?? '',
      senderId: senderObj?['_id'] ?? json['senderId'] ?? '',
      senderName: senderObj != null
          ? '${senderObj['firstName']} ${senderObj['lastName']}'.trim()
          : (json['senderName'] ?? ''),
      senderAvatar: json['senderAvatar'],
      content: json['content'] ?? '',
      type: MessageTypeExtension.fromString(json['type'] ?? 'text'),
      mediaUrl: (json['attachments'] as List?)?.firstOrNull,
      imageUrls: (json['attachments'] as List?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
      waveformData: (json['wave'] as List?)
              ?.map((e) => double.tryParse(e.toString()) ?? 0.0)
              .toList() ??
          [],
      mediaDuration: json['duration'],
      sentAt: DateTime.tryParse(json['createdAt'] ?? json['sentAt'] ?? '') ??
          DateTime.now(),
      isMe: json['isFromMe'] ?? json['isMe'] ?? false,
      reactions: (json['reactions'] as List?)
              ?.map((e) => ReactionModel.fromJson(e))
              .toList() ??
          [],
    );
  }
}
