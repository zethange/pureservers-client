import 'package:flutter/material.dart';
import 'package:pureservers/data/server/server.dart' as server_data;
import 'package:pureservers/repositories/server/server_repository.dart';
import 'package:pureservers/widgets/reinstall_sheet.dart';

import '../core/di.dart';

class ServerMenu extends StatefulWidget {
  final server_data.Server server;

  const ServerMenu({super.key, required this.server});

  @override
  State<ServerMenu> createState() => _ServerMenuState();
}

class _ServerMenuState extends State<ServerMenu> {
  final ServerRepository serverRepository = getIt();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FilledButton(
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return ReinstallSheet(
                      serverId: widget.server.id,
                    );
                  },
                );
              },
              child: const Text('Переустановить'),
            ),
            if (widget.server.nestingEnabled == null)
              FilledButton(
                onPressed: () async {
                  final status =
                      await serverRepository.enableNesting(widget.server.id);
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(status.message),
                    ));
                  }
                },
                child: const Text('Включить nesting'),
              ),
            if (widget.server.nestingEnabled == null)
              FilledButton(
                onPressed: () async {
                  final status = await serverRepository.enableTun(
                    widget.server.id,
                  );
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(status.message),
                    ));
                  }
                },
                child: const Text('Включить TUN/TAP'),
              ),
          ],
        ),
      ),
    );
  }
}
