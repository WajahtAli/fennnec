import 'package:fennac_app/pages/chats/data/models/message_type_enum.dart';
import 'package:fennac_app/pages/chats/data/models/reaction_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'message_model.freezed.dart';
part 'message_model.g.dart';

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

  factory MessageModel.fromJson(Map<String, dynamic> json) =>
      _$MessageModelFromJson(json);
}
