import '../../data/model/movie.dart';

abstract class HomeUseCase {
  Future<List<Movie>?> getUpcomingMovies();
}
