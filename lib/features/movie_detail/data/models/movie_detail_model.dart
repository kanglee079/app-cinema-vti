// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

import 'genre_model.dart';
import 'production_country_model.dart';

part 'movie_detail_model.g.dart';

@JsonSerializable()
class MovieDetail {
  int? id;
  double? budget;
  List<GenreModel>? genres;
  String? overview;
  @JsonKey(name: 'production_countries')
  List<ProductionCountry>? productionCountries;
  @JsonKey(name: 'release_date')
  String? releaseDate;
  double? runtime;
  double? revenue;
  String? title;
  @JsonKey(name: 'vote_average')
  double? voteAverage;
  @JsonKey(name: 'vote_count')
  int? voteCount;
  MovieDetail({
    this.id,
    this.budget,
    this.genres,
    this.overview,
    this.productionCountries,
    this.releaseDate,
    this.runtime,
    this.revenue,
    this.title,
    this.voteAverage,
    this.voteCount,
  });

  // toJSON và fromJSON
  factory MovieDetail.fromJson(Map<String, dynamic> json) =>
      _$MovieDetailFromJson(json);

  Map<String, dynamic> toJson() => _$MovieDetailToJson(this);
}
