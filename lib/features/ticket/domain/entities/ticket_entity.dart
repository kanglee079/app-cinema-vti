// ignore_for_file: public_member_api_docs, sort_constructors_first
import '../../../movie_detail/data/models/session_model.dart';
import '../../../movie_detail/domain/entities/movie_detail_entity.dart';

class TicketEntity {
  String? id;
  MovieDetailEntity? movie;
  MovieSession? session;
  List<String>? seats;
  double? totalAmount;
  DateTime? createdAt;
  DateTime? sessionDateTime;
  String? userId;

  TicketEntity({
    this.id,
    this.movie,
    this.session,
    this.seats,
    this.totalAmount,
    this.createdAt,
    this.sessionDateTime,
    this.userId,
  });

  TicketEntity.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        movie = json['movie'] != null
            ? MovieDetailEntity.fromJson(json['movie'])
            : null,
        session = json['session'] != null
            ? MovieSession.fromJson(json['session'])
            : null,
        seats = List<String>.from(json['seats'] ?? []),
        totalAmount = json['totalAmount']?.toDouble(),
        createdAt = json['createdAt'] != null
            ? DateTime.parse(json['createdAt'])
            : null,
        sessionDateTime = json['sessionDateTime'] != null
            ? DateTime.parse(json['sessionDateTime'])
            : null,
        userId = json['userId'];

  factory TicketEntity.fromMap(Map<String, dynamic> map) {
    return TicketEntity(
      id: map['id'],
      movie:
          map['movie'] != null ? MovieDetailEntity.fromMap(map['movie']) : null,
      session:
          map['session'] != null ? MovieSession.fromMap(map['session']) : null,
      seats: List<String>.from(map['seats'] ?? []),
      totalAmount: map['totalAmount']?.toDouble(),
      createdAt:
          map['createdAt'] != null ? DateTime.parse(map['createdAt']) : null,
      sessionDateTime: map['sessionDateTime'] != null
          ? DateTime.parse(map['createdAt'])
          : null,
      userId: map['userId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'movie': movie?.toJson(),
      'session': session?.toJson(),
      'seats': seats,
      'totalAmount': totalAmount,
      'createdAt': createdAt?.toIso8601String(),
      'sessionDateTime': sessionDateTime?.toIso8601String(),
      'userId': userId,
    };
  }

  TicketEntity copyWith({
    String? id,
    MovieDetailEntity? movie,
    MovieSession? session,
    List<String>? seats,
    double? totalAmount,
    DateTime? createdAt,
    DateTime? sessionDateTime,
    String? userId,
  }) {
    return TicketEntity(
      id: id ?? this.id,
      movie: movie ?? this.movie,
      session: session ?? this.session,
      seats: seats ?? this.seats,
      totalAmount: totalAmount ?? this.totalAmount,
      createdAt: createdAt ?? this.createdAt,
      sessionDateTime: sessionDateTime ?? this.sessionDateTime,
      userId: userId ?? this.userId,
    );
  }
}
