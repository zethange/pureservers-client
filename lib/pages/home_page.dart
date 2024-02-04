import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pureservers/core/di.dart';
import 'package:pureservers/data/server/server.dart' as server;
import 'package:pureservers/data/user/user.dart';
import 'package:pureservers/repositories/server/server_repository.dart';
import 'package:pureservers/repositories/user/user_repository.dart';
import 'package:pureservers/widgets/pay_new_server.dart';
import 'package:pureservers/widgets/server_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with WidgetsBindingObserver {
  final ServerRepository _serverRepository = getIt();
  final UserRepository _userRepository = getIt();

  late Future<List<server.Server>> _futureServers;
  late Future<User?> _user;
  late Timer timer;
  bool _withIndicator = true;

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      setState(() {
        _withIndicator = false;
        _futureServers = _serverRepository.getServers();
      });
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _futureServers = _serverRepository.getServers();
    _user = _userRepository.getUser();

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
      _futureServers = _serverRepository.getServers();
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
          FutureBuilder(
            future: _user,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (!snapshot.hasData) {
                return const Center(
                    child: Text('Не удалось получить пользователя'));
              }

              final user = snapshot.data!;
              return Text(
                  '${user.balance.toStringAsFixed(2)} ${user.currency}');
            },
          ),
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
                    await _serverRepository.stopServer(server.id);

                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('Запрос на остановку сервера отправлен'),
                      ));
                    }
                  },
                  onStart: () async {
                    await _serverRepository.startServer(server.id);

                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('Запрос на старт сервера отправлен'),
                      ));
                    }
                  },
                  onRestart: () async {
                    await _serverRepository.restartServer(server.id);

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
