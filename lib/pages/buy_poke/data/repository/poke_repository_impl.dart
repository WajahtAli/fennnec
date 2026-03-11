import 'package:fennac_app/pages/buy_poke/data/datasource/poke_datasource.dart';
import 'package:fennac_app/pages/buy_poke/data/model/poke_model.dart';
import 'package:fennac_app/pages/buy_poke/domain/repository/poke_repository.dart';

class PokeRepositoryImpl extends PokeRepository {
  final PokeDatasource _datasource;

  PokeRepositoryImpl(this._datasource);

  @override
  Future<PockModel> fetchPokes() async {
    return await _datasource.fetchPokes();
  }

  @override
  Future<Map<String, dynamic>> sendPoke({
    required String toUserId,
    required String targetType,
    String? targetId,
    required String message,
  }) async {
    return await _datasource.sendPoke(
      toUserId: toUserId,
      targetType: targetType,
      targetId: targetId,
      message: message,
    );
  }
}
