import '../repository/poke_repository.dart';

class SendPokeUseCase {
  final PokeRepository _pokeRepository;

  SendPokeUseCase(this._pokeRepository);

  Future<Map<String, dynamic>> call({required String toUserId}) {
    return _pokeRepository.sendPoke(toUserId: toUserId);
  }
}
