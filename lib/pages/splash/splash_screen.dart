import 'package:flutter/material.dart';
import 'package:ffe_demo_app/config/config.dart';
import 'package:ffe_demo_app/pages/pages.dart';

class SplashScreen extends StatefulWidget {
  static const String route = "/splash-screen";
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(
      const Duration(seconds: 1),
      () {
        Navigator.pushNamedAndRemoveUntil(
          context,
          AuthScreen.route,
          (route) => false,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: screen.width * .8),
          child: Image.asset(
            Assets.gdscLogo,
          ),
        ),
      ),
    );
  }
}
