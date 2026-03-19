import 'package:equatable/equatable.dart';
import 'package:fennac_app/pages/chats/data/models/chat_and_calls_response.dart';

abstract class GetPokedDetailsState extends Equatable {
  const GetPokedDetailsState();

  @override
  List<Object?> get props => [];
}

class GetPokedDetailsInitial extends GetPokedDetailsState {}

class GetPokedDetailsLoading extends GetPokedDetailsState {}

class GetPokedDetailsLoaded extends GetPokedDetailsState {
  final PokeDetailData pokeDetail;

  const GetPokedDetailsLoaded(this.pokeDetail);

  @override
  List<Object?> get props => [pokeDetail];
}

class GetPokedDetailsError extends GetPokedDetailsState {
  final String message;

  const GetPokedDetailsError(this.message);

  @override
  List<Object?> get props => [message];
}

class GetPokedDetailsChatStarted extends GetPokedDetailsState {
  final PokeStartChatData startChatData;

  const GetPokedDetailsChatStarted(this.startChatData);

  @override
  List<Object?> get props => [startChatData];
}
