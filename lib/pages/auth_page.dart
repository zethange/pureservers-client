import 'package:flutter/material.dart';
import 'package:pureservers/core/di.dart';
import 'package:pureservers/data/status.dart';
import 'package:pureservers/pages/entry_page.dart';
import 'package:pureservers/repositories/auth/auth_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<StatefulWidget> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final AuthRepository _repository = getIt();
  final _email = TextEditingController();
  final _password = TextEditingController();

  Future<void> _onPressed() async {
    if (_email.text == "" && _password.text == "") return;
    final Status data = await _repository.login(_email.text, _password.text);

    debugPrint(data.success.toString());
    if (context.mounted) {
      // show snackbar
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(data.message),
        duration: const Duration(seconds: 1),
      ));
    }

    if (data.success) {
      final SharedPreferences preferences =
          await SharedPreferences.getInstance();

      preferences.setString("email", _email.text);
      preferences.setString("password", _password.text);

      if (context.mounted) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => const EntryPage(),
          ),
          (route) => false,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Авторизация'),
      ),
      body: Container(
        padding: const EdgeInsets.only(left: 50, right: 50, bottom: 75),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Image(
                image:
                    NetworkImage('https://ru.pureservers.org/images/logo.png'),
                width: 250,
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _email,
                decoration: const InputDecoration(
                  hintText: 'Введите email...',
                ),
              ),
              const SizedBox(height: 5),
              TextFormField(
                obscureText: true,
                controller: _password,
                decoration: const InputDecoration(
                  hintText: 'Введите пароль...',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Пожалуйста, введите пароль';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: 1000,
                child: FilledButton(
                  onPressed: _onPressed,
                  child: const Text('Войти'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
