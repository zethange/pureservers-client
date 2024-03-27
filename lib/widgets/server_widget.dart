import 'package:flutter/material.dart';
import 'package:pureservers/data/server/server.dart';
import 'package:pureservers/widgets/reinstall_sheet.dart';
import 'package:pureservers/widgets/server_menu.dart';

class ServerCard extends StatelessWidget {
  final Server server;
  final Function onStop;
  final Function onStart;
  final Function onRestart;

  const ServerCard({
    super.key,
    required this.server,
    required this.onStop,
    required this.onStart,
    required this.onRestart,
  });

  @override
  Widget build(BuildContext context) {
    final cpuUsed = (server.state.cpu * 10000).round() / 100;
    final ramUsed = (server.state.ram * 10000).round() / 100;
    final diskUsed = (server.state.disk * 10000).round() / 100;
    return Card(
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  'VPS ${server.numId} — ${server.tariffName}',
                  style: const TextStyle(fontSize: 16),
                ),
                const Spacer(),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(10),
                    ),
                    color: server.getStatusColor(),
                  ),
                  child: Text(server.getStatus()),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                const Text('CPU'),
                const Spacer(),
                Text('${cpuUsed.toString()}% из ${server.state.maxCpu} vCPU'),
              ],
            ),
            LinearProgressIndicator(value: cpuUsed / 100),
            const SizedBox(height: 5),
            Row(
              children: [
                const Text('RAM'),
                const Spacer(),
                Text('$ramUsed% из ${server.state.maxRam} ГБ'),
              ],
            ),
            LinearProgressIndicator(value: ramUsed / 100),
            const SizedBox(height: 5),
            Row(
              children: [
                const Text('Диск'),
                const Spacer(),
                Text('$diskUsed% из ${server.state.maxDisk} ГБ'),
              ],
            ),
            LinearProgressIndicator(value: diskUsed / 100),
            const SizedBox(height: 5),
            Row(
              children: [
                const Text('Имя пользователя'),
                const Spacer(),
                SelectableText(server.username),
              ],
            ),
            const SizedBox(height: 2.5),
            Row(
              children: [
                const Text('Пароль'),
                const Spacer(),
                SelectableText(server.password),
              ],
            ),
            const SizedBox(height: 2.5),
            Row(
              children: [
                const Text('IP-адрес'),
                const Spacer(),
                SelectableText(server.linkedIps.isNotEmpty
                    ? server.linkedIps[0].ip
                    : 'IP не привязан'),
              ],
            ),
            const SizedBox(height: 2.5),
            Row(
              children: [
                const Text('ОС'),
                const Spacer(),
                SelectableText(server.os),
              ],
            ),
            const SizedBox(height: 2.5),
            Row(
              children: [
                const Text('Оплачено до'),
                const Spacer(),
                SelectableText(dateTimeToString(server.expiresAt)),
              ],
            ),
            const SizedBox(height: 2.5),
            Row(
              children: [
                const Text('TUN/TAP'),
                const Spacer(),
                Text(server.getTunTap()),
              ],
            ),
            const SizedBox(height: 2.5),
            Row(
              children: [
                const Text('Nesting'),
                const Spacer(),
                Text(server.getNesting()),
              ],
            ),
            const SizedBox(height: 5),
            Row(
              children: [
                if (server.state.status == "running")
                  Row(
                    children: [
                      Ink(
                        decoration: const ShapeDecoration(
                          color: Colors.redAccent,
                          shape: CircleBorder(),
                        ),
                        child: IconButton(
                          onPressed: () => onStop(),
                          icon: const Icon(Icons.stop),
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(width: 5),
                      Ink(
                        decoration: const ShapeDecoration(
                          color: Colors.amber,
                          shape: CircleBorder(),
                        ),
                        child: IconButton(
                          onPressed: () => onRestart(),
                          icon: const Icon(Icons.restart_alt),
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                if (server.state.status == "stopped")
                  Row(
                    children: [
                      Ink(
                        decoration: const ShapeDecoration(
                          color: Colors.green,
                          shape: CircleBorder(),
                        ),
                        child: IconButton(
                          onPressed: () => onStart(),
                          icon: const Icon(Icons.play_arrow),
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                const Spacer(),
                Ink(
                  decoration: const ShapeDecoration(
                    color: Colors.tealAccent,
                    shape: CircleBorder(),
                  ),
                  child: IconButton(
                    onPressed: () => {
                      showDialog(context: context, builder: (context) {
                        return ServerMenu(server: server);
                      })
                    },
                    icon: const Icon(Icons.menu),
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

String dateTimeToString(DateTime date) {
  return '${date.year}.${9 >= date.month ? "0${date.month}" : date.month}.${date.day > 9 ? date.day : '0${date.day}'} ${date.hour}:${date.minute > 9 ? date.minute : '0${date.minute}'}';
}
