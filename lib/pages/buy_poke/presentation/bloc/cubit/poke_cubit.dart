import 'package:fennac_app/generated/assets.gen.dart';
import 'package:fennac_app/pages/buy_poke/data/model/poke_model.dart';
import 'package:fennac_app/pages/buy_poke/domain/usecase/fetch_pokes_usecase.dart';
import 'package:fennac_app/pages/buy_poke/domain/usecase/purchase_pokes_usecase.dart';
import 'package:fennac_app/helpers/gradient_toast.dart';
import 'package:fennac_app/pages/buy_poke/presentation/bloc/state/poke_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PokeCubit extends Cubit<PokeState> {
  PurchaseSubscriptionUseCase? purchaseSubscriptionUseCase;
  bool isSubscriptionPurchasing = false;

  final FetchPokesUseCase fetchPokesUseCase;
  final PurchasePokesUseCase purchasePokesUseCase;

  PokeCubit(this.fetchPokesUseCase, this.purchasePokesUseCase)
    : super(PokeInitial());

  PockModel? pockModel;
  bool isPurchasing = false;
  String? purchasingProductId;

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

  Future<void> purchaseSubscription(String productId) async {
    isSubscriptionPurchasing = true;
    emit(PokeLoading());
    try {
      final response = await purchaseSubscriptionUseCase?.call(
        productId: productId,
      );
      final message = response?['message'] ?? 'Subscription purchased';
      VxToast.show(message: message, icon: Assets.icons.checkGreen.path);
    } catch (e) {
      VxToast.show(message: 'Subscription failed: \\${e.toString()}');
      emit(PokeError(e.toString()));
    }
    isSubscriptionPurchasing = false;
  }

  Future<void> purchasePokes(String productId) async {
    isPurchasing = true;
    purchasingProductId = productId;
    emit(PokeLoading());
    try {
      final response = await purchasePokesUseCase(productId: productId);
      final message = response['message'] ?? 'Purchase completed';
      VxToast.show(message: message);
      // Optionally refresh pokes after purchase
      await fetchPokes();
    } catch (e) {
      VxToast.show(message: 'Purchase failed: \${e.toString()}');
      emit(PokeError(e.toString()));
    }
    isPurchasing = false;
    purchasingProductId = null;
  }
}
