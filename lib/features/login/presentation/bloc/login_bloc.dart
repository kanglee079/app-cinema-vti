import 'dart:async';

import 'package:app_cinema/features/login/domain/usercases/login_usecase.dart';
import 'package:app_cinema/features/login/domain/usercases/login_usecase.impl.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(InitialLoginState()) {
    on<LoginWithUsernamePasswordEvent>(_onLoginWithUsernamePasswordEvent);
    on<ThirdPartyLoginEvent>(_onThirdPartyLoginEvent);
  }

  final LoginUsecase _loginUsecase = LoginUsecaseImpl();

  FutureOr<void> _onLoginWithUsernamePasswordEvent(
    LoginWithUsernamePasswordEvent event,
    Emitter<LoginState> emit,
  ) async {
    emit(LoadingLoginState(message: 'Loading...'));

    try {
      final user = await _loginUsecase.loginWithUsernameAndPassword(
        username: event.username!.trim(),
        password: event.password!.trim(),
      );

      if (user != null) {
        emit(SuccessLoginState(message: 'Login success!'));
      } else {
        emit(FailedLoginState(
          message: 'Your username or password is incorrect',
        ));
      }
    } catch (e) {
      print("An unexpected error occurred: $e");
      emit(FailedLoginState(message: "An unexpected error occurred"));
    }

    return null;
  }

  FutureOr<void> _onThirdPartyLoginEvent(
    ThirdPartyLoginEvent event,
    Emitter<LoginState> emit,
  ) async {
    emit(LoadingLoginState());
    User? user;
    if (event.provider == 'google') {
      user = await _loginUsecase.loginWithGoogle();
    } else if (event.provider == 'facebook') {
      user = await _loginUsecase.loginWithFacebook();
    }
    if (user != null) {
      emit(SuccessLoginState(message: 'Login success with ${event.provider}'));
    } else {
      emit(FailedLoginState(
        message: 'Login failed with ${event.provider}',
      ));
    }
  }
}
