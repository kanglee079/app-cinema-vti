import 'package:app_cinema/features/home/data/model/movie.dart';
import 'package:app_cinema/features/home/domain/repo/home_repo.dart';
import 'package:app_cinema/features/home/domain/repo/home_repo.impl.dart';

import 'home_usecase.dart';

class HomeUseCaseImpl extends HomeUseCase {
  final HomeRepository _repo = HomeRepositoryImpl();
  @override
  Future<List<Movie>?> getUpcomingMovies() {
    return _repo.getUpcomingMovies();
  }
}
