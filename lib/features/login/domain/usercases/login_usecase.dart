import 'package:firebase_auth/firebase_auth.dart';

abstract class LoginUsecase {
  Future<User?> loginWithUsernameAndPassword({
    required String username,
    required String password,
  });

  Future<User?> registerWithUsernameAndPassword({
    required String username,
    required String password,
  });

  Future<User?> loginWithGoogle();

  Future<User?> loginWithFacebook();
}
