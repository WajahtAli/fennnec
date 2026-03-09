import 'package:fennac_app/pages/find_group/domain/repository/find_group_repository.dart';
import 'package:fennac_app/pages/my_group/data/model/my_group_model.dart';
import '../../data/model/qr_member_model.dart';

class FindGroupUsecase {
  final FindGroupRepository _repository;

  FindGroupUsecase(this._repository);

  Future<MyGroupModel> fetchGroupByQr(String qrCode) async {
    return await _repository.fetchGroupByQr(qrCode);
  }

  Future<dynamic> joinGroupByQr(String qrCode) async {
    return await _repository.joinGroupByQr(qrCode);
  }

  Future<QrMemberModel> fetchMemberByQr(String qrCode) async {
    return await _repository.fetchMemberByQr(qrCode);
  }
}
