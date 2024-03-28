import 'dart:async';

import 'package:app_cinema/features/login/presentation/bloc/login_event.dart';
import 'package:app_cinema/features/login/presentation/bloc/login_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc(super.initialState) {
    on<LoginWithUsernamePasswordEvent>(_onLoginWithUsernamePasswordEvent);
  }

  FutureOr<void> _onLoginWithUsernamePasswordEvent(
    LoginWithUsernamePasswordEvent event,
    Emitter<LoginState> emit,
  ) {
    print(event.username);
    print(event.password);
    return null;
  }
}
