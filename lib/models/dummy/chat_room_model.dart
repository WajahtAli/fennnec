import 'package:freezed_annotation/freezed_annotation.dart';

part 'chat_room_model.freezed.dart';
part 'chat_room_model.g.dart';

@freezed
abstract class ChatRoom with _$ChatRoom {
  const factory ChatRoom({
    required String id,
    required String message,
    required String timeAgo,
    required bool isGroup,
    // For individual chats
    String? name,
    String? avatar,
    @Default(false) bool isOnline,
    @Default(false) bool isPoked,
    // For group chats
    List<String>? names,
    List<String>? avatars,
  }) = _ChatRoom;

  factory ChatRoom.fromJson(Map<String, dynamic> json) =>
      _$ChatRoomFromJson(json);
}
