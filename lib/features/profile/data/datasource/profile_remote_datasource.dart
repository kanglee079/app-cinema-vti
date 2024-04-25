import 'dart:io';

import '../../../auths/domain/entities/user_entity.dart';

abstract class ProfileRemoteDataSource {
  Future<UserEntity?> getUserProfile();

  Future<UserEntity?> updateUserProfile(UserEntity user);

  Future<UserEntity?> updateUserProfileImage(UserEntity user, File imageFile);
}
