import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:in_app_purchase/in_app_purchase.dart';

class IAPService {
  static final InAppPurchase _inAppPurchase = InAppPurchase.instance;
  static late StreamSubscription<List<PurchaseDetails>> _subscription;

  static Completer<bool>? _purchaseCompleter;
  static Completer<bool>? _restoreCompleter;

  static Future<void> init() async {
    if (kIsWeb) return;

    final bool isAvailable = await _inAppPurchase.isAvailable();
    if (!isAvailable) {
      debugPrint('In-app purchases are not available');
      return;
    }

    final Stream<List<PurchaseDetails>> purchaseUpdated =
        _inAppPurchase.purchaseStream;
    _subscription = purchaseUpdated.listen(
      (List<PurchaseDetails> purchaseDetailsList) {
        _listenToPurchaseUpdated(purchaseDetailsList);
      },
      onDone: () {
        _subscription.cancel();
      },
      onError: (Object error) {
        if (_purchaseCompleter?.isCompleted == false) {
          _purchaseCompleter?.complete(false);
        }
        if (_restoreCompleter?.isCompleted == false) {
          _restoreCompleter?.complete(false);
        }
      },
    );
  }

  static Future<void> _listenToPurchaseUpdated(
    List<PurchaseDetails> purchaseDetailsList,
  ) async {
    for (var purchaseDetails in purchaseDetailsList) {
      if (purchaseDetails.status == PurchaseStatus.error) {
        debugPrint('Purchase error: \${purchaseDetails.error?.message}');
        if (_purchaseCompleter?.isCompleted == false) {
          _purchaseCompleter?.complete(false);
        }
      } else if (purchaseDetails.status == PurchaseStatus.purchased ||
          purchaseDetails.status == PurchaseStatus.restored) {
        if (_purchaseCompleter?.isCompleted == false) {
          _purchaseCompleter?.complete(true);
        }
        if (_restoreCompleter?.isCompleted == false) {
          _restoreCompleter?.complete(true);
        }
      }

      if (purchaseDetails.pendingCompletePurchase) {
        await _inAppPurchase.completePurchase(purchaseDetails);
      }
    }
  }

  static Future<bool> purchaseProduct(String productId) async {
    final ProductDetailsResponse response = await _inAppPurchase
        .queryProductDetails({productId});
    if (response.notFoundIDs.isNotEmpty || response.productDetails.isEmpty) {
      debugPrint('Product not found: $productId');
      return false;
    }

    _purchaseCompleter = Completer<bool>();
    final ProductDetails productDetails = response.productDetails.first;
    final PurchaseParam purchaseParam = PurchaseParam(
      productDetails: productDetails,
    );

    try {
      final success = await _inAppPurchase.buyNonConsumable(
        purchaseParam: purchaseParam,
      );
      if (!success) return false;
    } catch (e) {
      return false;
    }

    return _purchaseCompleter!.future;
  }

  static Future<bool> restorePurchases() async {
    _restoreCompleter = Completer<bool>();
    try {
      await _inAppPurchase.restorePurchases();
      return await _restoreCompleter!.future.timeout(
        const Duration(seconds: 5),
        onTimeout: () => false,
      );
    } catch (e) {
      if (_restoreCompleter?.isCompleted == false) {
        _restoreCompleter?.complete(false);
      }
      return false;
    }
  }

  static void dispose() {
    _subscription.cancel();
  }
}
