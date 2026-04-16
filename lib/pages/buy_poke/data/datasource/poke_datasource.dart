import 'package:fennac_app/app/constants/app_constants.dart';
import 'package:fennac_app/core/network/api_helper.dart';
import 'package:fennac_app/pages/buy_poke/data/model/poke_model.dart';

abstract class PokeDatasource {
  Future<PockModel> fetchPokes();
  Future<Map<String, dynamic>> sendPoke({
    required String toUserId,
    required String targetType,
    String? targetId,
    required String message,
  });

  Future<Map<String, dynamic>> purchasePokes({required String productId});
  Future<Map<String, dynamic>> purchaseSubscription({
    required String productId,
  });
  Future<Map<String, dynamic>> cancelSubscription({required String userId});
}

class PokeDatasourceImpl extends PokeDatasource {
  @override
  Future<Map<String, dynamic>> cancelSubscription({
    required String userId,
  }) async {
    final body = <String, dynamic>{'userId': userId};
    final response = await apiHelper.post(
      AppConstants.cancelSubscription,
      body: body,
      requiresAuth: true,
    );
    return response;
  }

  @override
  Future<Map<String, dynamic>> purchaseSubscription({
    required String productId,
  }) async {
    final body = <String, dynamic>{'productId': productId};
    final response = await apiHelper.post(
      'subscription/purchase',
      body: body,
      requiresAuth: true,
    );
    return response;
  }

  final ApiHelper apiHelper;

  PokeDatasourceImpl(this.apiHelper);

  @override
  Future<PockModel> fetchPokes() async {
    final response = await apiHelper.get(
      AppConstants.fetchPokeProducts,
      requiresAuth: true,
    );
    {}
    return PockModel.fromJson(response);
  }

  @override
  Future<Map<String, dynamic>> sendPoke({
    required String toUserId,
    required String targetType,
    String? targetId,
    required String message,
  }) async {
    final body = <String, dynamic>{
      'toUserId': toUserId,
      'targetType': targetType,
      'message': message,
    };

    if (targetId != null && targetId.isNotEmpty) {
      body['targetId'] = targetId;
    }

    final response = await apiHelper.post(
      AppConstants.sendPoke,
      body: body,
      requiresAuth: true,
    );
    return response;
  }

  @override
  Future<Map<String, dynamic>> purchasePokes({
    required String productId,
  }) async {
    final body = <String, dynamic>{'productId': productId};
    final response = await apiHelper.post(
      'pokes/purchase',
      body: body,
      requiresAuth: true,
    );
    return response;
  }
}
