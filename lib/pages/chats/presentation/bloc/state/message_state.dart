part of '../cubit/message_cubit.dart';

class MessageState extends Equatable {
  final List<MessageModel> messages;

  const MessageState({this.messages = const []});

  @override
  List<Object?> get props => [messages];
}

final class MessageInitial extends MessageState {
  const MessageInitial() : super(messages: const []);
}

final class MessageLoading extends MessageState {
  const MessageLoading({super.messages});
}

final class MessageSuccess extends MessageState {
  const MessageSuccess({super.messages});
}

final class MessageError extends MessageState {
  final String message;

  const MessageError(this.message, {super.messages});

  @override
  List<Object?> get props => [message, messages];
}
