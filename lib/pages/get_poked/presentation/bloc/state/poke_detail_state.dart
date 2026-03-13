import 'package:equatable/equatable.dart';
import 'package:fennac_app/pages/chats/data/models/chat_and_calls_response.dart';

abstract class PokeDetailState extends Equatable {
  const PokeDetailState();

  @override
  List<Object?> get props => [];
}

class PokeDetailInitial extends PokeDetailState {}

class PokeDetailLoading extends PokeDetailState {}

class PokeDetailLoaded extends PokeDetailState {
  final PokeDetailResponse response;

  const PokeDetailLoaded(this.response);

  @override
  List<Object?> get props => [response];
}

class PokeDetailError extends PokeDetailState {
  final String message;

  const PokeDetailError(this.message);

  @override
  List<Object?> get props => [message];
}

class PokeStartChatLoading extends PokeDetailState {}

class PokeStartChatSuccess extends PokeDetailState {
  final PokeStartChatResponse response;

  const PokeStartChatSuccess(this.response);

  @override
  List<Object?> get props => [response];
}

class PokeStartChatError extends PokeDetailState {
  final String message;

  const PokeStartChatError(this.message);

  @override
  List<Object?> get props => [message];
}
