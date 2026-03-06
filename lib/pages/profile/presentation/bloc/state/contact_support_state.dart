import 'package:equatable/equatable.dart';

abstract class ContactSupportState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ContactSupportInitial extends ContactSupportState {}

class ContactSupportLoading extends ContactSupportState {}

class ContactSupportSuccess extends ContactSupportState {
  final String message;

  ContactSupportSuccess(this.message);

  @override
  List<Object?> get props => [message];
}

class ContactSupportError extends ContactSupportState {
  final String error;

  ContactSupportError(this.error);

  @override
  List<Object?> get props => [error];
}
