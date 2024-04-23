import 'package:app_cinema/features/login/domain/repo/login_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../repo/login_repository.impl.dart';
import 'login_usecase.dart';

class LoginUsecaseImpl extends LoginUsecase {
  final LoginRepository _loginRepository = LoginRepositoryImpl();
  @override
  Future<User?> loginWithFacebook() {
    // TODO: implement loginWithFacebook
    throw UnimplementedError();
  }

  @override
  Future<User?> loginWithGoogle() async {
    final userCred = await _loginRepository.loginWithGoogle();
    return userCred?.user;
  }

  @override
  Future<User?> loginWithUsernameAndPassword(
      {required String username, required String password}) async {
    final userCred = await _loginRepository.loginWithUsernameAndPassword(
      username: username,
      password: password,
    );

    return userCred?.user;
  }

  @override
  Future<User?> registerWithUsernameAndPassword(
      {required String username, required String password}) {
    // TODO: implement registerWithUsernameAndPassword
    throw UnimplementedError();
  }
}
