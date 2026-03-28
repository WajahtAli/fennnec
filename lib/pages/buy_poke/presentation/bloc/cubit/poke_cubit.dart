import 'dart:math';

import 'package:fennac_app/core/di_container.dart';
import 'package:fennac_app/generated/assets.gen.dart';
import 'package:fennac_app/pages/auth/presentation/bloc/cubit/create_account_cubit.dart';
import 'package:fennac_app/pages/buy_poke/data/model/poke_model.dart';
import 'package:fennac_app/pages/buy_poke/domain/usecase/fetch_pokes_usecase.dart';
import 'package:fennac_app/pages/buy_poke/domain/usecase/purchase_pokes_usecase.dart';
import 'package:fennac_app/helpers/gradient_toast.dart';
import 'package:fennac_app/pages/buy_poke/presentation/bloc/state/poke_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fennac_app/pages/buy_poke/data/datasource/iap_service.dart';

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
      final isSuccess = await IAPService.purchaseProduct(productId);
      if (isSuccess) {
        final response = await purchaseSubscriptionUseCase?.call(
          productId: productId,
        );
        final message = response?['message'] ?? 'Subscription purchased';
        VxToast.show(message: message, icon: Assets.icons.checkGreen.path);
        emit(PokeLoaded());
      } else {
        VxToast.show(message: 'Purchase cancelled or failed');
        emit(PokeError('Purchase cancelled or failed'));
      }
    } catch (e) {
      VxToast.show(message: 'Subscription failed.');
      emit(PokeError(e.toString()));
    }
    isSubscriptionPurchasing = false;
  }

  Future<void> restorePurchases() async {
    isSubscriptionPurchasing = true;
    emit(PokeLoading());
    try {
      final isSuccess = await IAPService.restorePurchases();
      if (isSuccess) {
        // Assume restoring also gives premium monthly for now.
        await purchaseSubscriptionUseCase?.call(productId: 'monthly');
        VxToast.show(
          message: 'Purchases restored successfully',
          icon: Assets.icons.checkGreen.path,
        );
        emit(PokeLoaded());
      } else {
        VxToast.show(message: 'No active subscriptions found');
        emit(PokeError('No active subscriptions found'));
      }
    } catch (e) {
      VxToast.show(message: 'Failed to restore purchases');
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
      await Di().sl<CreateAccountCubit>().updateProfile();
      await fetchPokes();
      VxToast.show(message: message, icon: Assets.icons.checkGreen.path);
      emit(PokeLoaded());
    } catch (e) {
      VxToast.show(message: 'Purchase failed: \${e.toString()}');
      emit(PokeError(e.toString()));
    }
    isPurchasing = false;
    purchasingProductId = null;
  }
}
