import 'package:fennac_app/pages/my_group/data/model/my_group_model.dart';
import '../../data/model/qr_member_model.dart';

abstract class FindGroupRepository {
  Future<MyGroupModel> fetchGroupByQr(String qrCode);
  Future<dynamic> joinGroupByQr(String qrCode);
  Future<QrMemberModel> fetchMemberByQr(String qrCode);
}
