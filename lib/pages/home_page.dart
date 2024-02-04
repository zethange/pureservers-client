import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pureservers/core/di.dart';
import 'package:pureservers/data/server/server.dart' as server;
import 'package:pureservers/repositories/server/server_repository.dart';
import 'package:pureservers/widgets/pay_new_server.dart';
import 'package:pureservers/widgets/server_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with WidgetsBindingObserver {
  final ServerRepository _repository = getIt();
  late Future<List<server.Server>> _futureServers;
  late Timer timer;
  bool _withIndicator = true;

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      setState(() {
        _withIndicator = false;
        _futureServers = _repository.getServers();
      });
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _futureServers = _repository.getServers();

    startTimer();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  Future<void> _refresh() async {
    setState(() {
      _withIndicator = true;
      _futureServers = _repository.getServers();
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      timer.cancel();
    } else if (state == AppLifecycleState.resumed) {
      startTimer();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        actions: [
          IconButton(
            onPressed: () {
              showModalBottomSheet(
                context: context,
                builder: (context) {
                  return const PayNewServerBottomSheet();
                },
              );
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () => _refresh(),
        child: FutureBuilder(
          future: _futureServers,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting &&
                _withIndicator) {
              return const Center(child: CircularProgressIndicator());
            }

            if (!snapshot.hasData) {
              return const Center(child: Text('Get some error'));
            }
            final servers = snapshot.data!;

            return ListView.builder(
              itemCount: servers.length,
              itemBuilder: (context, index) {
                final server = servers[index];

                return ServerCard(
                  server: server,
                  onStop: () async {
                    await _repository.stopServer(server.id);

                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('Запрос на остановку сервера отправлен'),
                      ));
                    }
                  },
                  onStart: () async {
                    await _repository.startServer(server.id);

                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('Запрос на старт сервера отправлен'),
                      ));
                    }
                  },
                  onRestart: () async {
                    await _repository.restartServer(server.id);

                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content:
                            Text('Запрос на перезагрузку сервера отправлен'),
                      ));
                    }
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}
