import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pureservers/core/di.dart';
import 'package:pureservers/data/ticket/ticket.dart';
import 'package:pureservers/repositories/ticket/ticket_repository.dart';

class TicketPage extends StatefulWidget {
  final String id;
  final String subject;

  const TicketPage({super.key, required this.id, required this.subject});

  @override
  State<TicketPage> createState() => _TicketPageState();
}

class _TicketPageState extends State<TicketPage> {
  final TicketRepository _ticketRepository = getIt();
  late Future<FullTicket> _ticket;
  final textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _ticket = _ticketRepository.getTicketById(widget.id);
  }

  @override
  void dispose() {
    super.dispose();
    textController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.subject),
      ),
      body: Column(
        children: [
          FutureBuilder(
            future: _ticket,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (!snapshot.hasData) return const Text('Нет данных');
              final ticket = snapshot.data!;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Card(
                    child: SizedBox(
                      width: double.infinity,
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        child: Text(ticket.ticket.subject),
                      ),
                    ),
                  ),
                  ...ticket.messages.reversed.map((e) {
                    return Row(
                      children: [
                        if (e.fromType == "client") const Spacer(),
                        Card(
                          child: Container(
                            constraints: const BoxConstraints(
                              minWidth: 100,
                              maxWidth: 300,
                            ),
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  e.fromType == "client"
                                      ? 'Вы'
                                      : 'Тех. поддержка',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15,
                                  ),
                                ),
                                SelectableText(e.text),
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
                  }),
                ],
              );
            },
          ),
          const Spacer(),
          Container(
            margin: const EdgeInsets.all(8),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.inversePrimary,
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: TextField(
                        decoration: const InputDecoration(
                          hintText: 'Введите сообщение...',
                          border: InputBorder.none,
                        ),
                        controller: textController,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8.0),
                IconButton(
                  icon: const Icon(Icons.send),
                  color: Theme.of(context).colorScheme.inversePrimary,
                  onPressed: () async {
                    final ticket = await _ticket;
                    await _ticketRepository.sendMessageToTicketById(
                        ticket.ticket.id, textController.text);
                    textController.text = '';

                    setState(() {
                      _ticket = _ticketRepository.getTicketById(widget.id);
                    });
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
