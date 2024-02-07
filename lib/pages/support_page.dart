import 'package:flutter/material.dart';
import 'package:pureservers/core/di.dart';
import 'package:pureservers/data/ticket/ticket.dart';
import 'package:pureservers/pages/ticket_page.dart';
import 'package:pureservers/repositories/ticket/ticket_repository.dart';

class SupportPage extends StatefulWidget {
  const SupportPage({super.key});

  @override
  State<SupportPage> createState() => _SupportPageState();
}

class _SupportPageState extends State<SupportPage> {
  final TicketRepository _ticketRepository = getIt();
  late Future<List<Ticket>> _ticketList;

  @override
  void initState() {
    super.initState();
    _ticketList = _ticketRepository.getTickets();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Тикеты"),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          _ticketList = _ticketRepository.getTickets();
        },
        child: FutureBuilder(
          future: _ticketList,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (!snapshot.hasData) return const Text('Нет данных');
            final data = snapshot.data!;

            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                final ticket = data[index];

                return Card(
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TicketPage(
                            id: ticket.id,
                            subject: ticket.subject,
                          ),
                        ),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            ticket.subject,
                            style: const TextStyle(fontSize: 15),
                          ),
                          Text(ticket.status == "waiting"
                              ? "Ожидает ответа"
                              : "Закрыт"),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Функция в разработке'),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
