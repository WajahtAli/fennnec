import '../repository/poke_repository.dart';

class SendPokeUseCase {
  final PokeRepository _pokeRepository;

  SendPokeUseCase(this._pokeRepository);

  Future<Map<String, dynamic>> call({
    required String toUserId,
    required String targetType,
    String? targetId,
    required String message,
  }) {
    return _pokeRepository.sendPoke(
      toUserId: toUserId,
      targetType: targetType,
      targetId: targetId,
      message: message,
    );
  }
}
