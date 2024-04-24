import 'package:app_cinema/features/auths/domain/repo/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../repo/auth_repository.impl.dart';
import 'auth_usecase.dart';

class AuthUsecaseImpl extends AuthUsecase {
  final AuthRepository _authRepository = AuthRepositoryImpl();
  @override
  Future<User?> loginWithFacebook() {
    // TODO: implement loginWithFacebook
    throw UnimplementedError();
  }

  @override
  Future<UserCredential?> loginWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    if (googleUser != null) {
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      return await FirebaseAuth.instance.signInWithCredential(credential);
    } else {
      return null;
    }
  }

  @override
  Future<User?> loginWithUsernameAndPassword(
      {required String username, required String password}) async {
    final userCred = await _authRepository.loginWithUsernameAndPassword(
      username: username,
      password: password,
    );

    return userCred?.user;
  }

  @override
  Future<User?> registerWithUsernameAndPassword({
    required String username,
    required String password,
  }) async {
    final userCred = await _authRepository.registerWithUsernameAndPassword(
      username: username,
      password: password,
    );
    return userCred?.user;
  }
}
