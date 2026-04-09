// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'chat_and_calls_response.freezed.dart';
part 'chat_and_calls_response.g.dart';

DateTime? _dateTimeFromJsonNullable(dynamic value) {
  if (value == null) return null;
  final raw = value.toString().trim();
  if (raw.isEmpty || raw.toLowerCase() == 'invalid' || raw == 'null') {
    return null;
  }
  return DateTime.tryParse(raw);
}

String? _dateTimeToJsonNullable(DateTime? dateTime) =>
    dateTime?.toIso8601String();

DateTime _dateTimeFromJson(dynamic value) {
  final parsed = _dateTimeFromJsonNullable(value);
  return parsed ?? DateTime.fromMillisecondsSinceEpoch(0);
}

String _dateTimeToJson(DateTime dateTime) => dateTime.toIso8601String();

// ─────────────────────────────────────────────
// TOP-LEVEL RESPONSE
// ─────────────────────────────────────────────

@freezed
abstract class ChatAndCallsResponse with _$ChatAndCallsResponse {
  const factory ChatAndCallsResponse({
    required bool success,
    required String message,
    required ChatAndCallsData data,
  }) = _ChatAndCallsResponse;

  factory ChatAndCallsResponse.fromJson(Map<String, dynamic> json) =>
      _$ChatAndCallsResponseFromJson(json);
}

@freezed
abstract class ChatAndCallsData with _$ChatAndCallsData {
  const factory ChatAndCallsData({
    required List<ChatModel> chats,
    required List<CallModel> calls,
    @Default([]) List<MemberModel> members,
    @Default([]) List<ChatPokeModel> pokes, // moved from ChatModel to top-level
    required PaginationModel pagination,
  }) = _ChatAndCallsData;

  factory ChatAndCallsData.fromJson(Map<String, dynamic> json) =>
      _$ChatAndCallsDataFromJson(json);
}

// ─────────────────────────────────────────────
// CHAT MODELS
// ─────────────────────────────────────────────

@freezed
abstract class ChatModel with _$ChatModel {
  const factory ChatModel({
    required String type,
    required String id,
    required String name,
    @Default('') String image,
    @Default('') String status,
    @Default('') String lastMessage,
    @JsonKey(
      fromJson: _dateTimeFromJsonNullable,
      toJson: _dateTimeToJsonNullable,
    )
    DateTime? lastMessageAt,
    String? fromUserId,
    required int unreadCount,
    @Default(ChatMetaModel()) ChatMetaModel meta,
    List<MemberModel>? members,
    MatchedGroupDetailsModel? matchedGroupDetails, // new field from JSON
  }) = _ChatModel;

  factory ChatModel.fromJson(Map<String, dynamic> json) =>
      _$ChatModelFromJson(json);
}

// ─────────────────────────────────────────────
// MATCHED GROUP DETAILS (new model)
// ─────────────────────────────────────────────

@freezed
abstract class MatchedGroupDetailsModel with _$MatchedGroupDetailsModel {
  const factory MatchedGroupDetailsModel({
    String? id,
    String? title,
    @Default([]) List<ChatGroupMemberUserModel> members,
    ChatAboutGroupModel? about,
    @Default([]) List<SharedMediaModel> sharedMedia,
  }) = _MatchedGroupDetailsModel;

  factory MatchedGroupDetailsModel.fromJson(Map<String, dynamic> json) =>
      _$MatchedGroupDetailsModelFromJson({
        ...json,
        'id': json['id'] ?? json['_id'] ?? '',
      });
}

// ─────────────────────────────────────────────
// SHARED MEDIA (new model — was List<String>, now object)
// ─────────────────────────────────────────────

@freezed
abstract class SharedMediaModel with _$SharedMediaModel {
  const factory SharedMediaModel({required String url, String? type}) =
      _SharedMediaModel;

  factory SharedMediaModel.fromJson(Map<String, dynamic> json) =>
      _$SharedMediaModelFromJson(json);
}

// ─────────────────────────────────────────────
// POKE MODELS
// ─────────────────────────────────────────────

@freezed
abstract class ChatPokeModel with _$ChatPokeModel {
  const factory ChatPokeModel({
    required String id,
    @Default('poke') String type,
    String? fromUserId,
    required String name,
    @Default('') String image,
    @Default('') String lastMessage,
    @JsonKey(
      fromJson: _dateTimeFromJsonNullable,
      toJson: _dateTimeToJsonNullable,
    )
    DateTime? lastMessageAt,
    required int unreadCount,
    @Default([]) List<IndividualPokeModel> pokes,
    @Default(ChatMetaModel()) ChatMetaModel meta,
  }) = _ChatPokeModel;

