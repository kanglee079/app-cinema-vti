// ignore_for_file: public_member_api_docs, sort_constructors_first
class TicketEntity {
  String? id;
  String? title; // col
  double? runTime; // col
  String? filmFormat;
  String? theater;
  DateTime? time;
  List<String>? seats; // "S7, S8, S9"
  double? unitPrice;
  String? userId;
  DateTime? createdAt;

  TicketEntity({
    this.id,
    this.title,
    this.runTime,
    this.filmFormat,
    this.theater,
    this.time,
    this.seats,
    this.unitPrice,
    this.userId,
    this.createdAt,
  });
}
