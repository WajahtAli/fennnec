import 'package:fennac_app/pages/buy_poke/data/model/poke_model.dart';

abstract class PokeRepository {
  Future<PockModel> fetchPokes();
}
