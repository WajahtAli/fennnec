import 'package:fennac_app/app/constants/app_constants.dart';
import 'package:fennac_app/core/network/api_helper.dart';
import 'package:fennac_app/pages/buy_poke/data/model/poke_model.dart';

abstract class PokeDatasource {
  Future<PockModel> fetchPokes();
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
}
