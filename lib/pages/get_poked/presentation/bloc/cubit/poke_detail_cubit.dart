import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fennac_app/pages/chats/data/repository/chat_repository.dart';
import 'package:fennac_app/pages/get_poked/presentation/bloc/state/poke_detail_state.dart';

class PokeDetailCubit extends Cubit<PokeDetailState> {
  final ChatRepository _chatRepository;

  PokeDetailCubit(this._chatRepository) : super(PokeDetailInitial());

  Future<void> fetchPokeDetail(String pokeId) async {
    emit(PokeDetailLoading());
    try {
      final response = await _chatRepository.getPokeDetail(pokeId);
      emit(PokeDetailLoaded(response));
    } catch (e) {
      emit(PokeDetailError(e.toString()));
    }
  }

  Future<void> startChat(String pokeId) async {
    emit(PokeStartChatLoading());
    try {
      final response = await _chatRepository.startChat(pokeId);
      emit(PokeStartChatSuccess(response));
    } catch (e) {
      emit(PokeStartChatError(e.toString()));
    }
  }
}
