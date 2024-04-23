// ignore_for_file: public_member_api_docs, sort_constructors_first
import '../../domain/entities/movie_detail_entity.dart';
import '../../domain/entities/movie_session_entity.dart';

enum BlocStatusState { initial, loading, success, failed }

class MovieDetailState {
  final BlocStatusState status;
  final MovieDetailEntity? movieDetail;
  final List<MovieSessionEntity>? movieSessions;
  final String? errorMessage;

  MovieDetailState({
    this.status = BlocStatusState.initial,
    this.movieDetail,
    this.movieSessions,
    this.errorMessage,
  });

  MovieDetailState copyWith({
    BlocStatusState? status,
    MovieDetailEntity? movieDetail,
    List<MovieSessionEntity>? movieSessions,
    String? errorMessage,
  }) {
    return MovieDetailState(
      status: status ?? this.status,
      movieDetail: movieDetail ?? this.movieDetail,
      movieSessions: movieSessions ?? this.movieSessions,
      errorMessage: errorMessage,
    );
  }
}
