import 'package:freezed_annotation/freezed_annotation.dart';

part 'chat_and_calls_response.freezed.dart';
part 'chat_and_calls_response.g.dart';

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
    @Default([]) List<MemberModel> members, // added
    required PaginationModel pagination,
  }) = _ChatAndCallsData;

  factory ChatAndCallsData.fromJson(Map<String, dynamic> json) =>
      _$ChatAndCallsDataFromJson(json);
}

@freezed
abstract class ChatModel with _$ChatModel {
  const factory ChatModel({
    required String type,
    required String id,
    required String name,
    @Default('') String image,
    @Default('') String lastMessage,
    DateTime? lastMessageAt,
    required int unreadCount,
    required Map<String, dynamic> meta,
    List<MemberModel>? members,
  }) = _ChatModel;

  factory ChatModel.fromJson(Map<String, dynamic> json) =>
      _$ChatModelFromJson(json);
}

@freezed
abstract class MemberModel with _$MemberModel {
  const factory MemberModel({
    required String id,
    required String name,
    required String image,
  }) = _MemberModel;

  factory MemberModel.fromJson(Map<String, dynamic> json) =>
      _$MemberModelFromJson(json);
}

@freezed
abstract class CallUserInfo with _$CallUserInfo {
  const factory CallUserInfo({
    @JsonKey(name: '_id') required String id,
    required String firstName,
    String? lastName,
    @Default([]) List<String> bestShorts,
  }) = _CallUserInfo;

  factory CallUserInfo.fromJson(Map<String, dynamic> json) =>
      _$CallUserInfoFromJson(json);
}

@freezed
abstract class CallModel with _$CallModel {
  const factory CallModel({
    @JsonKey(name: '_id') required String id,
    String? name,
    String? image,
    List<MemberModel>? members,
    String? callTypeLabel,
    String? duration,
    String? timeAgo,
    String? status,
    String? channelName, // added
    String? mediaType, // added
    String? callType, // added
    DateTime? startedAt, // added
    CallUserInfo? callerId, // added
    List<CallUserInfo>? participantIds, // added
  }) = _CallModel;

  factory CallModel.fromJson(Map<String, dynamic> json) =>
      _$CallModelFromJson(json);
}

@freezed
abstract class PaginationModel with _$PaginationModel {
  const factory PaginationModel({
    required int page,
    required int limit,
    required int totalChats,
    required int totalCalls,
  }) = _PaginationModel;

  factory PaginationModel.fromJson(Map<String, dynamic> json) =>
      _$PaginationModelFromJson(json);
}

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
    required DateTime createdAt,
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
    @JsonKey(name: '_id') required String id,
    required String firstName,
    String? lastName,
    required List<String> bestShorts,
    String? shortBio,
    List<String>? lifestyleLikes,
  }) = _PokedProfileDetail;

  factory PokedProfileDetail.fromJson(Map<String, dynamic> json) =>
      _$PokedProfileDetailFromJson(json);
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
