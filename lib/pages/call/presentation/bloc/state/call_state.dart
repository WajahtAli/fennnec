import 'package:equatable/equatable.dart';

class CallState extends Equatable {
  @override
  List<Object?> get props => [];
}

class CallInitial extends CallState {}

class CallLoading extends CallState {}

class CallLoaded extends CallState {}

class CallError extends CallState {
  final String message;

  CallError(this.message);

  @override
  List<Object?> get props => [message];
}
