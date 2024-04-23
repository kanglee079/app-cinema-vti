import 'package:firebase_auth/firebase_auth.dart';

abstract class LoginRepository {
  Future<UserCredential?> loginWithUsernameAndPassword({
    required String username,
    required String password,
  });

  Future<UserCredential?> registerWithUsernameAndPassword({
    required String username,
    required String password,
  });

  Future<UserCredential?> loginWithGoogle();

  Future<UserCredential?> loginWithFacebook();
}
