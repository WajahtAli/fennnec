// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_MessageModel _$MessageModelFromJson(Map<String, dynamic> json) =>
    _MessageModel(
      id: json['id'] as String,
      senderId: json['senderId'] as String,
      senderName: json['senderName'] as String,
      senderAvatar: json['senderAvatar'] as String?,
      content: json['content'] as String,
      type: $enumDecode(_$MessageTypeEnumMap, json['type']),
      mediaUrl: json['mediaUrl'] as String?,
      imageUrls:
          (json['imageUrls'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      waveformData:
          (json['waveformData'] as List<dynamic>?)
              ?.map((e) => (e as num).toDouble())
              .toList() ??
          const [],
      mediaDuration: json['mediaDuration'] as String?,
      mentionedUserId: json['mentionedUserId'] as String?,
      mentionedUserName: json['mentionedUserName'] as String?,
      sentAt: DateTime.parse(json['sentAt'] as String),
      isMe: json['isMe'] as bool,
      isGroup: json['isGroup'] as bool? ?? false,
      reactions:
          (json['reactions'] as List<dynamic>?)
              ?.map((e) => ReactionModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      isRead: json['isRead'] as bool? ?? false,
      readAt: json['readAt'] == null
          ? null
          : DateTime.parse(json['readAt'] as String),
      isSending: json['isSending'] as bool? ?? false,
      hasFailed: json['hasFailed'] as bool? ?? false,
    );

Map<String, dynamic> _$MessageModelToJson(_MessageModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'senderId': instance.senderId,
      'senderName': instance.senderName,
      'senderAvatar': instance.senderAvatar,
      'content': instance.content,
      'type': _$MessageTypeEnumMap[instance.type]!,
      'mediaUrl': instance.mediaUrl,
      'imageUrls': instance.imageUrls,
      'waveformData': instance.waveformData,
      'mediaDuration': instance.mediaDuration,
      'mentionedUserId': instance.mentionedUserId,
      'mentionedUserName': instance.mentionedUserName,
      'sentAt': instance.sentAt.toIso8601String(),
      'isMe': instance.isMe,
      'isGroup': instance.isGroup,
      'reactions': instance.reactions,
      'isRead': instance.isRead,
      'readAt': instance.readAt?.toIso8601String(),
      'isSending': instance.isSending,
      'hasFailed': instance.hasFailed,
    };

const _$MessageTypeEnumMap = {
  MessageType.text: 'text',
  MessageType.image: 'image',
  MessageType.video: 'video',
  MessageType.audio: 'audio',
  MessageType.file: 'file',
};
