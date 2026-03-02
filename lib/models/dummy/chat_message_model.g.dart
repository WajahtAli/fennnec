// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_message_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ChatMessage _$ChatMessageFromJson(Map<String, dynamic> json) => _ChatMessage(
  id: json['id'] as String,
  name: json['name'] as String,
  avatar: json['avatar'] as String?,
  text: json['text'] as String?,
  type: json['type'] as String,
  images:
      (json['images'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
  duration: json['duration'] as String?,
  mentionedUser: json['mentionedUser'] as String?,
  isMe: json['isMe'] as bool,
  isMyGroup: json['isMyGroup'] as bool? ?? false,
  reactions:
      (json['reactions'] as Map<String, dynamic>?)?.map(
        (k, e) =>
            MapEntry(k, (e as List<dynamic>).map((e) => e as String).toList()),
      ) ??
      const {},
);

Map<String, dynamic> _$ChatMessageToJson(_ChatMessage instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'avatar': instance.avatar,
      'text': instance.text,
      'type': instance.type,
      'images': instance.images,
      'duration': instance.duration,
      'mentionedUser': instance.mentionedUser,
      'isMe': instance.isMe,
      'isMyGroup': instance.isMyGroup,
      'reactions': instance.reactions,
    };
