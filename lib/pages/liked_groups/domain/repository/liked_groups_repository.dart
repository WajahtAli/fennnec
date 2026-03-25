import 'package:fennac_app/pages/home/data/models/groups_model.dart';

abstract class LikedGroupsRepository {
  Future<GroupsModel> peopleWhoLikedMe();
}
