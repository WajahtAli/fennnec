import 'package:fennac_app/pages/buy_poke/data/model/poke_model.dart';
import 'package:fennac_app/pages/buy_poke/domain/usecase/fetch_pokes_usecase.dart';
import 'package:fennac_app/pages/buy_poke/presentation/bloc/state/poke_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PokeCubit extends Cubit<PokeState> {
  final FetchPokesUseCase fetchPokesUseCase;

  PokeCubit(this.fetchPokesUseCase) : super(PokeInitial());

  PockModel? pockModel;

  Future<void> fetchPokes() async {
    emit(PokeLoading());
    try {
      final response = await fetchPokesUseCase();
      if (response.success == true) {
        pockModel = response;
        emit(PokeLoaded());
      } else {
        emit(PokeError(response.message));
      }
    } catch (e) {
      emit(PokeError(e.toString()));
    }
  }
}
