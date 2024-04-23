import '../../data/model/movie.dart';

abstract class HomeRepository {
  Future<List<Movie>?> getUpcomingMovies();
}
