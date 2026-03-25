import '../repository/liked_groups_repository.dart';
import 'package:fennac_app/pages/home/data/models/groups_model.dart';

class LikedGroupsUsecase {
  final LikedGroupsRepository repository;
  LikedGroupsUsecase(this.repository);

  Future<GroupsModel> peopleWhoLikedMe() {
    return repository.peopleWhoLikedMe();
  }
}
