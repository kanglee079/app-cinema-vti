import '../entities/movie_detail_entity.dart';
import '../entities/movie_session_entity.dart';

abstract class MovieDetailUsecases {
  Future<MovieDetailEntity> getMovieDetail(int movieId);
  Future<List<MovieSessionEntity>?> getMovieSessions({
    required int movieId,
    required DateTime sessionDate,
  });
}
