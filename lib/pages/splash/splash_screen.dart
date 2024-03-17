import 'package:ffe_demo_app/pages/home/homepage.dart';
import 'package:ffe_demo_app/states/auth/auth.dart';
import 'package:flutter/material.dart';
import 'package:ffe_demo_app/config/config.dart';
import 'package:ffe_demo_app/pages/pages.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  static const String route = "/splash-screen";
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future<void> init() async {
    await dotenv.load();

    bool isLoggedIn = await Provider.of<AuthProvider>(context, listen: false)
        .checkIfUserIsLoggedIn();

    if (isLoggedIn) {
      if (mounted) {
        Navigator.pushNamedAndRemoveUntil(
          context,
          Homepage.route,
          (route) => false,
        );
      }
    } else {
      if (mounted) {
        Navigator.pushNamedAndRemoveUntil(
          context,
          AuthScreen.route,
          (route) => false,
        );
      }
    }
  }

  @override
  void initState() {
    super.initState();
    init();
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
