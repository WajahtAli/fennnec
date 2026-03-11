import 'package:fennac_app/pages/buy_poke/data/model/poke_model.dart';

abstract class PokeRepository {
  Future<PockModel> fetchPokes();
  Future<Map<String, dynamic>> sendPoke({
    required String toUserId,
    required String targetType,
    String? targetId,
    required String message,
  });
}