  factory ChatPokeModel.fromJson(Map<String, dynamic> json) =>
      _$ChatPokeModelFromJson({
        ...json,
        'id': json['id'] ?? json['_id'] ?? '',
      });
}

@freezed
abstract class IndividualPokeModel with _$IndividualPokeModel {
  const factory IndividualPokeModel({
    required String id,
    ChatPokeUserModel? fromUser,
    String? toUserId,
    @Default('') String message,
    @JsonKey(
      fromJson: _dateTimeFromJsonNullable,
      toJson: _dateTimeToJsonNullable,
    )
    DateTime? createdAt,
    String? status,
    String? targetType,
    String? targetId,
    String? direction,
    PokePhotoDetail? targetPhoto,
    ChatPokePromptModel? targetPrompt,
  }) = _IndividualPokeModel;

  factory IndividualPokeModel.fromJson(Map<String, dynamic> json) =>
      _$IndividualPokeModelFromJson({
        ...json,
        'id': json['id'] ?? json['_id'] ?? '',
        'fromUser': json['fromUserId'] is Map<String, dynamic>
            ? json['fromUserId']
            : null,
      });
}

@freezed
abstract class ChatPokeUserModel with _$ChatPokeUserModel {
  const factory ChatPokeUserModel({
    required String id,
    String? firstName,
    String? lastName,
    String? image,
  }) = _ChatPokeUserModel;

  factory ChatPokeUserModel.fromJson(Map<String, dynamic> json) =>
      _$ChatPokeUserModelFromJson({
        ...json,
        'id': json['id'] ?? json['_id'] ?? '',
      });
}

@freezed
abstract class ChatPokePromptModel with _$ChatPokePromptModel {
  const factory ChatPokePromptModel({
    required String id,
    String? promptTitle,
    String? type,
    String? promptAnswer,
  }) = _ChatPokePromptModel;

  factory ChatPokePromptModel.fromJson(Map<String, dynamic> json) =>
      _$ChatPokePromptModelFromJson({
        ...json,
        'id': json['id'] ?? json['_id'] ?? '',
      });
}

// ─────────────────────────────────────────────
// CHAT META
// ─────────────────────────────────────────────

@freezed
abstract class ChatMetaModel with _$ChatMetaModel {
  const factory ChatMetaModel({
    String? peerUserId,
    @Default(0) int totalPokes,
    @Default(0) int receivedCount,
    @Default(0) int sentCount,
    @Default(0) int pendingCount,
    ChatLatestPokeModel? latestPoke,
    @Default(false) bool hasStartedChat,
    ChatDirectChatMetaModel? directChat,
    String? groupId,
    String? receiverGroupId,
    @Default([]) List<String> receiverGroupIds,
    bool? isMatchedGroup,
    @Default(0) int matchCount,
    ChatGroupsDetailsModel? groupsDetails,
  }) = _ChatMetaModel;

  factory ChatMetaModel.fromJson(Map<String, dynamic> json) =>
      _$ChatMetaModelFromJson(json);
}

@freezed
abstract class ChatGroupsDetailsModel with _$ChatGroupsDetailsModel {
  const factory ChatGroupsDetailsModel({
    @Default([]) List<ChatGroupMemberUserModel> userGroupMembers,
    @Default([]) List<MatchedGroupMembersModel> matchedGroupMembers,
    ChatAboutGroupModel? aboutThisGroup,
    @Default([])
    List<SharedMediaModel> sharedMedia, // updated: was List<String>
    @Default([]) List<String> commonInterests,
    bool? isMatched,
  }) = _ChatGroupsDetailsModel;

  factory ChatGroupsDetailsModel.fromJson(Map<String, dynamic> json) =>
      _$ChatGroupsDetailsModelFromJson(json);
}

@freezed
abstract class MatchedGroupMembersModel with _$MatchedGroupMembersModel {
  const factory MatchedGroupMembersModel({
    String? groupId,
    @Default([]) List<ChatGroupMemberUserModel> members,
  }) = _MatchedGroupMembersModel;

  factory MatchedGroupMembersModel.fromJson(Map<String, dynamic> json) =>
      _$MatchedGroupMembersModelFromJson(json);
}

