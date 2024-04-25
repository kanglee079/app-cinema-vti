List<SeatTheaterEntity> generateSeatTheater() {
  final result = <SeatTheaterEntity>[];
  for (var i = 0; i < 12; i++) {
    for (var j = 0; j < 12; j++) {
      final String position = String.fromCharCode(65 + i) + j.toString();
      final random = Random().nextInt(2);
      result.add(
        SeatTheaterEntity(
          position: position,
          status: SeatTheaterStatus.values[random],
        ),
      );
    }
  }
  return result;
}
