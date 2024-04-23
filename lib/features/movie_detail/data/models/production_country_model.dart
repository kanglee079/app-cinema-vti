import 'package:json_annotation/json_annotation.dart';

part 'production_country_model.g.dart';

@JsonSerializable()
class ProductionCountry {
  @JsonKey(name: 'iso_3166_1')
  String? iso31661;
  String? name;
  ProductionCountry({
    this.iso31661,
    this.name,
  });

  // toJSON và fromJSON
  factory ProductionCountry.fromJson(Map<String, dynamic> json) =>
      _$ProductionCountryFromJson(json);

  Map<String, dynamic> toJson() => _$ProductionCountryToJson(this);
}
