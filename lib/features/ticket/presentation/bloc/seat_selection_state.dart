// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:app_cinema/features/ticket/domain/entities/ticket_entity.dart';
import 'package:equatable/equatable.dart';

abstract class TicketState extends Equatable {
  const TicketState();

  @override
  List<Object> get props => [];
}

class TicketsInitial extends TicketState {
  DateTime? timeStamp;
  TicketsInitial({
    this.timeStamp,
  });

  @override
  List<Object> get props => [timeStamp ?? DateTime.now()];
}

class TicketsLoading extends TicketState {}

class TicketsLoaded extends TicketState {
  final List<TicketEntity> tickets;

  const TicketsLoaded({required this.tickets});

  @override
  List<Object> get props => [tickets];
}

class TicketOperationSuccess extends TicketState {
  DateTime? timeStamp;
  TicketOperationSuccess({
    this.timeStamp,
  });

  @override
  List<Object> get props => [];
}

class TicketOperationFailure extends TicketState {
  final String error;

  const TicketOperationFailure({required this.error});

  @override
  List<Object> get props => [error];
}
