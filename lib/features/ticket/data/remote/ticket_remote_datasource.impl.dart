import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/ticket_model.dart';
import 'ticket_remote_datasource.dart';

class TicketRemoteDataSourceImpl implements TicketRemoteDataSource {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Future<void> createTicket(
      {required String userId, required TicketModel ticket}) async {
    final docRef =
        firestore.collection('users').doc(userId).collection('tickets').doc();
    ticket.id = docRef.id;
    await docRef.set(ticket.toJson());
  }

  @override
  Future<void> deleteTicket(
      {required String userId, required String ticketId}) async {
    await firestore
        .collection('users')
        .doc(userId)
        .collection('tickets')
        .doc(ticketId)
        .delete();
  }

  @override
  Future<List<TicketModel>> readTickets({required String userId}) async {
    final querySnapshot = await firestore
        .collection('users')
        .doc(userId)
        .collection('tickets')
        .get();
    return querySnapshot.docs
        .map((doc) => TicketModel.fromJson(doc.data()))
        .toList();
  }

  @override
  Future<TicketModel> updateTicket(
      {required String userId, required TicketModel ticket}) async {
    final docRef = firestore
        .collection('users')
        .doc(userId)
        .collection('tickets')
        .doc(ticket.id);
    await docRef.update(ticket.toJson());
    final updatedDoc = await docRef.get();
    return TicketModel.fromJson(updatedDoc.data() as Map<String, dynamic>);
  }
}