@freezed
abstract class ChatGroupMemberUserModel with _$ChatGroupMemberUserModel {
  const factory ChatGroupMemberUserModel({
    required String id,
    String? firstName,
    String? lastName,
    String? image,
  }) = _ChatGroupMemberUserModel;

  factory ChatGroupMemberUserModel.fromJson(Map<String, dynamic> json) =>
      _$ChatGroupMemberUserModelFromJson({
        ...json,
        'id': json['id'] ?? json['_id'] ?? '',
      });
}

@freezed
abstract class ChatAboutGroupModel with _$ChatAboutGroupModel {
  const factory ChatAboutGroupModel({
    String? title,
    String? bio,
    String? fitsForGroup,
  }) = _ChatAboutGroupModel;

  factory ChatAboutGroupModel.fromJson(Map<String, dynamic> json) =>
      _$ChatAboutGroupModelFromJson(json);
}

@freezed
abstract class ChatLatestPokeModel with _$ChatLatestPokeModel {
  const factory ChatLatestPokeModel({
    String? id,
    String? pokeId,
    String? fromUserId,
    String? toUserId,
    String? peerUserId,
    String? direction,
    String? status,
    String? targetType,
    String? targetId,
  }) = _ChatLatestPokeModel;

  factory ChatLatestPokeModel.fromJson(Map<String, dynamic> json) =>
      _$ChatLatestPokeModelFromJson({
        ...json,
        'id': json['id'] ?? json['_id'] ?? json['pokeId'] ?? '',
        'pokeId': json['pokeId'] ?? json['id'] ?? json['_id'] ?? '',
      });
}

@freezed
abstract class ChatDirectChatMetaModel with _$ChatDirectChatMetaModel {
  const factory ChatDirectChatMetaModel({
    String? otherUserId,
    @Default(0) int unreadCount,
    @JsonKey(
      fromJson: _dateTimeFromJsonNullable,
      toJson: _dateTimeToJsonNullable,
    )
    DateTime? lastMessageAt,
  }) = _ChatDirectChatMetaModel;

  factory ChatDirectChatMetaModel.fromJson(Map<String, dynamic> json) =>
      _$ChatDirectChatMetaModelFromJson(json);
}

// ─────────────────────────────────────────────
// MEMBER MODEL
// ─────────────────────────────────────────────

@freezed
abstract class MemberModel with _$MemberModel {
  const factory MemberModel({
    required String id,
    required String name,
    required String image,
  }) = _MemberModel;

  factory MemberModel.fromJson(Map<String, dynamic> json) =>
      _$MemberModelFromJson({...json, 'id': json['id'] ?? json['_id'] ?? ''});
}

// ─────────────────────────────────────────────
// CALL MODELS
// ─────────────────────────────────────────────

@freezed
abstract class CallUserInfo with _$CallUserInfo {
  const factory CallUserInfo({
    required String id,
    required String firstName,
    String? lastName,
    @Default([]) List<String> bestShorts,
  }) = _CallUserInfo;

  factory CallUserInfo.fromJson(Map<String, dynamic> json) =>
      _$CallUserInfoFromJson({...json, 'id': json['id'] ?? json['_id'] ?? ''});
}

@freezed
abstract class CallModel with _$CallModel {
  const factory CallModel({
    required String id,
    String? name,
    String? image,
    List<MemberModel>? members,
    String? callTypeLabel,
    String? duration,
    String? timeAgo,
    String? status,
    String? channelName,
    String? mediaType,
    String? callType,
    @JsonKey(
      fromJson: _dateTimeFromJsonNullable,
      toJson: _dateTimeToJsonNullable,
    )
    DateTime? startedAt,
    CallUserInfo? callerId,
    List<CallUserInfo>? participantIds,
  }) = _CallModel;

  factory CallModel.fromJson(Map<String, dynamic> json) =>
      _$CallModelFromJson({...json, 'id': json['id'] ?? json['_id'] ?? ''});
}

// ─────────────────────────────────────────────
// PAGINATION
// ─────────────────────────────────────────────

@freezed
abstract class PaginationModel with _$PaginationModel {
  const factory PaginationModel({
    required int page,
    required int limit,
    required int totalChats,
    required int totalCalls,
    @Default(0) int totalPokes, // new field
  }) = _PaginationModel;

  factory PaginationModel.fromJson(Map<String, dynamic> json) =>
      _$PaginationModelFromJson(json);
}

