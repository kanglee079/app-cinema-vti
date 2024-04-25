import '../../data/models/session_model.dart';

class MovieSessionEntity {
  DateTime? sessionTime;
  String? filmFormat;
  String? theater;
  double? adultPrice;
  double? childPrice;
  double? studentPrice;
  double? vipPrice;

  MovieSessionEntity({
    this.sessionTime,
    this.filmFormat,
    this.theater,
    this.adultPrice,
    this.childPrice,
    this.studentPrice,
    this.vipPrice,
  });

  MovieSession toMovieSession() {
    return MovieSession(
      sessionTime: sessionTime,
      filmFormat: filmFormat,
      theaterName: theater,
      adultTicketPrice: adultPrice,
      childTicketPrice: childPrice,
      studentTicketPrice: studentPrice,
      vipTicketPrice: vipPrice,
    );
  }
}
