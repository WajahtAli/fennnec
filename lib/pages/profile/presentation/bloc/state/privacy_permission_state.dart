import 'package:equatable/equatable.dart';

abstract class PrivacyPermissionState extends Equatable {
  @override
  List<Object?> get props => [];
}

class PrivacyPermissionInitial extends PrivacyPermissionState {}

class PrivacyPermissionLoading extends PrivacyPermissionState {}

class PrivacyPermissionLoaded extends PrivacyPermissionState {}

class PrivacyPermissionError extends PrivacyPermissionState {
  final String message;

  PrivacyPermissionError(this.message);

  @override
  List<Object?> get props => [message];
}
