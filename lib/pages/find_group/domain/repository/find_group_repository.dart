import 'package:fennac_app/pages/my_group/data/model/my_group_model.dart';

abstract class FindGroupRepository {
  Future<MyGroupModel> fetchGroupByQr(String qrCode);
}
