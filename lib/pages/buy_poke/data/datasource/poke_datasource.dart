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
}

class PokeDatasourceImpl extends PokeDatasource {
  final ApiHelper apiHelper;

  PokeDatasourceImpl(this.apiHelper);

  @override
  Future<PockModel> fetchPokes() async {
    final response = await apiHelper.get(
      AppConstants.fetchPokeProducts,
      requiresAuth: true,
    );
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
}
