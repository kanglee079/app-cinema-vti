import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthUsecase {
  Future<User?> loginWithUsernameAndPassword({
    required String username,
    required String password,
  });

  Future<User?> registerWithUsernameAndPassword({
    required String username,
    required String password,
  });

  Future<UserCredential?> loginWithGoogle();

  Future<User?> loginWithFacebook();
}
