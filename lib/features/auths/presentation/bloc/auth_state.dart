abstract class AuthState {}

class InitialLoginState extends AuthState {}

class SuccessLoginState extends AuthState {
  final String message;

  SuccessLoginState({required this.message});
}

class FailedLoginState extends AuthState {
  final String message;
  final bool isFailedUsername;
  final bool isFailedPassword;

  FailedLoginState({
    required this.message,
    this.isFailedUsername = false,
    this.isFailedPassword = false,
  });
}

class LoadingLoginState extends AuthState {
  final String message;

  LoadingLoginState({this.message = 'Loading...'});
}
