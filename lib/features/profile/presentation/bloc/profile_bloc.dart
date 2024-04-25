// profile_bloc.dart

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecase/profile_usecase.dart';
import 'profile_event.dart';
import 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final ProfileUsecase profileUsecase;

  ProfileBloc({required this.profileUsecase}) : super(ProfileInitial()) {
    on<LoadUserProfile>(_onLoadUserProfile);
    on<UpdateUserProfile>(_onUpdateUserProfile);
    on<UpdateUserProfileImage>(_onUpdateUserProfileImage);
  }

  Future<void> _onLoadUserProfile(
    LoadUserProfile event,
    Emitter<ProfileState> emit,
  ) async {
    emit(ProfileLoading());
    try {
      final user = await profileUsecase.getUserProfile();
      if (user != null) {
        emit(ProfileLoaded(user));
      } else {
        emit(ProfileError('User profile could not be loaded.'));
      }
    } catch (e) {
      emit(ProfileError('An error occurred while loading the profile.'));
    }
  }

  Future<void> _onUpdateUserProfile(
    UpdateUserProfile event,
    Emitter<ProfileState> emit,
  ) async {
    emit(ProfileUpdateInProgress());
    try {
      await profileUsecase.updateUserProfile(event.updatedUser);
      emit(ProfileUpdateSuccess(event.updatedUser));
    } catch (e) {
      emit(ProfileUpdateFailure(
          'An error occurred while updating the profile.'));
    }
  }

  Future<void> _onUpdateUserProfileImage(
    UpdateUserProfileImage event,
    Emitter<ProfileState> emit,
  ) async {
    emit(ProfileImageUpdateInProgress());
    try {
      await profileUsecase.updateUserProfileImage(event.user, event.imageFile);
      emit(ProfileImageUpdateSuccess(event.user.avatarUrl));
    } catch (e) {
      emit(ProfileImageUpdateFailure(
          'An error occurred while updating the profile image.'));
      print(e.toString());
    }
  }
}
