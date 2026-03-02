import 'package:freezed_annotation/freezed_annotation.dart';

part 'chat_message_model.freezed.dart';
part 'chat_message_model.g.dart';

@freezed
abstract class ChatMessage with _$ChatMessage {
  const factory ChatMessage({
    required String id,
    required String name,
    String? avatar,
    String? text,
    required String type,
    @Default([]) List<String> images,
    String? duration,
    String? mentionedUser,
    required bool isMe,
    @Default(false) bool isMyGroup,
    @Default({}) Map<String, List<String>> reactions,
  }) = _ChatMessage;

  factory ChatMessage.fromJson(Map<String, dynamic> json) =>
      _$ChatMessageFromJson(json);
}
