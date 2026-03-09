import 'package:fennac_app/pages/find_group/domain/repository/find_group_repository.dart';
import 'package:fennac_app/pages/find_group/data/datasource/find_group_datasource.dart';
import 'package:fennac_app/pages/my_group/data/model/my_group_model.dart';

class FindGroupRepositoryImpl extends FindGroupRepository {
  final FindGroupDatasource _datasource;

  FindGroupRepositoryImpl(this._datasource);

  @override
  Future<MyGroupModel> fetchGroupByQr(String qrCode) async {
    return await _datasource.fetchGroupByQr(qrCode);
  }

  @override
  Future<dynamic> joinGroupByQr(String qrCode) async {
    return await _datasource.joinGroupByQr(qrCode);
  }
}
