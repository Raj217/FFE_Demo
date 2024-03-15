import 'package:ffe_demo_app/pages/pages.dart';
import 'package:flutter/material.dart';
import 'config/config.dart';

void main() {
  runApp(const FFEDemoApp());
}

class FFEDemoApp extends StatelessWidget {
  const FFEDemoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: lightTheme,
      routes: {
        SplashScreen.route: (BuildContext context) => const SplashScreen(),
        AuthScreen.route: (BuildContext context) => const AuthScreen(),
      },
      initialRoute: SplashScreen.route,
    );
  }
}
