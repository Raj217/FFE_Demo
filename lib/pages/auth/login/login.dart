import 'package:ffe_demo_app/config/config.dart';
import 'package:ffe_demo_app/states/rive_states/login_character_states_provider.dart';
import 'package:flutter/material.dart';
import 'package:ffe_demo_app/widgets/widgets.dart';
import 'package:ffe_demo_app/utils/utils.dart';
import 'package:provider/provider.dart';

class LoginForm extends StatefulWidget {
  final void Function() onTapSignUp;
  const LoginForm({
    super.key,
    required this.onTapSignUp,
  });

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey emailWidgetKey = GlobalKey();
  final GlobalKey passwordWidgetKey = GlobalKey();
  bool obscurePassword = true;

  void onTapTextField(
    SignupCharacterStatesProvider loginCharacter,
    String? text,
    TextStyle? style,
    GlobalKey key, {
    bool checkForPassword = false,
  }) {
    loginCharacter.isChecking = true;
    loginCharacter.isHandsUp = false;
    if (checkForPassword && obscurePassword) {
      loginCharacter.isHandsUp = true;
    }
    Size? textFieldSize = UIUtils.getWidgetSize(key);
    if (text != null && style != null && textFieldSize != null) {
      loginCharacter.look(
        text: text,
        style: style,
        maxFieldWidth: textFieldSize.width,
      );
    }
  }

  void onTapOutsideTextField(
    SignupCharacterStatesProvider loginCharacter,
  ) {
    loginCharacter.isChecking = false;
    loginCharacter.isHandsUp = false;
  }

  @override
  Widget build(BuildContext context) {
    final TextStyle? textStyle = Theme.of(context).textTheme.bodyMedium;
    return Consumer<SignupCharacterStatesProvider>(
        builder: (context, SignupCharacterStatesProvider loginCharacter, _) {
      return SingleChildScrollView(
        child: Container(
          color: Theme.of(context).scaffoldBackgroundColor,
          padding: const EdgeInsets.fromLTRB(10, 50, 10, 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  CustomTextField(
                    key: emailWidgetKey,
                    keyboardType: TextInputType.emailAddress,
                    label: "Email",
                    controller: emailController,
                    validator: Validator.isEmailValid,
                    onTap: () {
                      onTapTextField(
                        loginCharacter,
                        emailController.text,
                        textStyle,
                        emailWidgetKey,
                      );
                    },
                    onTapOutside: () {
                      onTapOutsideTextField(loginCharacter);
                    },
                    textStyle: textStyle,
                    onChanged: (String? text) {
                      onTapTextField(
                        loginCharacter,
                        emailController.text,
                        textStyle,
                        emailWidgetKey,
                      );
                    },
                  ),
                  CustomTextField(
                    key: passwordWidgetKey,
                    label: "Password",
                    controller: passwordController,
                    validator: Validator.isPasswordValid,
                    obscureText: obscurePassword,
                    onTap: () {
                      onTapTextField(
                        loginCharacter,
                        passwordController.text,
                        textStyle,
                        passwordWidgetKey,
                        checkForPassword: true,
                      );
                    },
                    onTapOutside: () {
                      onTapOutsideTextField(loginCharacter);
                    },
                    textStyle: textStyle,
                    onChanged: (String? text) {
                      onTapTextField(
                        loginCharacter,
                        passwordController.text,
                        textStyle,
                        passwordWidgetKey,
                        checkForPassword: true,
                      );
                    },
                    onSecretChangeButtonPressed: (bool wasObscured) {
                      setState(() {
                        obscurePassword = !wasObscured;
                        loginCharacter.isHandsUp = obscurePassword;
                      });
                    },
                  ),
                  CustomElevatedButton(
                    onPressed: () {
                      loginCharacter.isChecking = false;
                      loginCharacter.isHandsUp = false;
                    },
                    child: const Text("Login"),
                  ),
                ].separate(10),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account? ",
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                  CustomTextButton(
                    onPressed: () {
                      onTapOutsideTextField(loginCharacter);
                      widget.onTapSignUp();
                    },
                    child: Text(
                      "Sign Up",
                      style: Theme.of(context)
                          .textTheme
                          .labelMedium
                          ?.copyWith(decoration: TextDecoration.underline),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      );
    });
  }
}
