import 'package:flutter/material.dart';
import 'package:pureservers/core/di.dart';
import 'package:pureservers/pages/auth_page.dart';
import 'package:pureservers/pages/home_page.dart';
import 'package:pureservers/repositories/auth_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final preferences = await SharedPreferences.getInstance();
  await configureDependence();
  if (preferences.containsKey('email') && preferences.containsKey('password')) {
    final email = preferences.getString('email');
    final password = preferences.getString('password');
    await getIt<AuthRepository>().login(email!, password!);
    runApp(const PureServersApp(homePage: HomePage(title: 'PureServers')));
  } else {
    runApp(const PureServersApp(homePage: AuthPage()));
  }
}

class PureServersApp extends StatelessWidget {
  final Widget homePage;
  const PureServersApp({super.key, required this.homePage});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PureServers',
      darkTheme: ThemeData.dark(),
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.cyanAccent),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: homePage,
    );
  }
}
