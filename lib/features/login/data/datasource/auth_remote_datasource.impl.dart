import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'auth_remote_datasource.dart';

class AuthRemoteDataSourceImpl extends AuthRemoteDataSource {
  @override
  Future<UserCredential?> loginWithFacebook() {
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
  Future<UserCredential?> loginWithUsernameAndPassword({
    required String username,
    required String password,
  }) async {
    final userCred = await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: username,
      password: password,
    );

    return userCred;
  }

  @override
  Future<UserCredential?> registerWithUsernameAndPassword(
      {required String username, required String password}) {
    // TODO: implement registerWithUsernameAndPassword
    throw UnimplementedError();
  }
}
