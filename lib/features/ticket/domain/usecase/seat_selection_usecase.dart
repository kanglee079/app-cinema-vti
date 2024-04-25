import '../entities/ticket_entity.dart';

abstract class SeatSelectionUsecase {
  Future<List<TicketEntity>> getTickets({required String userId});
  Future<void> createTicket(
      {required String userId, required TicketEntity ticket});
  Future<void> deleteTicket({required String userId, required String ticketId});
  Future<TicketEntity> updateTicket(
      {required String userId, required TicketEntity ticket});
}
