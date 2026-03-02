abstract class MyGroupState {}

class MyGroupInitial extends MyGroupState {}

class MyGroupLoading extends MyGroupState {}

class MyGroupLoaded extends MyGroupState {}

class MyGroupError extends MyGroupState {
  final String message;
  MyGroupError(this.message);
}
