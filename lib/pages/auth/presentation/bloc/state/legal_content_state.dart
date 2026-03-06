import 'package:equatable/equatable.dart';

class LegalContentState extends Equatable {
  @override
  List<Object?> get props => [];
}

class LegalContentInitial extends LegalContentState {}

class LegalContentLoading extends LegalContentState {}

class LegalContentLoaded extends LegalContentState {}

class LegalContentError extends LegalContentState {
  final String message;

  LegalContentError(this.message);

  @override
  List<Object?> get props => [message];
}
