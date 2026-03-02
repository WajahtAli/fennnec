import 'package:equatable/equatable.dart';

abstract class ContactListState extends Equatable {
  const ContactListState();
  @override
  List<Object?> get props => [];
}

class ContactListInitial extends ContactListState {}

class ContactListLoading extends ContactListState {}

class ContactListLoaded extends ContactListState {}

class ContactListPermissionDenied extends ContactListState {}

class ContactListPermissionPermanentlyDenied extends ContactListState {}

class ContactListError extends ContactListState {
  final String message;
  const ContactListError(this.message);
  @override
  List<Object?> get props => [message];
}
