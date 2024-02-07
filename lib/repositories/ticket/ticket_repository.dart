import 'package:dio/dio.dart';
import 'package:pureservers/data/status.dart';
import 'package:pureservers/data/ticket/ticket.dart';

abstract class TicketRepository {
  final Dio dio;

  TicketRepository(this.dio);

  Future<List<Ticket>> getTickets();
  Future<FullTicket> getTicketById(String ticketId);
  Future<Status> sendMessageToTicketById(String ticketId, String text);
}