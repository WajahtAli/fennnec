abstract class LikedGroupsState {}

class LikedGroupsInitial extends LikedGroupsState {}

class LikedGroupsLoading extends LikedGroupsState {}

class LikedGroupsSuccess extends LikedGroupsState {}

class LikedGroupsError extends LikedGroupsState {
  final String message;
  LikedGroupsError(this.message);
}
