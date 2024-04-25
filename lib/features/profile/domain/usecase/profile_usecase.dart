import 'dart:io';

import 'package:app_cinema/features/auths/domain/entities/user_entity.dart';

abstract class ProfileUsecase {
  Future<UserEntity?> getUserProfile();
  Future<void> updateUserProfile(UserEntity user);
  Future<void> updateUserProfileImage(UserEntity user, File imageFile);
}
