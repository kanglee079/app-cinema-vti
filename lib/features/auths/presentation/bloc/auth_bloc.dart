import 'dart:async';

import 'package:app_cinema/features/auths/domain/usercases/auth_usecase.dart';
import 'package:app_cinema/features/auths/domain/usercases/auth_usecase.impl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/common/userPreferences/user_preferences.dart';
import '../../domain/entities/user_entity.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(InitialLoginState()) {
    on<LoginWithUsernamePasswordEvent>(_onLoginWithUsernameAndPasswordEvent);
    on<ThirdPartyLoginEvent>(_onThirdPartyLoginEvent);
    on<RegisterEvent>(_onRegisterEvent);
    on<FirstLoginEvent>(_onFirstLoginEvent);
  }

  final AuthUsecase _authUsecase = AuthUsecaseImpl();

  FutureOr<void> _onLoginWithUsernameAndPasswordEvent(
    LoginWithUsernamePasswordEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(LoadingLoginState(message: 'Loading...'));
    try {
      final userCred = await _authUsecase.loginWithUsernameAndPassword(
        username: event.username!.trim(),
        password: event.password!.trim(),
      );

      if (userCred != null) {
        User? currentUser = FirebaseAuth.instance.currentUser;
        await UserPreferences.setToken(currentUser!.uid);
        if (await isFirstLogin(currentUser)) {
          add(FirstLoginEvent(user: currentUser));
        } else {
          emit(SuccessLoginState(message: 'Login success!'));
        }
      } else {
        emit(FailedLoginState(
          message: 'Your username or password is incorrect',
        ));
      }
    } catch (e) {
      emit(FailedLoginState(message: "An unexpected error occurred: $e"));
    }
  }

  FutureOr<void> _onRegisterEvent(
    RegisterEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(LoadingLoginState(message: 'Loading...'));
    try {
      final userCred = await _authUsecase.registerWithUsernameAndPassword(
        username: event.email,
        password: event.password,
      );

      if (userCred != null) {
        User? currentUser = FirebaseAuth.instance.currentUser;
        if (currentUser != null) {
          UserEntity newUser = UserEntity.fromFirebaseUser(
            uid: currentUser.uid,
            email: currentUser.email ?? '',
            fullName: event.fullName,
            dob: event.dob,
            phoneNumber: event.phoneNumber,
            gender: event.gender,
            city: event.city,
            avatarUrl: '',
          );

          await saveUserDataToFirestore(newUser);
          emit(SuccessLoginState(message: 'Register Successfully!'));
        }
      } else {
        emit(FailedLoginState(message: 'Register Failed. Please try again!'));
      }
    } catch (e) {
      emit(FailedLoginState(message: 'Errror Unknown: $e'));
      print(e);
    }
  }

  FutureOr<void> _onFirstLoginEvent(
    FirstLoginEvent event,
    Emitter<AuthState> emit,
  ) async {
    UserEntity newUser = UserEntity.fromFirebaseUser(
      uid: '',
      fullName: '',
      dob: DateTime.now(),
      phoneNumber: '',
      gender: 'Other',
      city: '',
      email: '',
      avatarUrl: '',
    );
    await saveUserDataToFirestore(newUser);
    emit(SuccessLoginState(message: 'Welcome to my app!'));
  }

  FutureOr<void> _onThirdPartyLoginEvent(
    ThirdPartyLoginEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(LoadingLoginState());
    try {
      UserCredential? userCred;
      if (event.provider == 'google') {
        userCred = await _authUsecase.loginWithGoogle();
      } else if (event.provider == 'facebook') {}

      if (userCred != null && userCred.user != null) {
        User currentUser = userCred.user!;
        bool isFirstTimeLogin = await isFirstLogin(currentUser);
        await UserPreferences.setToken(currentUser.uid);
        if (isFirstTimeLogin) {
          String avatarUrl = currentUser.photoURL ?? '';

          UserEntity newUser = UserEntity.fromFirebaseUser(
            uid: currentUser.uid,
            email: currentUser.email ?? '',
            fullName: currentUser.displayName ?? '',
            dob: DateTime.now(),
            phoneNumber: currentUser.phoneNumber ?? '',
            gender: 'Other',
            city: 'Unknown',
            avatarUrl: avatarUrl,
          );

          await saveUserDataToFirestore(newUser);
        }

        emit(
            SuccessLoginState(message: 'Login success with ${event.provider}'));
      } else {
        emit(FailedLoginState(message: 'Login failed with ${event.provider}'));
      }
    } catch (e) {
      emit(
        FailedLoginState(
          message:
              'An error occurred while logging in with ${event.provider}: $e',
        ),
      );
      print(e);
    }
  }

  Future<void> saveUserDataToFirestore(UserEntity userEntity) async {
    try {
      CollectionReference users =
          FirebaseFirestore.instance.collection('users');
      await users
          .doc(userEntity.uid)
          .set(userEntity.toMap(), SetOptions(merge: true));
    } catch (e) {
      print("Error saving user data: $e");
    }
  }

  Future<bool> isFirstLogin(User user) async {
    DocumentSnapshot snapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .get();
    return !snapshot.exists;
  }
}
