abstract class GroupsState {}

class GroupsInitial extends GroupsState {}

class GroupsLoading extends GroupsState {}

class GroupsSuccess extends GroupsState {}

class GroupsError extends GroupsState {
  final String message;
  GroupsError(this.message);
}
