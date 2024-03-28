abstract class LoginEvent {}

class LoginWithUsernamePasswordEvent extends LoginEvent {
  String? username;
  String? password;

  LoginWithUsernamePasswordEvent({this.username, this.password});
}

class ThirdPartyLoginEvent extends LoginEvent {
  String? provider;
}
