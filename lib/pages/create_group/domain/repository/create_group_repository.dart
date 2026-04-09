import '../../../my_group/data/model/my_group_model.dart';
import '../../data/model/create_group_model.dart';
import '../../data/model/get_members_model.dart';

abstract class CreateGroupRepository {
  Future<CreateGroupResponseModel> createGroup({
    required String title,
    required List<dynamic> members,
    required String bio,
    required String fitsForGroup,
    required Map<String, dynamic> groupSettings,
    required List<String> photosVideos,
    required GroupLocation location,
  });

  Future<GetMembersModel> getAllMembers({required List<String> contacts});

  Future<dynamic> sendGroupInvite({
    String? email,
    String? phone,
    String? groupId,
  });
}
