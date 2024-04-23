import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usercases/home_usecase.dart';
import '../../domain/usercases/home_usecase.impl.dart';
import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final HomeUseCase _homeUseCase = HomeUseCaseImpl();

  HomeBloc() : super(InitialHomeState()) {
    on<GetUpcomingMoviesEvent>(_onGetUpcomingMovies);
  }

  Future<void> _onGetUpcomingMovies(
    GetUpcomingMoviesEvent event,
    Emitter<HomeState> emit,
  ) async {
    emit(LoadingHomeState());

    try {
      final movies = await _homeUseCase.getUpcomingMovies();
      if (movies!.isNotEmpty) {
        emit(LoadedHomeState(movies));
      } else {
        emit(ErrorHomeState("No upcoming movies found"));
      }
    } catch (e) {
      print("An unexpected error occurred: $e");
      emit(ErrorHomeState("An unexpected error occurred"));
    }
  }
}
