abstract class LoginEvent {}

class LoginWithUsernamePasswordEvent extends LoginEvent {
  final String? username;
  final String? password;

  LoginWithUsernamePasswordEvent({
    this.username,
    this.password,
  });
}

class ThirdPartyLoginEvent extends LoginEvent {
  final String provider;

  ThirdPartyLoginEvent({required this.provider});
}
