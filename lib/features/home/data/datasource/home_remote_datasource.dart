import '../model/movie.dart';

abstract class HomeRemoteDataSource {
  Future<List<Movie>?> getUpcomingMovies();
}
