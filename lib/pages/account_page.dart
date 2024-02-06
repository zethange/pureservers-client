import 'package:flutter/material.dart';
import 'package:pureservers/core/di.dart';
import 'package:pureservers/pages/invoice_page.dart';
import 'package:pureservers/repositories/auth/auth_repository.dart';

import 'auth_page.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  final AuthRepository _authRepository = getIt();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Аккаунт"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Image(
              image: NetworkImage('https://ru.pureservers.org/images/logo.png'),
              width: 225,
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: 150,
              child: OutlinedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const InvoicePage()));
                },
                child: const Text('Платежи'),
              ),
            ),
            SizedBox(
              width: 150,
              child: FilledButton(
                onPressed: () {
                  _authRepository.logout();
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const AuthPage()));
                },
                child: const Text('Выйти'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
