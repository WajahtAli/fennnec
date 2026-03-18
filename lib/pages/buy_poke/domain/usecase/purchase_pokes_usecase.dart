import '../repository/poke_repository.dart';

class PurchaseSubscriptionUseCase {
  final PokeRepository _pokeRepository;

  PurchaseSubscriptionUseCase(this._pokeRepository);

  Future<Map<String, dynamic>> call({required String productId}) {
    return _pokeRepository.purchaseSubscription(productId: productId);
  }
}

class PurchasePokesUseCase {
  final PokeRepository _pokeRepository;

  PurchasePokesUseCase(this._pokeRepository);

  Future<Map<String, dynamic>> call({required String productId}) {
    return _pokeRepository.purchasePokes(productId: productId);
  }
}
