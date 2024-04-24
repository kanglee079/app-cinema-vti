import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/movie_session_entity.dart';
import '../../domain/usecases/movie_detail_usecase.dart';
import 'movie_detail_event.dart';
import 'movie_detail_state.dart';

class MovieDetailBloc extends Bloc<MovieDetailEvent, MovieDetailState> {
  final MovieDetailUsecases _usecase;

  MovieDetailBloc(this._usecase) : super(MovieDetailState()) {
    on<GetMovieDetailEvent>(_onGetNewMovieDetailEvent);
    on<GetMovieSessionsEvent>(_onGetNewMovieSessionsEvent);
    on<SortMovieSessionsByCinemaEvent>(_onSortMovieSessionsByCinemaEvent);
    on<SortMovieSessionsByTimeEvent>(_onSortMovieSessionsByTimeEvent);
  }

  FutureOr<void> _onGetNewMovieDetailEvent(
    GetMovieDetailEvent event,
    Emitter<MovieDetailState> emit,
  ) async {
    emit(state.copyWith(status: BlocStatusState.loading));
    try {
      final movieDetail = await _usecase.getMovieDetail(event.movieId);
      emit(state.copyWith(
        status: BlocStatusState.success,
        movieDetail: movieDetail,
        errorMessage: null,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: BlocStatusState.failed,
        errorMessage: e.toString(),
      ));
    }
  }

  FutureOr<void> _onGetNewMovieSessionsEvent(
    GetMovieSessionsEvent event,
    Emitter<MovieDetailState> emit,
  ) async {
    emit(state.copyWith(
      status: BlocStatusState.loading,
    ));
    try {
      final movieSessions = await _usecase.getMovieSessions(
        movieId: event.movieId,
        sessionDate: event.sessionDate,
      );
      emit(state.copyWith(
        status: BlocStatusState.success,
        movieSessions: movieSessions,
        errorMessage: null,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: BlocStatusState.failed,
        errorMessage: e.toString(),
      ));
    }
  }

  FutureOr<void> _onSortMovieSessionsByCinemaEvent(
    SortMovieSessionsByCinemaEvent event,
    Emitter<MovieDetailState> emit,
  ) async {
    final currentSessions = state.movieSessions;
    if (currentSessions != null) {
      final sortedSessions = List<MovieSessionEntity>.from(currentSessions);
      sortedSessions.sort((a, b) {
        if (event.isAscending) {
          return a.theater!.compareTo(b.theater ?? "");
        } else {
          return b.theater!.compareTo(a.theater ?? "");
        }
      });
      emit(state.copyWith(movieSessions: sortedSessions));
    }
  }

  FutureOr<void> _onSortMovieSessionsByTimeEvent(
    SortMovieSessionsByTimeEvent event,
    Emitter<MovieDetailState> emit,
  ) async {
    final currentSessions = state.movieSessions;
    if (currentSessions != null) {
      final sortedSessions = List<MovieSessionEntity>.from(currentSessions);
      sortedSessions.sort((a, b) {
        if (event.isAscending) {
          return a.sessionTime!.compareTo(b.sessionTime ?? DateTime.now());
        } else {
          return b.sessionTime!.compareTo(a.sessionTime ?? DateTime.now());
        }
      });
      emit(state.copyWith(movieSessions: sortedSessions));
    }
  }
}
