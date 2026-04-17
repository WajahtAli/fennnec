part of '../cubit/message_cubit.dart';

class MessageState extends Equatable {
  final List<MessageModel> messages;
  final bool isOtherUserTyping;

  const MessageState({
    this.messages = const [],
    this.isOtherUserTyping = false,
  });

  @override
  List<Object?> get props => [messages, isOtherUserTyping];
}

final class MessageInitial extends MessageState {
  const MessageInitial() : super(messages: const [], isOtherUserTyping: false);
}

final class MessageLoading extends MessageState {
  const MessageLoading({super.messages, super.isOtherUserTyping});
}

final class MessageSuccess extends MessageState {
  const MessageSuccess({super.messages, super.isOtherUserTyping});
}

final class MessageError extends MessageState {
  final String message;

  const MessageError(
    this.message, {
    super.messages,
    super.isOtherUserTyping,
  });

  @override
  List<Object?> get props => [message, messages, isOtherUserTyping];
}
