import 'package:ffe_demo_app/pages/auth/login/login.dart';
import 'package:ffe_demo_app/pages/auth/signup/signup.dart';
import 'widgets/auth_character_animation.dart';
import 'package:ffe_demo_app/states/states.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthScreen extends StatefulWidget {
  static const String route = "/auth-screen";
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  late final PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: 1);
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;
    return ChangeNotifierProvider(
      create: (BuildContext context) => AuthCharacterStatesProvider(),
      child: Builder(builder: (context) {
        return Scaffold(
          body: SafeArea(
            child: SizedBox(
              width: screen.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Expanded(
                    child: AuthCharacterAnimation(),
                  ),
                  Expanded(
                    flex: 2,
                    child: PageView(
                      physics: const NeverScrollableScrollPhysics(),
                      controller: pageController,
                      children: [
                        Container(
                          width: 10,
                          color: Theme.of(context).scaffoldBackgroundColor,
                        ),
                        LoginForm(
                          onTapSignUp: () {
                            pageController.animateToPage(
                              2,
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.easeInBack,
                            );
                          },
                        ),
                        SignupForm(
                          onTapSignUp: () {
                            pageController.animateToPage(
                              1,
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.easeInBack,
                            );
                          },
                        ),
                        Container(
                          width: 10,
                          color: Theme.of(context).scaffoldBackgroundColor,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
