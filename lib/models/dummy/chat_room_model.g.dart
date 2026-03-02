// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_room_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ChatRoom _$ChatRoomFromJson(Map<String, dynamic> json) => _ChatRoom(
  id: json['id'] as String,
  message: json['message'] as String,
  timeAgo: json['timeAgo'] as String,
  isGroup: json['isGroup'] as bool,
  name: json['name'] as String?,
  avatar: json['avatar'] as String?,
  isOnline: json['isOnline'] as bool? ?? false,
  isPoked: json['isPoked'] as bool? ?? false,
  names: (json['names'] as List<dynamic>?)?.map((e) => e as String).toList(),
  avatars: (json['avatars'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
);

Map<String, dynamic> _$ChatRoomToJson(_ChatRoom instance) => <String, dynamic>{
  'id': instance.id,
  'message': instance.message,
  'timeAgo': instance.timeAgo,
  'isGroup': instance.isGroup,
  'name': instance.name,
  'avatar': instance.avatar,
  'isOnline': instance.isOnline,
  'isPoked': instance.isPoked,
  'names': instance.names,
  'avatars': instance.avatars,
};
