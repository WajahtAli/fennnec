import 'package:equatable/equatable.dart';
import 'package:fennac_app/pages/chats/data/models/chat_and_calls_response.dart';

class ChatLandingState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ChatLandingInitial extends ChatLandingState {}

class ChatLandingLoading extends ChatLandingState {}

class ChatLandingLoaded extends ChatLandingState {
  final ChatAndCallsResponse response;

  ChatLandingLoaded(this.response);

  @override
  List<Object?> get props => [response];
}

class ChatLandingError extends ChatLandingState {
  final String message;

  ChatLandingError(this.message);

  @override
  List<Object?> get props => [message];
}
