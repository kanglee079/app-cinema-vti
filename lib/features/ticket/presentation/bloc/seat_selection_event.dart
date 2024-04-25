import 'package:app_cinema/features/ticket/domain/entities/ticket_entity.dart';
import 'package:equatable/equatable.dart';

abstract class TicketEvent extends Equatable {
  const TicketEvent();

  @override
  List<Object> get props => [];
}

class LoadTicketsEvent extends TicketEvent {
  final String userId;

  const LoadTicketsEvent({required this.userId});

  @override
  List<Object> get props => [userId];
}

class CreateTicketEvent extends TicketEvent {
  final String userId;
  final TicketEntity ticket;

  const CreateTicketEvent({required this.userId, required this.ticket});

  @override
  List<Object> get props => [userId, ticket];
}

class UpdateTicketEvent extends TicketEvent {
  final String userId;
  final TicketEntity ticket;

  const UpdateTicketEvent({required this.userId, required this.ticket});

  @override
  List<Object> get props => [userId, ticket];
}

class DeleteTicketEvent extends TicketEvent {
  final String userId;
  final String ticketId;

  const DeleteTicketEvent({required this.userId, required this.ticketId});

  @override
  List<Object> get props => [userId, ticketId];
}
