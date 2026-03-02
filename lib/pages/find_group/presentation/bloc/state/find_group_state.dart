abstract class FindGroupState {}

class FindGroupInitial extends FindGroupState {}

class FindGroupLoading extends FindGroupState {}

class FindGroupLoaded extends FindGroupState {}

class FindGroupError extends FindGroupState {
  final String message;
  FindGroupError(this.message);
}
