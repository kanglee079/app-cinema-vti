import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../models/movie_detail_model.dart';
import '../../models/video_movie_response.dart';

part 'movie_detail_rest_api.g.dart';

@RestApi()
abstract class MovieDetailRestApi {
  factory MovieDetailRestApi(Dio dio, {String baseUrl}) = _MovieDetailRestApi;

  @GET('/movie/{movie_id}')
  Future<MovieDetail> getMovieDetail(
    @Path('movie_id') int movieId,
  );

  @GET('/movie/{movie_id}/videos')
  Future<MovieVideoReponse> getMovieVideos(
    @Path('movie_id') int movieId,
  );
}