// ─────────────────────────────────────────────
// POKE DETAIL RESPONSE
// ─────────────────────────────────────────────

@freezed
abstract class PokeDetailResponse with _$PokeDetailResponse {
  const factory PokeDetailResponse({
    required bool success,
    required String message,
    required PokeDetailData data,
  }) = _PokeDetailResponse;

  factory PokeDetailResponse.fromJson(Map<String, dynamic> json) =>
      _$PokeDetailResponseFromJson(json);
}

@freezed
abstract class PokeDetailData with _$PokeDetailData {
  const factory PokeDetailData({
    required PokeModel poke,
    required PokerFromUser fromUser,
    required PokedTargetDetail pokedTargetDetail,
  }) = _PokeDetailData;

  factory PokeDetailData.fromJson(Map<String, dynamic> json) =>
      _$PokeDetailDataFromJson(json);
}

@freezed
abstract class PokeModel with _$PokeModel {
  const factory PokeModel({
    required String id,
    required String fromUserId,
    required String toUserId,
    required String targetType,
    String? targetId,
    required String message,
    required String status,
    @JsonKey(fromJson: _dateTimeFromJson, toJson: _dateTimeToJson)
    required DateTime createdAt,
    @JsonKey(fromJson: _dateTimeFromJson, toJson: _dateTimeToJson)
    required DateTime updatedAt,
  }) = _PokeModel;

  factory PokeModel.fromJson(Map<String, dynamic> json) =>
      _$PokeModelFromJson({...json, 'id': json['_id'] ?? json['id'] ?? ''});
}

@freezed
abstract class PokerFromUser with _$PokerFromUser {
  const factory PokerFromUser({
    required String id,
    required String firstName,
    String? lastName,
    required List<String> bestShorts,
  }) = _PokerFromUser;

  factory PokerFromUser.fromJson(Map<String, dynamic> json) =>
      _$PokerFromUserFromJson({...json, 'id': json['_id'] ?? json['id'] ?? ''});
}

@freezed
abstract class PokedTargetDetail with _$PokedTargetDetail {
  const factory PokedTargetDetail({
    required String type,
    PokePhotoDetail? photo,
    PokeAudioDetail? audio,
    PokedProfileDetail? profile,
    String? text,
  }) = _PokedTargetDetail;

  factory PokedTargetDetail.fromJson(Map<String, dynamic> json) =>
      _$PokedTargetDetailFromJson(json);
}

@freezed
abstract class PokedProfileDetail with _$PokedProfileDetail {
  const factory PokedProfileDetail({
    required String id,
    required String firstName,
    String? lastName,
    required List<String> bestShorts,
    String? shortBio,
    List<String>? lifestyleLikes,
  }) = _PokedProfileDetail;

  factory PokedProfileDetail.fromJson(Map<String, dynamic> json) =>
      _$PokedProfileDetailFromJson({
        ...json,
        'id': json['id'] ?? json['_id'] ?? '',
      });
}

@freezed
abstract class PokePhotoDetail with _$PokePhotoDetail {
  const factory PokePhotoDetail({required int index, required String url}) =
      _PokePhotoDetail;

  factory PokePhotoDetail.fromJson(Map<String, dynamic> json) =>
      _$PokePhotoDetailFromJson(json);
}

@freezed
abstract class PokeAudioDetail with _$PokeAudioDetail {
  const factory PokeAudioDetail({required String url}) = _PokeAudioDetail;

  factory PokeAudioDetail.fromJson(Map<String, dynamic> json) =>
      _$PokeAudioDetailFromJson(json);
}

// ─────────────────────────────────────────────
// POKE START CHAT
// ─────────────────────────────────────────────

@freezed
abstract class PokeStartChatResponse with _$PokeStartChatResponse {
  const factory PokeStartChatResponse({
    required bool success,
    required String message,
    required PokeStartChatData data,
  }) = _PokeStartChatResponse;

  factory PokeStartChatResponse.fromJson(Map<String, dynamic> json) =>
      _$PokeStartChatResponseFromJson(json);
}

@freezed
abstract class PokeStartChatData with _$PokeStartChatData {
  const factory PokeStartChatData({
    required PokeModel poke,
    required String chatWithUserId,
  }) = _PokeStartChatData;

  factory PokeStartChatData.fromJson(Map<String, dynamic> json) =>
      _$PokeStartChatDataFromJson(json);
}
