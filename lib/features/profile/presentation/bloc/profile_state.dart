// profile_state.dart

import '../../../auths/domain/entities/user_entity.dart';

abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileLoaded extends ProfileState {
  final UserEntity user;

  ProfileLoaded(this.user);
}

class ProfileUpdateInProgress extends ProfileState {}

class ProfileUpdateSuccess extends ProfileState {
  final UserEntity updatedUser;

  ProfileUpdateSuccess(this.updatedUser);
}

class ProfileUpdateFailure extends ProfileState {
  final String error;

  ProfileUpdateFailure(this.error);
}

class ProfileError extends ProfileState {
  final String message;

  ProfileError(this.message);
}

class ProfileImageUpdateInProgress extends ProfileState {}

class ProfileImageUpdateSuccess extends ProfileState {
  final String imageUrl;

  ProfileImageUpdateSuccess(this.imageUrl);
}

class ProfileImageUpdateFailure extends ProfileState {
  final String error;

  ProfileImageUpdateFailure(this.error);
}
