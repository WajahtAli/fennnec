import 'dart:developer';

import 'package:fennac_app/core/di_container.dart';
import 'package:fennac_app/generated/assets.gen.dart';
import 'package:fennac_app/pages/auth/presentation/bloc/cubit/login_cubit.dart';
import 'package:fennac_app/pages/auth/presentation/bloc/cubit/create_account_cubit.dart';
import 'package:fennac_app/pages/buy_poke/data/model/poke_model.dart';
import 'package:fennac_app/pages/buy_poke/domain/usecase/fetch_pokes_usecase.dart';
import 'package:fennac_app/pages/buy_poke/domain/usecase/purchase_pokes_usecase.dart';
import 'package:fennac_app/helpers/gradient_toast.dart';
import 'package:fennac_app/pages/buy_poke/domain/usecase/send_poke_usecase.dart';
import 'package:fennac_app/pages/buy_poke/presentation/bloc/state/poke_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fennac_app/pages/buy_poke/data/datasource/iap_service.dart';

class PokeCubit extends Cubit<PokeState> {
  final PurchaseSubscriptionUseCase purchaseSubscriptionUseCase;
  final CancelSubscriptionUseCase cancelSubscriptionUseCase;
  final SendPokeUseCase _sendPokeUseCase;

  bool isSubscriptionPurchasing = false;

  final FetchPokesUseCase fetchPokesUseCase;
  final PurchasePokesUseCase purchasePokesUseCase;

  PokeCubit(
    this.fetchPokesUseCase,
    this.purchasePokesUseCase,
    this.purchaseSubscriptionUseCase,
    this.cancelSubscriptionUseCase,
    this._sendPokeUseCase,
  ) : super(PokeInitial());

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
      final response = await purchaseSubscriptionUseCase.call(
        productId: productId,
      );
      log('Subscription purchase response: ${response.toString()}');
      if (response['success'] == true) {
        final message =
            response['message'] ?? 'Subscription purchased successfully';
        final data = response['data'] as Map<String, dynamic>?;
        final isActive = data?['subscriptionActive'] == true;

        if (isActive) {
          Di().sl<CreateAccountCubit>().updateProfile();
          isSubscriptionPurchasing = false;
          VxToast.show(message: message, icon: Assets.icons.checkGreen.path);
          emit(PokeLoaded());
        } else {
          isSubscriptionPurchasing = false;
          VxToast.show(message: 'Subscription not activated');
          emit(PokeError('Subscription not activated'));
        }
      } else {
        final message = response['message'] ?? 'Subscription failed';
        VxToast.show(message: message);
        isSubscriptionPurchasing = false;
        emit(PokeError(message));
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
        await purchaseSubscriptionUseCase.call(productId: 'monthly');
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

  Future<void> cancelSubscription({required String userId}) async {
    if (userId.trim().isEmpty) {
      VxToast.show(message: 'Unable to cancel subscription right now.');
      emit(PokeError('User id is missing'));
      return;
    }

    isSubscriptionPurchasing = true;
    emit(PokeLoading());
    try {
      final response = await cancelSubscriptionUseCase.call(userId: userId);
      final message =
          response['message']?.toString() ??
          'Subscription canceled successfully';
      if (response['success'] != true) {
        VxToast.show(message: message);
        emit(PokeError(message));
        isSubscriptionPurchasing = false;
        return;
      }

      final data = response['data'] is Map<String, dynamic>
          ? Map<String, dynamic>.from(response['data'])
          : <String, dynamic>{};

      final loginCubit = Di().sl<LoginCubit>();
      final currentUser = loginCubit.userData?.user;
      if (currentUser != null) {
        loginCubit.updateUserFromProfileModel(
          currentUser.copyWith(
            subscriptionActive: data['subscriptionActive'] == true,
            subscriptionExpiresAt: data['subscriptionExpiresAt']?.toString(),
          ),
        );
      }

      VxToast.show(message: message, icon: Assets.icons.checkGreen.path);
      emit(PokeLoaded());
    } catch (e) {
      final message = e.toString().replaceFirst('Exception: ', '').trim();
      VxToast.show(
        message: message.isNotEmpty ? message : 'Failed to cancel subscription',
      );
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

  // ========== SEND POKE METHOD ==========
  Future<void> sendPoke({
    required String toUserId,
    required String targetType,
    String? targetId,
    required String message,
  }) async {
    emit(PokeLoading());
    try {
      final response = await _sendPokeUseCase(
        toUserId: toUserId,
        targetType: targetType,
        targetId: targetId,
        message: message,
      );
      log('Poke sent successfully: $response');
      VxToast.show(message: response['message'] ?? 'Poke sent successfully');
      emit(PokeLoaded());
    } catch (e) {
      log('Error sending poke: $e');
      VxToast.show(message: 'Failed to send poke');
      emit(PokeError(e.toString()));
      rethrow;
    }
  }
}
