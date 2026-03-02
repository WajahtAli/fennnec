import 'package:equatable/equatable.dart';

class CreateAccountState extends Equatable {
  @override
  List<Object?> get props => [];
}

class CreateAccountInitial extends CreateAccountState {}

class CreateAccountLoading extends CreateAccountState {}

class CreateAccountLoaded extends CreateAccountState {}

class CreateAccountError extends CreateAccountState {
  final String message;
  CreateAccountError(this.message);
}
