import 'package:fennac_app/pages/chats/data/models/message_type_enum.dart';
import 'package:fennac_app/pages/chats/data/models/reaction_model.dart';
import 'package:fennac_app/utils/validators.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'message_model.freezed.dart';

@freezed
abstract class MessageModel with _$MessageModel {
  const factory MessageModel({
    required String id,
    required String senderId,
    required String senderName,
    String? senderAvatar,
    String? reciverId,
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
    String? nullableString(dynamic value) {
      final text = validateString(value).trim();
      return text.isEmpty ? null : text;
    }

    DateTime parseDate(dynamic primary, dynamic secondary) {
      final parsedPrimary = DateTime.tryParse(validateString(primary));
      if (parsedPrimary != null) return parsedPrimary;

      final parsedSecondary = DateTime.tryParse(validateString(secondary));
      if (parsedSecondary != null) return parsedSecondary;

      return DateTime.now();
    }

    Map<String, dynamic>? mapOrNull(dynamic value) {
      if (value is! Map) return null;
      return Map<String, dynamic>.from(value);
    }

    List<dynamic> listOrEmpty(dynamic value) {
      if (value is! List) return const [];
      return List<dynamic>.from(value);
    }

    final senderObj = mapOrNull(json['senderId']);

    final senderFirstName = validateString(senderObj?['firstName']).trim();
    final senderLastName = validateString(senderObj?['lastName']).trim();
    final senderFullName = '$senderFirstName $senderLastName'.trim();

    final attachments = listOrEmpty(json['attachments']);
    final wave = listOrEmpty(json['wave']);
    final reactions = listOrEmpty(json['reactions']);

    return MessageModel(
      id: validateString(json['_id']).isNotEmpty
          ? validateString(json['_id'])
          : validateString(json['id']),
      senderId: validateString(senderObj?['_id']).isNotEmpty
          ? validateString(senderObj?['_id'])
          : validateString(json['senderId']),
      senderName: senderFullName.isNotEmpty
          ? senderFullName
          : validateString(json['senderName']),
      senderAvatar: nullableString(json['senderAvatar']),
      content: validateString(json['content']),
      type: MessageTypeExtension.fromString(validateString(json['type'])),
      mediaUrl: nullableString(attachments.firstOrNull),
      imageUrls: attachments.map((e) => validateString(e)).toList(),
      waveformData: wave.map((e) => validateDouble(e)).toList(),
      mediaDuration: nullableString(json['duration']),
      sentAt: parseDate(json['createdAt'], json['sentAt']),
      isMe: validateBool(json['isFromMe']) || validateBool(json['isMe']),
      reactions: reactions
          .map((e) => mapOrNull(e))
          .whereType<Map<String, dynamic>>()
          .map(ReactionModel.fromJson)
          .toList(),
    );
  }
}
