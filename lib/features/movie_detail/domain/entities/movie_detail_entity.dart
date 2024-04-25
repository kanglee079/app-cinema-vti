class MovieDetailEntity {
  String? title;
  String? description;
  String? tagline;
  double? budget;
  String? genre;
  DateTime? releaseDate;
  double? revenue;
  double? voteAverage;
  int? voteCount;
  double? runtime;
  List<String>? countries;
  String? youtubeName;
  String? youtubeUrl;
  String? posterUrl;
  String? certificate;
  String? director;
  List<String>? cast;
  String? theaterName;

  MovieDetailEntity({
    this.title,
    this.description,
    this.tagline,
    this.budget,
    this.genre,
    this.releaseDate,
    this.revenue,
    this.voteAverage,
    this.voteCount,
    this.runtime,
    this.countries,
    this.youtubeName,
    this.youtubeUrl,
    this.posterUrl,
    this.certificate,
    this.director,
    this.cast,
    this.theaterName,
  });

  factory MovieDetailEntity.fromJson(Map<String, dynamic> json) {
    return MovieDetailEntity(
      title: json['title'],
      description: json['description'],
      tagline: json['tagline'],
      budget: json['budget']?.toDouble(),
      genre: json['genre'],
      releaseDate: json['releaseDate'] != null
          ? DateTime.parse(json['releaseDate'])
          : null,
      revenue: json['revenue']?.toDouble(),
      voteAverage: json['voteAverage']?.toDouble(),
      voteCount: json['voteCount'],
      runtime: json['runtime']?.toDouble(),
      countries: List<String>.from(json['countries'] ?? []),
      youtubeName: json['youtubeName'],
      youtubeUrl: json['youtubeUrl'],
      posterUrl: json['posterUrl'],
      certificate: json['certificate'],
      director: json['director'],
      cast: List<String>.from(json['cast'] ?? []),
      theaterName: json['theaterName'],
    );
  }

  factory MovieDetailEntity.fromMap(Map<String, dynamic> map) {
    return MovieDetailEntity(
      title: map['title'],
      description: map['description'],
      tagline: map['tagline'],
      budget: map['budget']?.toDouble(),
      genre: map['genre'],
      releaseDate: map['releaseDate'] != null
          ? DateTime.parse(map['releaseDate'])
          : null,
      revenue: map['revenue']?.toDouble(),
      voteAverage: map['voteAverage']?.toDouble(),
      voteCount: map['voteCount'],
      runtime: map['runtime']?.toDouble(),
      countries: List<String>.from(map['countries'] ?? []),
      youtubeName: map['youtubeName'],
      youtubeUrl: map['youtubeUrl'],
      posterUrl: map['posterUrl'],
      certificate: map['certificate'],
      director: map['director'],
      cast: List<String>.from(map['cast'] ?? []),
      theaterName: map['theaterName'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'tagline': tagline,
      'budget': budget,
      'genre': genre,
      'releaseDate': releaseDate?.toIso8601String(),
      'revenue': revenue,
      'voteAverage': voteAverage,
      'voteCount': voteCount,
      'runtime': runtime,
      'countries': countries,
      'youtubeName': youtubeName,
      'youtubeUrl': youtubeUrl,
      'posterUrl': posterUrl,
      'certificate': certificate,
      'director': director,
      'cast': cast,
      'theaterName': theaterName,
    };
  }
}
