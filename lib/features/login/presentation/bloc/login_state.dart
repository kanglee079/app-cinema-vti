abstract class LoginState {}

class InitialLoginState extends LoginState {}

class SuccessLoginState extends LoginState {
  final String message;

  SuccessLoginState({required this.message});
}

class FailedLoginState extends LoginState {
  final String message;
  final bool isFailedUsername;
  final bool isFailedPassword;

  FailedLoginState({
    required this.message,
    this.isFailedUsername = false,
    this.isFailedPassword = false,
  });
}

class LoadingLoginState extends LoginState {
  final String message;

  LoadingLoginState({this.message = 'Loading...'});
}
