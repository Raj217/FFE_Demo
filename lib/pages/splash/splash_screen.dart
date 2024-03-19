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

    bool isLoggedIn =
        await Provider.of<AuthProvider>(context, listen: false).loginSilently();
    Future.delayed(Duration(seconds: 3), () {
      logo = Assets.appLogo;
      sub = "Task Zen";
      logoSize = 0.5;
      textSize = 0.1;
      setState(() {});
    });
    Future.delayed(Duration(seconds: 5), () {
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
    });
  }

  @override
  void initState() {
    super.initState();
    init();
  }

  var logo = Assets.gdscLogo;
  var sub = "presents";
  var logoSize = 0.8;
  var textSize = 0.04;

  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ConstrainedBox(
              constraints: BoxConstraints(maxWidth: screen.width * logoSize),
              child: Image.asset(
                logo,
              ),
            ),
            Text(
              sub,
              style: TextStyle(fontSize: screen.width * textSize),
            )
          ],
        ),
      ),
    );
  }
}
