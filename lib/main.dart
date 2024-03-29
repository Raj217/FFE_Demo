import 'package:ffe_demo_app/pages/pages.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'config/config.dart';
import 'states/states.dart';
import 'utils/utils.dart';

void main() {
  runApp(const FFEDemoApp());
}

class FFEDemoApp extends StatelessWidget {
  const FFEDemoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (BuildContext context) => AuthProvider(),
        ),
        ChangeNotifierProvider(
          create: (BuildContext context) => TasksProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: lightTheme,
        routes: {
          SplashScreen.route: (BuildContext context) => const SplashScreen(),
          AuthScreen.route: (BuildContext context) => const AuthScreen(),
          Homepage.route: (BuildContext context) => const Homepage(),
        },
        builder: ErrorHandler.handle,
        initialRoute: SplashScreen.route,
      ),
    );
  }
}
