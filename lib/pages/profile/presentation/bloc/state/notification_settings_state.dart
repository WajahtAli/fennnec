import 'package:equatable/equatable.dart';

abstract class NotificationSettingsState extends Equatable {
  @override
  List<Object?> get props => [];
}

class NotificationSettingsInitial extends NotificationSettingsState {}

class NotificationSettingsLoading extends NotificationSettingsState {}

class NotificationSettingsLoaded extends NotificationSettingsState {}

class NotificationSettingsError extends NotificationSettingsState {
  final String message;

  NotificationSettingsError(this.message);

  @override
  List<Object?> get props => [message];
}
