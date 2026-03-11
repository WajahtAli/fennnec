import 'package:equatable/equatable.dart';

class HomeLandingState extends Equatable {
  @override
  List<Object?> get props => [];
}

class HomeLandingInitial extends HomeLandingState {}

class HomeLandingLoading extends HomeLandingState {}

class HomeLandingLoaded extends HomeLandingState {}

class HomeLandingError extends HomeLandingState {}

class AcceptDeclineInvitationLoading extends HomeLandingState {}

class AcceptDeclineInvitationSuccess extends HomeLandingState {
  final String message;
  AcceptDeclineInvitationSuccess(this.message);

  @override
  List<Object?> get props => [message];
}

class AcceptDeclineInvitationError extends HomeLandingState {
  final String message;
  AcceptDeclineInvitationError(this.message);

  @override
  List<Object?> get props => [message];
}
