// ignore_for_file: public_member_api_docs, sort_constructors_first
abstract class LoginState {}

class InitialLoginState extends LoginState {}

class SuccessLoginState extends LoginState {
  String? message;
}

class FaildLoginState extends LoginState {
  String? message;
  bool? isFaildUsername;
  bool? isFaildPassword;
  FaildLoginState({
    this.message,
    this.isFaildUsername,
    this.isFaildPassword,
  });
}

class LoadingLoginState extends LoginState {
  String? message;
}
