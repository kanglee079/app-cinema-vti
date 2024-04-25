import '../models/ticket_model.dart';

abstract class TicketRemoteDataSource {
  Future<List<TicketModel>> readTickets({required String userId});
  Future<void> createTicket(
      {required String userId, required TicketModel ticket});
  Future<TicketModel> updateTicket(
      {required String userId, required TicketModel ticket});
  Future<void> deleteTicket({required String userId, required String ticketId});
}
