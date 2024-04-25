import '../../data/models/ticket_model.dart';
import '../../data/remote/ticket_remote_datasource.dart';
import '../../data/remote/ticket_remote_datasource.impl.dart';
import 'seat_selection_repo.dart';

class SeatSelectionRepositoryImpl implements SeatSelectionRepository {
  final TicketRemoteDataSource remoteDataSource = TicketRemoteDataSourceImpl();

  @override
  Future<void> createTicket(
      {required String userId, required TicketModel ticket}) async {
    await remoteDataSource.createTicket(userId: userId, ticket: ticket);
  }

  @override
  Future<void> deleteTicket(
      {required String userId, required String ticketId}) async {
    await remoteDataSource.deleteTicket(userId: userId, ticketId: ticketId);
  }

  @override
  Future<List<TicketModel>> getTickets({required String userId}) async {
    return await remoteDataSource.readTickets(userId: userId);
  }

  @override
  Future<TicketModel> updateTicket(
      {required String userId, required TicketModel ticket}) async {
    return await remoteDataSource.updateTicket(userId: userId, ticket: ticket);
  }
}
