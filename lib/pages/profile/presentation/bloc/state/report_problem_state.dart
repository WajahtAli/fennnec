import 'package:equatable/equatable.dart';

abstract class ReportProblemState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ReportProblemInitial extends ReportProblemState {}

class ReportProblemLoading extends ReportProblemState {}

class ReportProblemSuccess extends ReportProblemState {
  final String message;

  ReportProblemSuccess(this.message);

  @override
  List<Object?> get props => [message];
}

class ReportProblemError extends ReportProblemState {
  final String error;

  ReportProblemError(this.error);

  @override
  List<Object?> get props => [error];
}
