import 'dart:io';

import 'package:app_cinema/features/auths/domain/entities/user_entity.dart';
import 'package:app_cinema/features/profile/data/datasource/profile_remote_datasource.dart';
import 'package:app_cinema/features/profile/domain/repo/profile_repository.dart';

import '../../../ticket/data/models/ticket_model.dart';
import '../../data/datasource/profile_remote_datasourde.impl.dart';

class ProfileRepositoryImpl extends ProfileRepository {
  final ProfileRemoteDataSource _profileRemoteDataSource =
      ProfileRemoteDataSourceImpl();

  @override
  Future<UserEntity?> getUserProfile() {
    return _profileRemoteDataSource.getUserProfile();
  }

  @override
  Future<UserEntity?> updateUserProfile(UserEntity user) {
    return _profileRemoteDataSource.updateUserProfile(user);
  }

  @override
  Future<UserEntity?> updateUserProfileImage(UserEntity user, File imageFile) {
    return _profileRemoteDataSource.updateUserProfileImage(user, imageFile);
  }

  @override
  Future<List<TicketModel?>> getUserTickets() async {
    try {
      return await _profileRemoteDataSource.getUserTickets();
    } catch (e) {
      throw Exception("Failed to fetch user tickets: $e");
    }
  }
}
