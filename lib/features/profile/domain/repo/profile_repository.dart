import 'dart:io';

import '../../../auths/domain/entities/user_entity.dart';
import '../../../ticket/data/models/ticket_model.dart';

abstract class ProfileRepository {
  Future<UserEntity?> getUserProfile();

  Future<UserEntity?> updateUserProfile(UserEntity user);

  Future<UserEntity?> updateUserProfileImage(UserEntity user, File imageFile);

  Future<List<TicketModel?>> getUserTickets();
}
