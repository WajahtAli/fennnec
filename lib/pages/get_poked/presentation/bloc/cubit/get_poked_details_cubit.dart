import 'package:fennac_app/pages/chats/data/repository/chat_repository.dart';
import 'package:fennac_app/pages/get_poked/presentation/bloc/state/get_poked_details_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GetPokedDetailsCubit extends Cubit<GetPokedDetailsState> {
  final ChatRepository _chatRepository;

  GetPokedDetailsCubit(this._chatRepository) : super(GetPokedDetailsInitial());

  Future<void> fetchPokeDetail(String pokeId) async {
    emit(GetPokedDetailsLoading());
    try {
      final response = await _chatRepository.getPokeDetail(pokeId);
      if (response.success) {
        emit(GetPokedDetailsLoaded(response.data));
      } else {
        emit(GetPokedDetailsError(response.message));
      }
    } catch (e) {
      emit(GetPokedDetailsError(e.toString()));
    }
  }

  Future<void> startChat(String pokeId) async {
    try {
      final response = await _chatRepository.startChat(pokeId);
      if (response.success) {
        emit(GetPokedDetailsChatStarted(response.data));
      } else {
        emit(GetPokedDetailsError(response.message));
      }
    } catch (e) {
      emit(GetPokedDetailsError(e.toString()));
    }
  }
}
