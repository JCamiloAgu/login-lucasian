import 'package:flutter/material.dart';
import 'package:login_lucasian/features/login/presentation/pages/login/new_login_page.dart';
import 'package:login_lucasian/routes/aplication_routes.dart';
import 'package:login_lucasian/shared/theme/app_theme.dart';

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
      debugShowCheckedModeBanner: false,
      home: NewLoginPage(),
      routes: appRoutes,
      theme: lightThemeData,
    );
  }
}
