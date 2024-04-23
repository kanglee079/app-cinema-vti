import '../../data/models/movie_detail_model.dart';
import '../../data/models/session_model.dart';
import '../../data/models/video_movie_response.dart';

abstract class MovieDetailRepository {
  Future<MovieDetail> getMovieDetail(int movieId);
  Future<MovieVideoReponse> getMovieVideos(int movieId);
  Future<List<MovieSession>?> getMovieSessions({
    required int movieId,
    required DateTime sessionDate,
  });
}
