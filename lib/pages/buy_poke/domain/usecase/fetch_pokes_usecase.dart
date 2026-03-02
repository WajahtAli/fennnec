import 'package:fennac_app/pages/buy_poke/data/model/poke_model.dart';
import 'package:fennac_app/pages/buy_poke/domain/repository/poke_repository.dart';

class FetchPokesUseCase {
  final PokeRepository repository;

  FetchPokesUseCase(this.repository);

  Future<PockModel> call() async {
    return await repository.fetchPokes();
  }
}
