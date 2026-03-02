import 'package:equatable/equatable.dart';

abstract class CreateGroupState extends Equatable {
  const CreateGroupState();
  @override
  List<Object?> get props => [];
}

class CreateGroupInitial extends CreateGroupState {}

class CreateGroupLoading extends CreateGroupState {}

class CreateGroupLoaded extends CreateGroupState {}

class CreateGroupPermissionDenied extends CreateGroupState {}

class CreateGroupPermissionPermanentlyDenied extends CreateGroupState {}

class CreateGroupError extends CreateGroupState {
  final String message;
  const CreateGroupError(this.message);
  @override
  List<Object?> get props => [message];
}

class CreateGroupSuccess extends CreateGroupState {}
