import 'package:json_annotation/json_annotation.dart';

import 'video_movie_model.dart';

part 'video_movie_response.g.dart';

@JsonSerializable()
class MovieVideoReponse {
  int? id;
  List<MovieVideo>? results;
  MovieVideoReponse({
    this.id,
    this.results,
  });

  // toJSON và fromJSON
  factory MovieVideoReponse.fromJson(Map<String, dynamic> json) =>
      _$MovieVideoReponseFromJson(json);

  Map<String, dynamic> toJson() => _$MovieVideoReponseToJson(this);
}
