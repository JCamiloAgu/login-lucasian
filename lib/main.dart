import 'package:flutter/material.dart';
import 'package:login_lucasian/ui/pages/login/login_page.dart';
import 'package:login_lucasian/ui/pages/welcome/welcome_page.dart';

import 'injector/dependency_injector.dart' as injector;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await injector.setupInjector();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login Lucasian',
      home: LoginPage(),
      routes: {
        'welcome': (BuildContext context) => WelcomePage(),
      },
    );
  }
}
