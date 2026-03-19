// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_and_calls_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ChatAndCallsResponse _$ChatAndCallsResponseFromJson(
  Map<String, dynamic> json,
) => _ChatAndCallsResponse(
  success: json['success'] as bool,
  message: json['message'] as String,
  data: ChatAndCallsData.fromJson(json['data'] as Map<String, dynamic>),
);

Map<String, dynamic> _$ChatAndCallsResponseToJson(
  _ChatAndCallsResponse instance,
) => <String, dynamic>{
  'success': instance.success,
  'message': instance.message,
  'data': instance.data,
};

_ChatAndCallsData _$ChatAndCallsDataFromJson(Map<String, dynamic> json) =>
    _ChatAndCallsData(
      chats: (json['chats'] as List<dynamic>)
          .map((e) => ChatModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      calls: (json['calls'] as List<dynamic>)
          .map((e) => CallModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      pagination: PaginationModel.fromJson(
        json['pagination'] as Map<String, dynamic>,
      ),
    );

Map<String, dynamic> _$ChatAndCallsDataToJson(_ChatAndCallsData instance) =>
    <String, dynamic>{
      'chats': instance.chats,
      'calls': instance.calls,
      'pagination': instance.pagination,
    };

_ChatModel _$ChatModelFromJson(Map<String, dynamic> json) => _ChatModel(
  type: json['type'] as String,
  id: json['id'] as String,
  name: json['name'] as String,
  image: json['image'] as String? ?? '',
  lastMessage: json['lastMessage'] as String? ?? '',
  lastMessageAt: json['lastMessageAt'] == null
      ? null
      : DateTime.parse(json['lastMessageAt'] as String),
  unreadCount: (json['unreadCount'] as num).toInt(),
  meta: json['meta'] as Map<String, dynamic>,
  members: (json['members'] as List<dynamic>?)
      ?.map((e) => MemberModel.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$ChatModelToJson(_ChatModel instance) =>
    <String, dynamic>{
      'type': instance.type,
      'id': instance.id,
      'name': instance.name,
      'image': instance.image,
      'lastMessage': instance.lastMessage,
      'lastMessageAt': instance.lastMessageAt?.toIso8601String(),
      'unreadCount': instance.unreadCount,
      'meta': instance.meta,
      'members': instance.members,
    };

_MemberModel _$MemberModelFromJson(Map<String, dynamic> json) => _MemberModel(
  id: json['id'] as String,
  name: json['name'] as String,
  image: json['image'] as String,
);

Map<String, dynamic> _$MemberModelToJson(_MemberModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'image': instance.image,
    };

_CallModel _$CallModelFromJson(Map<String, dynamic> json) => _CallModel(
  id: json['id'] as String,
  name: json['name'] as String?,
  image: json['image'] as String?,
  members: (json['members'] as List<dynamic>?)
      ?.map((e) => MemberModel.fromJson(e as Map<String, dynamic>))
      .toList(),
  callTypeLabel: json['callTypeLabel'] as String?,
  duration: json['duration'] as String?,
  timeAgo: json['timeAgo'] as String?,
  status: json['status'] as String?,
);

Map<String, dynamic> _$CallModelToJson(_CallModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'image': instance.image,
      'members': instance.members,
      'callTypeLabel': instance.callTypeLabel,
      'duration': instance.duration,
      'timeAgo': instance.timeAgo,
      'status': instance.status,
    };

_PaginationModel _$PaginationModelFromJson(Map<String, dynamic> json) =>
    _PaginationModel(
      page: (json['page'] as num).toInt(),
      limit: (json['limit'] as num).toInt(),
      totalChats: (json['totalChats'] as num).toInt(),
      totalCalls: (json['totalCalls'] as num).toInt(),
    );

Map<String, dynamic> _$PaginationModelToJson(_PaginationModel instance) =>
    <String, dynamic>{
      'page': instance.page,
      'limit': instance.limit,
      'totalChats': instance.totalChats,
      'totalCalls': instance.totalCalls,
    };

_PokeDetailResponse _$PokeDetailResponseFromJson(Map<String, dynamic> json) =>
    _PokeDetailResponse(
      success: json['success'] as bool,
      message: json['message'] as String,
      data: PokeDetailData.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PokeDetailResponseToJson(_PokeDetailResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'data': instance.data,
    };

_PokeDetailData _$PokeDetailDataFromJson(Map<String, dynamic> json) =>
    _PokeDetailData(
      poke: PokeModel.fromJson(json['poke'] as Map<String, dynamic>),
      fromUser: PokerFromUser.fromJson(
        json['fromUser'] as Map<String, dynamic>,
      ),
      pokedTargetDetail: PokedTargetDetail.fromJson(
        json['pokedTargetDetail'] as Map<String, dynamic>,
      ),
    );

Map<String, dynamic> _$PokeDetailDataToJson(_PokeDetailData instance) =>
    <String, dynamic>{
      'poke': instance.poke,
      'fromUser': instance.fromUser,
      'pokedTargetDetail': instance.pokedTargetDetail,
    };

_PokeModel _$PokeModelFromJson(Map<String, dynamic> json) => _PokeModel(
  id: json['id'] as String,
  fromUserId: json['fromUserId'] as String,
  toUserId: json['toUserId'] as String,
  targetType: json['targetType'] as String,
  targetId: json['targetId'] as String?,
  message: json['message'] as String,
  status: json['status'] as String,
  createdAt: DateTime.parse(json['createdAt'] as String),
  updatedAt: DateTime.parse(json['updatedAt'] as String),
);

Map<String, dynamic> _$PokeModelToJson(_PokeModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'fromUserId': instance.fromUserId,
      'toUserId': instance.toUserId,
      'targetType': instance.targetType,
      'targetId': instance.targetId,
      'message': instance.message,
      'status': instance.status,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };

_PokerFromUser _$PokerFromUserFromJson(Map<String, dynamic> json) =>
    _PokerFromUser(
      id: json['id'] as String,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String?,
      bestShorts: (json['bestShorts'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$PokerFromUserToJson(_PokerFromUser instance) =>
    <String, dynamic>{
      'id': instance.id,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'bestShorts': instance.bestShorts,
    };

_PokedTargetDetail _$PokedTargetDetailFromJson(Map<String, dynamic> json) =>
    _PokedTargetDetail(
      type: json['type'] as String,
      photo: json['photo'] == null
          ? null
          : PokePhotoDetail.fromJson(json['photo'] as Map<String, dynamic>),
      audio: json['audio'] == null
          ? null
          : PokeAudioDetail.fromJson(json['audio'] as Map<String, dynamic>),
      profile: json['profile'] == null
          ? null
          : PokedProfileDetail.fromJson(
              json['profile'] as Map<String, dynamic>,
            ),
      text: json['text'] as String?,
    );

Map<String, dynamic> _$PokedTargetDetailToJson(_PokedTargetDetail instance) =>
    <String, dynamic>{
      'type': instance.type,
      'photo': instance.photo,
      'audio': instance.audio,
      'profile': instance.profile,
      'text': instance.text,
    };

_PokedProfileDetail _$PokedProfileDetailFromJson(Map<String, dynamic> json) =>
    _PokedProfileDetail(
      id: json['_id'] as String,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String?,
      bestShorts: (json['bestShorts'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      shortBio: json['shortBio'] as String?,
      lifestyleLikes: (json['lifestyleLikes'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$PokedProfileDetailToJson(_PokedProfileDetail instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'bestShorts': instance.bestShorts,
      'shortBio': instance.shortBio,
      'lifestyleLikes': instance.lifestyleLikes,
    };

_PokePhotoDetail _$PokePhotoDetailFromJson(Map<String, dynamic> json) =>
    _PokePhotoDetail(
      index: (json['index'] as num).toInt(),
      url: json['url'] as String,
    );

Map<String, dynamic> _$PokePhotoDetailToJson(_PokePhotoDetail instance) =>
    <String, dynamic>{'index': instance.index, 'url': instance.url};

_PokeAudioDetail _$PokeAudioDetailFromJson(Map<String, dynamic> json) =>
    _PokeAudioDetail(url: json['url'] as String);

Map<String, dynamic> _$PokeAudioDetailToJson(_PokeAudioDetail instance) =>
    <String, dynamic>{'url': instance.url};

_PokeStartChatResponse _$PokeStartChatResponseFromJson(
  Map<String, dynamic> json,
) => _PokeStartChatResponse(
  success: json['success'] as bool,
  message: json['message'] as String,
  data: PokeStartChatData.fromJson(json['data'] as Map<String, dynamic>),
);

Map<String, dynamic> _$PokeStartChatResponseToJson(
  _PokeStartChatResponse instance,
) => <String, dynamic>{
  'success': instance.success,
  'message': instance.message,
  'data': instance.data,
};

_PokeStartChatData _$PokeStartChatDataFromJson(Map<String, dynamic> json) =>
    _PokeStartChatData(
      poke: PokeModel.fromJson(json['poke'] as Map<String, dynamic>),
      chatWithUserId: json['chatWithUserId'] as String,
    );

Map<String, dynamic> _$PokeStartChatDataToJson(_PokeStartChatData instance) =>
    <String, dynamic>{
      'poke': instance.poke,
      'chatWithUserId': instance.chatWithUserId,
    };
