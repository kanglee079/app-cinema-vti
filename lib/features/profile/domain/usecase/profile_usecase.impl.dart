import 'dart:io';

import 'package:app_cinema/features/auths/domain/entities/user_entity.dart';
import 'package:app_cinema/features/profile/domain/repo/profile_repository.dart';

import '../repo/profile_repository.impl.dart';
import 'profile_usecase.dart';

class ProfileUsecaseImpl implements ProfileUsecase {
  final ProfileRepository _profileRepository = ProfileRepositoryImpl();

  @override
  Future<UserEntity?> getUserProfile() async {
    return _profileRepository.getUserProfile();
  }

  @override
  Future<void> updateUserProfile(UserEntity user) async {
    await _profileRepository.updateUserProfile(user);
  }

  @override
  Future<void> updateUserProfileImage(UserEntity user, File imageFile) async {
    await _profileRepository.updateUserProfileImage(user, imageFile);
  }
}
