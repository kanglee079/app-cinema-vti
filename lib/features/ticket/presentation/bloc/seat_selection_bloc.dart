import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecase/seat_selection_usecase.dart';
import 'seat_selection_event.dart';
import 'seat_selection_state.dart';

class TicketBloc extends Bloc<TicketEvent, TicketState> {
  final SeatSelectionUsecase seatSelectionUsecase;

  TicketBloc({required this.seatSelectionUsecase}) : super(TicketsInitial()) {
    on<LoadTicketsEvent>(_onLoadTickets);
    on<CreateTicketEvent>(_onCreateTicket);
    on<UpdateTicketEvent>(_onUpdateTicket);
    on<DeleteTicketEvent>(_onDeleteTicket);
  }

  void _onLoadTickets(LoadTicketsEvent event, Emitter<TicketState> emit) async {
    emit(TicketsLoading());
    try {
      final tickets =
          await seatSelectionUsecase.getTickets(userId: event.userId);
      emit(TicketsLoaded(tickets: tickets));
    } catch (error) {
      emit(TicketOperationFailure(error: error.toString()));
    }
  }

  void _onCreateTicket(
      CreateTicketEvent event, Emitter<TicketState> emit) async {
    try {
      await seatSelectionUsecase.createTicket(
          userId: event.userId, ticket: event.ticket);
      emit(TicketOperationSuccess());
    } catch (error) {
      emit(TicketOperationFailure(error: error.toString()));
    }
  }

  void _onUpdateTicket(
      UpdateTicketEvent event, Emitter<TicketState> emit) async {
    try {
      await seatSelectionUsecase.updateTicket(
          userId: event.userId, ticket: event.ticket);
      emit(TicketOperationSuccess());
    } catch (error) {
      emit(TicketOperationFailure(error: error.toString()));
    }
  }

  void _onDeleteTicket(
      DeleteTicketEvent event, Emitter<TicketState> emit) async {
    try {
      await seatSelectionUsecase.deleteTicket(
          userId: event.userId, ticketId: event.ticketId);
      emit(TicketOperationSuccess());
    } catch (error) {
      emit(TicketOperationFailure(error: error.toString()));
    }
  }
}
