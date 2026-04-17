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
      members:
          (json['members'] as List<dynamic>?)
              ?.map((e) => MemberModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      pokes:
          (json['pokes'] as List<dynamic>?)
              ?.map((e) => ChatPokeModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      pagination: PaginationModel.fromJson(
        json['pagination'] as Map<String, dynamic>,
      ),
    );

Map<String, dynamic> _$ChatAndCallsDataToJson(_ChatAndCallsData instance) =>
    <String, dynamic>{
      'chats': instance.chats,
      'calls': instance.calls,
      'members': instance.members,
      'pokes': instance.pokes,
      'pagination': instance.pagination,
    };

_ChatModel _$ChatModelFromJson(Map<String, dynamic> json) => _ChatModel(
  type: json['type'] as String,
  id: json['id'] as String,
  name: json['name'] as String,
  image: json['image'] as String? ?? '',
  status: json['status'] as String? ?? '',
  lastMessage: json['lastMessage'] as String? ?? '',
  lastMessageAt: _dateTimeFromJsonNullable(json['lastMessageAt']),
  fromUserId: json['fromUserId'] as String?,
  unreadCount: (json['unreadCount'] as num).toInt(),
  meta: json['meta'] == null
      ? const ChatMetaModel()
      : ChatMetaModel.fromJson(json['meta'] as Map<String, dynamic>),
  members: (json['members'] as List<dynamic>?)
      ?.map((e) => MemberModel.fromJson(e as Map<String, dynamic>))
      .toList(),
  matchedGroupDetails: json['matchedGroupDetails'] == null
      ? null
      : MatchedGroupDetailsModel.fromJson(
          json['matchedGroupDetails'] as Map<String, dynamic>,
        ),
);

Map<String, dynamic> _$ChatModelToJson(_ChatModel instance) =>
    <String, dynamic>{
      'type': instance.type,
      'id': instance.id,
      'name': instance.name,
      'image': instance.image,
      'status': instance.status,
      'lastMessage': instance.lastMessage,
      'lastMessageAt': _dateTimeToJsonNullable(instance.lastMessageAt),
      'fromUserId': instance.fromUserId,
      'unreadCount': instance.unreadCount,
      'meta': instance.meta,
      'members': instance.members,
      'matchedGroupDetails': instance.matchedGroupDetails,
    };

_MatchedGroupDetailsModel _$MatchedGroupDetailsModelFromJson(
  Map<String, dynamic> json,
) => _MatchedGroupDetailsModel(
  id: json['id'] as String?,
  title: json['title'] as String?,
  members:
      (json['members'] as List<dynamic>?)
          ?.map(
            (e) => ChatGroupMemberUserModel.fromJson(e as Map<String, dynamic>),
          )
          .toList() ??
      const [],
  about: json['about'] == null
      ? null
      : ChatAboutGroupModel.fromJson(json['about'] as Map<String, dynamic>),
  sharedMedia:
      (json['sharedMedia'] as List<dynamic>?)
          ?.map((e) => SharedMediaModel.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
);

Map<String, dynamic> _$MatchedGroupDetailsModelToJson(
  _MatchedGroupDetailsModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'members': instance.members,
  'about': instance.about,
  'sharedMedia': instance.sharedMedia,
};

_SharedMediaModel _$SharedMediaModelFromJson(Map<String, dynamic> json) =>
    _SharedMediaModel(
      url: json['url'] as String,
      type: json['type'] as String?,
    );

Map<String, dynamic> _$SharedMediaModelToJson(_SharedMediaModel instance) =>
    <String, dynamic>{'url': instance.url, 'type': instance.type};

_ChatPokeModel _$ChatPokeModelFromJson(Map<String, dynamic> json) =>
    _ChatPokeModel(
      id: json['id'] as String,
      type: json['type'] as String? ?? 'poke',
      fromUserId: json['fromUserId'] as String?,
      name: json['name'] as String,
      image: json['image'] as String? ?? '',
      lastMessage: json['lastMessage'] as String? ?? '',
      lastMessageAt: _dateTimeFromJsonNullable(json['lastMessageAt']),
      unreadCount: (json['unreadCount'] as num).toInt(),
      pokes:
          (json['pokes'] as List<dynamic>?)
              ?.map(
                (e) => IndividualPokeModel.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          const [],
      meta: json['meta'] == null
          ? const ChatMetaModel()
          : ChatMetaModel.fromJson(json['meta'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ChatPokeModelToJson(_ChatPokeModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'fromUserId': instance.fromUserId,
      'name': instance.name,
      'image': instance.image,
      'lastMessage': instance.lastMessage,
      'lastMessageAt': _dateTimeToJsonNullable(instance.lastMessageAt),
      'unreadCount': instance.unreadCount,
      'pokes': instance.pokes,
      'meta': instance.meta,
    };

_IndividualPokeModel _$IndividualPokeModelFromJson(
  Map<String, dynamic> json,
) => _IndividualPokeModel(
  id: json['id'] as String,
  fromUser: json['fromUser'] == null
      ? null
      : ChatPokeUserModel.fromJson(json['fromUser'] as Map<String, dynamic>),
  toUserId: json['toUserId'] as String?,
  message: json['message'] as String? ?? '',
  createdAt: _dateTimeFromJsonNullable(json['createdAt']),
  status: json['status'] as String?,
  targetType: json['targetType'] as String?,
  targetId: json['targetId'] as String?,
  direction: json['direction'] as String?,
  targetPhoto: json['targetPhoto'] == null
      ? null
      : PokePhotoDetail.fromJson(json['targetPhoto'] as Map<String, dynamic>),
  targetPrompt: json['targetPrompt'] == null
      ? null
      : ChatPokePromptModel.fromJson(
          json['targetPrompt'] as Map<String, dynamic>,
        ),
);

Map<String, dynamic> _$IndividualPokeModelToJson(
  _IndividualPokeModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'fromUser': instance.fromUser,
  'toUserId': instance.toUserId,
  'message': instance.message,
  'createdAt': _dateTimeToJsonNullable(instance.createdAt),
  'status': instance.status,
  'targetType': instance.targetType,
  'targetId': instance.targetId,
  'direction': instance.direction,
  'targetPhoto': instance.targetPhoto,
  'targetPrompt': instance.targetPrompt,
};

_ChatPokeUserModel _$ChatPokeUserModelFromJson(Map<String, dynamic> json) =>
    _ChatPokeUserModel(
      id: json['id'] as String,
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
      image: json['image'] as String?,
    );

Map<String, dynamic> _$ChatPokeUserModelToJson(_ChatPokeUserModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'image': instance.image,
    };

_ChatPokePromptModel _$ChatPokePromptModelFromJson(Map<String, dynamic> json) =>
    _ChatPokePromptModel(
      id: json['id'] as String,
      promptTitle: json['promptTitle'] as String?,
      type: json['type'] as String?,
      promptAnswer: json['promptAnswer'] as String?,
    );

Map<String, dynamic> _$ChatPokePromptModelToJson(
  _ChatPokePromptModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'promptTitle': instance.promptTitle,
  'type': instance.type,
  'promptAnswer': instance.promptAnswer,
};

_ChatMetaModel _$ChatMetaModelFromJson(Map<String, dynamic> json) =>
    _ChatMetaModel(
      peerUserId: json['peerUserId'] as String?,
      totalPokes: (json['totalPokes'] as num?)?.toInt() ?? 0,
      receivedCount: (json['receivedCount'] as num?)?.toInt() ?? 0,
      sentCount: (json['sentCount'] as num?)?.toInt() ?? 0,
      pendingCount: (json['pendingCount'] as num?)?.toInt() ?? 0,
      latestPoke: json['latestPoke'] == null
          ? null
          : ChatLatestPokeModel.fromJson(
              json['latestPoke'] as Map<String, dynamic>,
            ),
      hasStartedChat: json['hasStartedChat'] as bool? ?? false,
      directChat: json['directChat'] == null
          ? null
          : ChatDirectChatMetaModel.fromJson(
              json['directChat'] as Map<String, dynamic>,
            ),
      groupId: json['groupId'] as String?,
      receiverGroupId: json['receiverGroupId'] as String?,
      receiverGroupIds:
          (json['receiverGroupIds'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      isMatchedGroup: json['isMatchedGroup'] as bool?,
      matchCount: (json['matchCount'] as num?)?.toInt() ?? 0,
      groupsDetails: json['groupsDetails'] == null
          ? null
          : ChatGroupsDetailsModel.fromJson(
              json['groupsDetails'] as Map<String, dynamic>,
            ),
    );

Map<String, dynamic> _$ChatMetaModelToJson(_ChatMetaModel instance) =>
    <String, dynamic>{
      'peerUserId': instance.peerUserId,
      'totalPokes': instance.totalPokes,
      'receivedCount': instance.receivedCount,
      'sentCount': instance.sentCount,
      'pendingCount': instance.pendingCount,
      'latestPoke': instance.latestPoke,
      'hasStartedChat': instance.hasStartedChat,
      'directChat': instance.directChat,
      'groupId': instance.groupId,
      'receiverGroupId': instance.receiverGroupId,
      'receiverGroupIds': instance.receiverGroupIds,
      'isMatchedGroup': instance.isMatchedGroup,
      'matchCount': instance.matchCount,
      'groupsDetails': instance.groupsDetails,
    };

_ChatGroupsDetailsModel _$ChatGroupsDetailsModelFromJson(
  Map<String, dynamic> json,
) => _ChatGroupsDetailsModel(
  userGroupMembers:
      (json['userGroupMembers'] as List<dynamic>?)
          ?.map(
            (e) => ChatGroupMemberUserModel.fromJson(e as Map<String, dynamic>),
          )
          .toList() ??
      const [],
  matchedGroupMembers:
      (json['matchedGroupMembers'] as List<dynamic>?)
          ?.map(
            (e) => MatchedGroupMembersModel.fromJson(e as Map<String, dynamic>),
          )
          .toList() ??
      const [],
  aboutThisGroup: json['aboutThisGroup'] == null
      ? null
      : ChatAboutGroupModel.fromJson(
          json['aboutThisGroup'] as Map<String, dynamic>,
        ),
  sharedMedia:
      (json['sharedMedia'] as List<dynamic>?)
          ?.map((e) => SharedMediaModel.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  commonInterests:
      (json['commonInterests'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  isMatched: json['isMatched'] as bool?,
);

Map<String, dynamic> _$ChatGroupsDetailsModelToJson(
  _ChatGroupsDetailsModel instance,
) => <String, dynamic>{
  'userGroupMembers': instance.userGroupMembers,
  'matchedGroupMembers': instance.matchedGroupMembers,
  'aboutThisGroup': instance.aboutThisGroup,
  'sharedMedia': instance.sharedMedia,
  'commonInterests': instance.commonInterests,
  'isMatched': instance.isMatched,
};

_MatchedGroupMembersModel _$MatchedGroupMembersModelFromJson(
  Map<String, dynamic> json,
) => _MatchedGroupMembersModel(
  groupId: json['groupId'] as String?,
  members:
      (json['members'] as List<dynamic>?)
          ?.map(
            (e) => ChatGroupMemberUserModel.fromJson(e as Map<String, dynamic>),
          )
          .toList() ??
      const [],
);

Map<String, dynamic> _$MatchedGroupMembersModelToJson(
  _MatchedGroupMembersModel instance,
) => <String, dynamic>{
  'groupId': instance.groupId,
  'members': instance.members,
};

_ChatGroupMemberUserModel _$ChatGroupMemberUserModelFromJson(
  Map<String, dynamic> json,
) => _ChatGroupMemberUserModel(
  id: json['id'] as String,
  firstName: json['firstName'] as String?,
  lastName: json['lastName'] as String?,
  image: json['image'] as String?,
);

Map<String, dynamic> _$ChatGroupMemberUserModelToJson(
  _ChatGroupMemberUserModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'firstName': instance.firstName,
  'lastName': instance.lastName,
  'image': instance.image,
};

_ChatAboutGroupModel _$ChatAboutGroupModelFromJson(Map<String, dynamic> json) =>
    _ChatAboutGroupModel(
      title: json['title'] as String?,
      bio: json['bio'] as String?,
      fitsForGroup: json['fitsForGroup'] as String?,
    );

Map<String, dynamic> _$ChatAboutGroupModelToJson(
  _ChatAboutGroupModel instance,
) => <String, dynamic>{
  'title': instance.title,
  'bio': instance.bio,
  'fitsForGroup': instance.fitsForGroup,
};

_ChatLatestPokeModel _$ChatLatestPokeModelFromJson(Map<String, dynamic> json) =>
    _ChatLatestPokeModel(
      id: json['id'] as String?,
      pokeId: json['pokeId'] as String?,
      fromUserId: json['fromUserId'] as String?,
      toUserId: json['toUserId'] as String?,
      peerUserId: json['peerUserId'] as String?,
      direction: json['direction'] as String?,
      status: json['status'] as String?,
      targetType: json['targetType'] as String?,
      targetId: json['targetId'] as String?,
    );

Map<String, dynamic> _$ChatLatestPokeModelToJson(
  _ChatLatestPokeModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'pokeId': instance.pokeId,
  'fromUserId': instance.fromUserId,
  'toUserId': instance.toUserId,
  'peerUserId': instance.peerUserId,
  'direction': instance.direction,
  'status': instance.status,
  'targetType': instance.targetType,
  'targetId': instance.targetId,
};

_ChatDirectChatMetaModel _$ChatDirectChatMetaModelFromJson(
  Map<String, dynamic> json,
) => _ChatDirectChatMetaModel(
  otherUserId: json['otherUserId'] as String?,
  unreadCount: (json['unreadCount'] as num?)?.toInt() ?? 0,
  lastMessageAt: _dateTimeFromJsonNullable(json['lastMessageAt']),
);

Map<String, dynamic> _$ChatDirectChatMetaModelToJson(
  _ChatDirectChatMetaModel instance,
) => <String, dynamic>{
  'otherUserId': instance.otherUserId,
  'unreadCount': instance.unreadCount,
  'lastMessageAt': _dateTimeToJsonNullable(instance.lastMessageAt),
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

_CallUserInfo _$CallUserInfoFromJson(Map<String, dynamic> json) =>
    _CallUserInfo(
      id: json['id'] as String,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String?,
      bestShorts:
          (json['bestShorts'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
    );

Map<String, dynamic> _$CallUserInfoToJson(_CallUserInfo instance) =>
    <String, dynamic>{
      'id': instance.id,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'bestShorts': instance.bestShorts,
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
  channelName: json['channelName'] as String?,
  mediaType: json['mediaType'] as String?,
  callType: json['callType'] as String?,
  startedAt: _dateTimeFromJsonNullable(json['startedAt']),
  callerId: json['callerId'] == null
      ? null
      : CallUserInfo.fromJson(json['callerId'] as Map<String, dynamic>),
  participantIds: (json['participantIds'] as List<dynamic>?)
      ?.map((e) => CallUserInfo.fromJson(e as Map<String, dynamic>))
      .toList(),
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
      'channelName': instance.channelName,
      'mediaType': instance.mediaType,
      'callType': instance.callType,
      'startedAt': _dateTimeToJsonNullable(instance.startedAt),
      'callerId': instance.callerId,
      'participantIds': instance.participantIds,
    };

_PaginationModel _$PaginationModelFromJson(Map<String, dynamic> json) =>
    _PaginationModel(
      page: (json['page'] as num).toInt(),
      limit: (json['limit'] as num).toInt(),
      totalChats: (json['totalChats'] as num).toInt(),
      totalCalls: (json['totalCalls'] as num).toInt(),
      totalPokes: (json['totalPokes'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$PaginationModelToJson(_PaginationModel instance) =>
    <String, dynamic>{
      'page': instance.page,
      'limit': instance.limit,
      'totalChats': instance.totalChats,
      'totalCalls': instance.totalCalls,
      'totalPokes': instance.totalPokes,
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
      poke: json['poke'] == null
          ? null
          : PokeModel.fromJson(json['poke'] as Map<String, dynamic>),
      pokes:
          (json['pokes'] as List<dynamic>?)
              ?.map((e) => PokeModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      fromUser: PokerFromUser.fromJson(
        json['fromUser'] as Map<String, dynamic>,
      ),
      pokedTargetDetail: PokedTargetDetail.fromJson(
        json['pokedTargetDetail'] as Map<String, dynamic>,
      ),
      activeGroup: json['activeGroup'] == null
          ? null
          : PokeActiveGroupModel.fromJson(
              json['activeGroup'] as Map<String, dynamic>,
            ),
    );

Map<String, dynamic> _$PokeDetailDataToJson(_PokeDetailData instance) =>
    <String, dynamic>{
      'poke': instance.poke,
      'pokes': instance.pokes,
      'fromUser': instance.fromUser,
      'pokedTargetDetail': instance.pokedTargetDetail,
      'activeGroup': instance.activeGroup,
    };

_PokeActiveGroupModel _$PokeActiveGroupModelFromJson(
  Map<String, dynamic> json,
) => _PokeActiveGroupModel(
  id: json['id'] as String,
  title: json['title'] as String?,
  bio: json['bio'] as String?,
  fitsForGroup: json['fitsForGroup'] as String?,
  members:
      (json['members'] as List<dynamic>?)
          ?.map(
            (e) => ChatGroupMemberUserModel.fromJson(e as Map<String, dynamic>),
          )
          .toList() ??
      const [],
);

Map<String, dynamic> _$PokeActiveGroupModelToJson(
  _PokeActiveGroupModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'bio': instance.bio,
  'fitsForGroup': instance.fitsForGroup,
  'members': instance.members,
};

_PokeModel _$PokeModelFromJson(Map<String, dynamic> json) => _PokeModel(
  id: json['id'] as String,
  fromUserId: json['fromUserId'] as String,
  fromUser: json['fromUser'] == null
      ? null
      : ChatPokeUserModel.fromJson(json['fromUser'] as Map<String, dynamic>),
  toUserId: json['toUserId'] as String,
  targetType: json['targetType'] as String,
  targetId: json['targetId'] as String?,
  message: json['message'] as String,
  status: json['status'] as String,
  readBy:
      (json['readBy'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
  targetPhoto: json['targetPhoto'] == null
      ? null
      : PokePhotoDetail.fromJson(json['targetPhoto'] as Map<String, dynamic>),
  targetPrompt: json['targetPrompt'] == null
      ? null
      : ChatPokePromptModel.fromJson(
          json['targetPrompt'] as Map<String, dynamic>,
        ),
  createdAt: _dateTimeFromJson(json['createdAt']),
  updatedAt: _dateTimeFromJson(json['updatedAt']),
);

Map<String, dynamic> _$PokeModelToJson(_PokeModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'fromUserId': instance.fromUserId,
      'fromUser': instance.fromUser,
      'toUserId': instance.toUserId,
      'targetType': instance.targetType,
      'targetId': instance.targetId,
      'message': instance.message,
      'status': instance.status,
      'readBy': instance.readBy,
      'targetPhoto': instance.targetPhoto,
      'targetPrompt': instance.targetPrompt,
      'createdAt': _dateTimeToJson(instance.createdAt),
      'updatedAt': _dateTimeToJson(instance.updatedAt),
    };

_PokerFromUser _$PokerFromUserFromJson(Map<String, dynamic> json) =>
    _PokerFromUser(
      id: json['id'] as String,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String?,
      bestShorts: (json['bestShorts'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      activeGroupId: json['activeGroupId'] as String?,
    );

Map<String, dynamic> _$PokerFromUserToJson(_PokerFromUser instance) =>
    <String, dynamic>{
      'id': instance.id,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'bestShorts': instance.bestShorts,
      'activeGroupId': instance.activeGroupId,
    };

_PokedTargetDetail _$PokedTargetDetailFromJson(
  Map<String, dynamic> json,
) => _PokedTargetDetail(
  type: json['type'] as String,
  photo: json['photo'] == null
      ? null
      : PokePhotoDetail.fromJson(json['photo'] as Map<String, dynamic>),
  audio: json['audio'] == null
      ? null
      : PokeAudioDetail.fromJson(json['audio'] as Map<String, dynamic>),
  profile: json['profile'] == null
      ? null
      : PokedProfileDetail.fromJson(json['profile'] as Map<String, dynamic>),
  prompt: json['prompt'] == null
      ? null
      : ChatPokePromptModel.fromJson(json['prompt'] as Map<String, dynamic>),
  text: json['text'] as String?,
);

Map<String, dynamic> _$PokedTargetDetailToJson(_PokedTargetDetail instance) =>
    <String, dynamic>{
      'type': instance.type,
      'photo': instance.photo,
      'audio': instance.audio,
      'profile': instance.profile,
      'prompt': instance.prompt,
      'text': instance.text,
    };

_PokedProfileDetail _$PokedProfileDetailFromJson(Map<String, dynamic> json) =>
    _PokedProfileDetail(
      id: json['id'] as String,
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
      'id': instance.id,
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
