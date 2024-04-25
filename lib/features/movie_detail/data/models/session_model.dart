import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/movie_session_entity.dart';

@JsonSerializable()
// Tưởng tượng có 1 API gửi về những data này
class MovieSession {
  @JsonKey(name: 'session_time')
  DateTime? sessionTime;
  @JsonKey(name: 'film_format')
  String? filmFormat;
  @JsonKey(name: 'theater_name')
  String? theaterName;
  @JsonKey(name: 'adult_ticket_price')
  double? adultTicketPrice;
  @JsonKey(name: 'child_ticket_price')
  double? childTicketPrice;
  @JsonKey(name: 'student_ticket_price')
  double? studentTicketPrice;
  @JsonKey(name: 'vip_ticket_price')
  double? vipTicketPrice;
  MovieSession({
    this.sessionTime,
    this.filmFormat,
    this.theaterName,
    this.adultTicketPrice,
    this.childTicketPrice,
    this.studentTicketPrice,
    this.vipTicketPrice,
  });

  factory MovieSession.fromJson(Map<String, dynamic> json) {
    return MovieSession(
      sessionTime: json['session_time'] == null
          ? null
          : DateTime.parse(json['session_time'] as String),
      filmFormat: json['film_format'] as String?,
      theaterName: json['theater_name'] as String?,
      adultTicketPrice: (json['adult_ticket_price'] as num?)?.toDouble(),
      childTicketPrice: (json['child_ticket_price'] as num?)?.toDouble(),
      studentTicketPrice: (json['student_ticket_price'] as num?)?.toDouble(),
      vipTicketPrice: (json['vip_ticket_price'] as num?)?.toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'session_time': sessionTime?.toIso8601String(),
      'film_format': filmFormat,
      'theater_name': theaterName,
      'adult_ticket_price': adultTicketPrice,
      'child_ticket_price': childTicketPrice,
      'student_ticket_price': studentTicketPrice,
      'vip_ticket_price': vipTicketPrice,
    };
  }

  factory MovieSession.fromMap(Map<String, dynamic> map) {
    return MovieSession(
      sessionTime: map['session_time'] == null
          ? null
          : DateTime.parse(map['session_time'] as String),
      filmFormat: map['film_format'] as String?,
      theaterName: map['theater_name'] as String?,
      adultTicketPrice: (map['adult_ticket_price'] as num?)?.toDouble(),
      childTicketPrice: (map['child_ticket_price'] as num?)?.toDouble(),
      studentTicketPrice: (map['student_ticket_price'] as num?)?.toDouble(),
      vipTicketPrice: (map['vip_ticket_price'] as num?)?.toDouble(),
    );
  }

  MovieSessionEntity convertToEntity() {
    return MovieSessionEntity(
      sessionTime: sessionTime,
      filmFormat: filmFormat,
      theater: theaterName,
      adultPrice: adultTicketPrice?.toDouble(),
      childPrice: childTicketPrice,
      studentPrice: studentTicketPrice,
      vipPrice: vipTicketPrice,
    );
  }
}
