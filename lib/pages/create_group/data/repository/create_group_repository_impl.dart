import '../../domain/repository/create_group_repository.dart';
import '../datasource/create_group_datasource.dart';
import '../model/create_group_model.dart';
import '../model/get_members_model.dart';

class CreateGroupRepositoryImpl extends CreateGroupRepository {
  final CreateGroupDatasource _datasource;

  CreateGroupRepositoryImpl(this._datasource);

  @override
  Future<CreateGroupResponseModel> createGroup({
    required String title,
    required List<dynamic> members,
    required String bio,
    required String fitsForGroup,
    required Map<String, dynamic> groupSettings,
    required List<String> photosVideos,
  }) async {
    return await _datasource.createGroup(
      title: title,
      members: members,
      bio: bio,
      fitsForGroup: fitsForGroup,
      groupSettings: groupSettings,
      photosVideos: photosVideos,
    );
  }

  @override
  Future<GetMembersModel> getAllMembers({
    required List<String> contacts,
  }) async {
    return await _datasource.getAllMembers(contacts: contacts);
  }

  @override
  Future<dynamic> sendGroupInvite({
    String? email,
    String? phone,
    String? groupId,
  }) async {
    return await _datasource.sendGroupInvite(
      email: email,
      phone: phone,
      groupId: groupId,
    );
  }
}
