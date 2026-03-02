import 'package:equatable/equatable.dart';

class PokeState extends Equatable {
  @override
  List<Object?> get props => [];
}

class PokeInitial extends PokeState {}

class PokeLoading extends PokeState {}

class PokeLoaded extends PokeState {}

class PokeError extends PokeState {
  final String? message;

  PokeError([this.message]);

  @override
  List<Object?> get props => [message];
}
