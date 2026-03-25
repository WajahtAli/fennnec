import '../../domain/repository/liked_groups_repository.dart';
import '../datasource/liked_groups_datasource.dart';
import 'package:fennac_app/pages/home/data/models/groups_model.dart';

class LikedGroupsRepositoryImpl extends LikedGroupsRepository {
  final LikedGroupsDataSource dataSource;
  LikedGroupsRepositoryImpl(this.dataSource);

  @override
  Future<GroupsModel> peopleWhoLikedMe() {
    return dataSource.peopleWhoLikedMe();
  }
}
