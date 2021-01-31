import 'package:flutter/material.dart';
import 'package:login_lucasian/features/welcome/presentation/pages/welcome/welcome_page.dart';

final Map<String, Widget Function(BuildContext)> appRoutes = {
  loginRoute: (_) => WelcomePage(),
  welcomeRoute: (_) => WelcomePage(),
};

final loginRoute = 'login';
final welcomeRoute = 'welcome';
