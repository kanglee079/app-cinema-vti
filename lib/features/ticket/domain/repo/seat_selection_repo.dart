import '../../data/models/ticket_model.dart';

abstract class SeatSelectionRepository {
  Future<List<TicketModel>> getTickets({required String userId});
  Future<void> createTicket(
      {required String userId, required TicketModel ticket});
  Future<void> deleteTicket({required String userId, required String ticketId});
  Future<TicketModel> updateTicket(
      {required String userId, required TicketModel ticket});
}
