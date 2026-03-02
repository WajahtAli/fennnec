part of '../cubit/update_profile_cubit.dart';

class UpdateProfileState extends Equatable {
  const UpdateProfileState();

  @override
  List<Object?> get props => [];
}

class UpdateProfileStateLoading extends UpdateProfileState {
  const UpdateProfileStateLoading();
}

class UpdateProfileStateSuccess extends UpdateProfileState {
  const UpdateProfileStateSuccess();
}

class UpdateProfileStateError extends UpdateProfileState {
  const UpdateProfileStateError();
}
