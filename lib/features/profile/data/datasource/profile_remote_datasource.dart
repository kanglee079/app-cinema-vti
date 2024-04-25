import 'dart:io';

import 'package:app_cinema/features/ticket/data/models/ticket_model.dart';

import '../../../auths/domain/entities/user_entity.dart';

abstract class ProfileRemoteDataSource {
  Future<UserEntity?> getUserProfile();

  Future<UserEntity?> updateUserProfile(UserEntity user);

  Future<UserEntity?> updateUserProfileImage(UserEntity user, File imageFile);

  Future<List<TicketModel?>> getUserTickets();
}
