// profile_event.dart

import 'dart:io';

import '../../../auths/domain/entities/user_entity.dart';

abstract class ProfileEvent {}

class LoadUserProfile extends ProfileEvent {}

class UpdateUserProfile extends ProfileEvent {
  final UserEntity updatedUser;

  UpdateUserProfile(this.updatedUser);
}

class UpdateUserProfileImage extends ProfileEvent {
  final UserEntity user;
  final File imageFile;

  UpdateUserProfileImage(this.user, this.imageFile);
}

class GetUserTickets extends ProfileEvent {}
