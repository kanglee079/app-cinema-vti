import '../entities/movie_detail_entity.dart';
import '../entities/movie_session_entity.dart';
import '../repo/movie_detail_repository.dart';
import '../repo/movie_detail_repository.impl.dart';
import 'movie_detail_usecase.dart';

class MovieDetailUsecasesImplement extends MovieDetailUsecases {
  final MovieDetailRepository _repo = MovieDetailRepositoryImplement();
  @override
  Future<MovieDetailEntity> getMovieDetail(int movieId) async {
    // Convert Model -> Entity
    final movieModel = await _repo.getMovieDetail(movieId);
    final movieVideoReponse = await _repo.getMovieVideos(movieId);
    final movieVideos = movieVideoReponse.results;
    // filter  // filter. Youtube && (Trailer || Teaser) && official

    final officialTrailer = movieVideos
        ?.where(
          (element) =>
              element.site == 'YouTube' &&
              (element.type == 'Trailer' || element.type == 'Teaser') &&
              element.official == true,
        )
        .firstOrNull;
    final result = MovieDetailEntity(
      title: movieModel.title,
      description: movieModel.overview,
      tagline: '',
      budget: movieModel.budget,
      genre: movieModel.genres?.map((e) => e.name).join(', '),
      releaseDate: DateTime.tryParse(movieModel.releaseDate ?? ''),
      revenue: movieModel.revenue,
      voteAverage: movieModel.voteAverage,
      voteCount: movieModel.voteCount,
      runtime: movieModel.runtime,
      countries: movieModel.productionCountries
          ?.where((element) => element.name != null)
          .map((e) => e.name as String) // avoid crash when parse
          .toList(),
      youtubeName: officialTrailer?.name,
      youtubeUrl: officialTrailer?.key,
      posterUrl: movieModel.posterUrl,
    );
    return result;
  }

  @override
  Future<List<MovieSessionEntity>?> getMovieSessions({
    required int movieId,
    required DateTime sessionDate,
  }) async {
    final resultModels = await _repo.getMovieSessions(
      movieId: movieId,
      sessionDate: sessionDate,
    );
    return resultModels?.map((e) => e.convertToEntity()).toList();
  }
}
