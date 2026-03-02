import '../../data/model/create_group_model.dart';
import '../../data/model/get_members_model.dart';
import '../repository/create_group_repository.dart';

class CreateGroupUsecase {
  final CreateGroupRepository _repository;

  CreateGroupUsecase(this._repository);

  Future<CreateGroupResponseModel> createGroup({
    required String title,
    required List<dynamic> members,
    required String bio,
    required String fitsForGroup,
    required Map<String, dynamic> groupSettings,
    required List<String> photosVideos,
  }) async {
    return await _repository.createGroup(
      title: title,
      members: members,
      bio: bio,
      fitsForGroup: fitsForGroup,
      groupSettings: groupSettings,
      photosVideos: photosVideos,
    );
  }

  Future<GetMembersModel> getAllMembers({
    required List<String> contacts,
  }) async {
    return await _repository.getAllMembers(contacts: contacts);
  }

  Future<dynamic> sendGroupInvite({
    String? email,
    String? phone,
    String? groupId,
  }) async {
    return await _repository.sendGroupInvite(
      email: email,
      phone: phone,
      groupId: groupId,
    );
  }
}
