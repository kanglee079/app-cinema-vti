// ignore_for_file: public_member_api_docs, sort_constructors_first
abstract class MovieDetailEvent {}

class GetMovieDetailEvent extends MovieDetailEvent {
  final int movieId;
  GetMovieDetailEvent({
    required this.movieId,
  });
}

class GetMovieSessionsEvent extends MovieDetailEvent {
  final int movieId;
  final DateTime sessionDate;
  GetMovieSessionsEvent({
    required this.movieId,
    required this.sessionDate,
  });
}

class SortMovieSessionsByCinemaEvent extends MovieDetailEvent {
  final bool isAscending;

  SortMovieSessionsByCinemaEvent({required this.isAscending});
}

class SortMovieSessionsByTimeEvent extends MovieDetailEvent {
  final bool isAscending;

  SortMovieSessionsByTimeEvent({required this.isAscending});
}
