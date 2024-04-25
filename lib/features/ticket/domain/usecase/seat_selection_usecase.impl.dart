import 'package:app_cinema/features/ticket/data/models/ticket_model.dart';
import 'package:app_cinema/features/ticket/domain/entities/ticket_entity.dart';

import '../repo/seat_selection_repo.dart';
import '../repo/seat_selection_repo.impl.dart';
import 'seat_selection_usecase.dart';

class SeatSelectionUsecaseImpl implements SeatSelectionUsecase {
  final SeatSelectionRepository repository = SeatSelectionRepositoryImpl();

  @override
  Future<void> createTicket(
      {required String userId, required TicketEntity ticket}) async {
    final ticketModel = TicketModel.fromEntity(ticket);
    await repository.createTicket(userId: userId, ticket: ticketModel);
  }

  @override
  Future<void> deleteTicket(
      {required String userId, required String ticketId}) async {
    await repository.deleteTicket(userId: userId, ticketId: ticketId);
  }

  @override
  Future<List<TicketEntity>> getTickets({required String userId}) async {
    final ticketModels = await repository.getTickets(userId: userId);
    return ticketModels
        .map((ticketModel) => ticketModel.convertToEntity())
        .toList();
  }

  @override
  Future<TicketEntity> updateTicket(
      {required String userId, required TicketEntity ticket}) async {
    final ticketModel = TicketModel.fromEntity(ticket);
    final updatedTicketModel =
        await repository.updateTicket(userId: userId, ticket: ticketModel);
    return updatedTicketModel.convertToEntity();
  }
}
