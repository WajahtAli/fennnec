import '../../data/model/my_group_model.dart';
import '../repository/my_group_repository.dart';

class MyGroupUsecase {
  final MyGroupRepository _repository;

  MyGroupUsecase(this._repository);

  Future<MyGroupModel> fetchGroupById(String groupId) async {
    return await _repository.fetchGroupById(groupId);
  }

  Future<MyGroupModel> updateGroupById(
    String groupId,
    Map<String, dynamic> body,
  ) async {
    return await _repository.updateGroupById(groupId, body);
  }
}
