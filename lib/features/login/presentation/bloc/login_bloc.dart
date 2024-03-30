import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(InitialLoginState()) {
    on<LoginWithUsernamePasswordEvent>(_onLoginWithUsernamePasswordEvent);
    on<ThirdPartyLoginEvent>(_onThirdPartyLoginEvent);
  }

  FutureOr<void> _onLoginWithUsernamePasswordEvent(
    LoginWithUsernamePasswordEvent event,
    Emitter<LoginState> emit,
  ) async {
    emit(LoadingLoginState());

    await Future.delayed(const Duration(seconds: 1));

    if (event.username == 'demo' && event.password == 'demo') {
      emit(SuccessLoginState(message: 'Đăng nhập thành công'));
    } else {
      emit(FaildLoginState(
        message: 'Thông tin đăng nhập không chính xác',
        isFaildUsername: true,
        isFaildPassword: true,
      ));
    }
    return null;
  }

  FutureOr<void> _onThirdPartyLoginEvent(
    ThirdPartyLoginEvent event,
    Emitter<LoginState> emit,
  ) async {
    emit(LoadingLoginState());

    await Future.delayed(const Duration(seconds: 1));

    if (event.provider == 'google' || event.provider == 'facebook') {
      emit(SuccessLoginState(
          message: 'Đăng nhập thành công với $event.provider'));
    } else {
      emit(FaildLoginState(
        message: 'Đăng nhập thất bại $event.provider',
        isFaildUsername: false,
        isFaildPassword: false,
      ));
    }
    return null;
  }
}
