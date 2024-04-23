import 'package:app_cinema/features/home/data/datasource/home_remote_datasource.dart';
import 'package:app_cinema/features/home/data/datasource/home_remote_datasource.impl.dart';

import '../../data/model/movie.dart';
import 'home_repo.dart';

class HomeRepositoryImpl extends HomeRepository {
  final HomeRemoteDataSource homeDataSource = HomeRemoteDatasourceImpl();

  @override
  Future<List<Movie>?> getUpcomingMovies() async {
    return await homeDataSource.getUpcomingMovies();
  }
}
