import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthEvent {}

class LoginWithUsernamePasswordEvent extends AuthEvent {
  final String? username;
  final String? password;

  LoginWithUsernamePasswordEvent({
    this.username,
    this.password,
  });
}

class ThirdPartyLoginEvent extends AuthEvent {
  final String provider;

  ThirdPartyLoginEvent({required this.provider});
}

class RegisterEvent extends AuthEvent {
  final String email;
  final String password;
  final String fullName;
  final DateTime dob;
  final String phoneNumber;
  final String gender;
  final String city;

  RegisterEvent({
    required this.email,
    required this.password,
    required this.fullName,
    required this.dob,
    required this.phoneNumber,
    required this.gender,
    required this.city,
  });
}

class FirstLoginEvent extends AuthEvent {
  final User user;

  FirstLoginEvent({required this.user});
}
