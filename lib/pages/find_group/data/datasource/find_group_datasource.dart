import 'package:fennac_app/app/constants/app_constants.dart';
import 'package:fennac_app/core/network/api_helper.dart';
import 'package:fennac_app/pages/my_group/data/model/my_group_model.dart';

abstract class FindGroupDatasource {
  Future<MyGroupModel> fetchGroupByQr(String qrCode);
  Future<dynamic> joinGroupByQr(String qrCode);
}

class FindGroupDatasourceImpl extends FindGroupDatasource {
  final ApiHelper apiHelper;

  FindGroupDatasourceImpl(this.apiHelper);

  @override
  Future<MyGroupModel> fetchGroupByQr(String qrCode) async {
    try {
      final response = await apiHelper.get(
        '${AppConstants.groupByQr}/$qrCode',
        requiresAuth: true,
      );
      return MyGroupModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<dynamic> joinGroupByQr(String qrCode) async {
    try {
      final response = await apiHelper.post(
        '${AppConstants.groupByQr}/$qrCode/join',
        requiresAuth: true,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
