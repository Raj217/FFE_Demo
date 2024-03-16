import 'package:ffe_demo_app/config/config.dart';
import 'package:ffe_demo_app/states/rive_states/login_character_states_provider.dart';
import 'package:flutter/material.dart';
import 'package:ffe_demo_app/widgets/widgets.dart';
import 'package:ffe_demo_app/utils/utils.dart';
import 'package:provider/provider.dart';

class SignupForm extends StatefulWidget {
  final void Function() onTapSignUp;
  const SignupForm({
    super.key,
    required this.onTapSignUp,
  });

  @override
  State<SignupForm> createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey emailWidgetKey = GlobalKey();
  final GlobalKey passwordWidgetKey = GlobalKey();
  final GlobalKey nameWidgetKey = GlobalKey();
  bool obscurePassword = true;

  void onTapTextField(
      SignupCharacterStatesProvider signupCharacter,
      String? text,
      TextStyle? style,
      GlobalKey key, {
        bool checkForPassword = false,
      }) {
    signupCharacter.isChecking = true;
    signupCharacter.isHandsUp = false;
    if (checkForPassword && obscurePassword) {
      signupCharacter.isHandsUp = true;
    }
    Size? textFieldSize = UIUtils.getWidgetSize(key);
    if (text != null && style != null && textFieldSize != null) {
      signupCharacter.look(
        text: text,
        style: style,
        maxFieldWidth: textFieldSize.width,
      );
    }
  }

  void onTapOutsideTextField(
      SignupCharacterStatesProvider signupCharacter,
      ) {
    signupCharacter.isChecking = false;
    signupCharacter.isHandsUp = false;
  }

  @override
  Widget build(BuildContext context) {
    final TextStyle? textStyle = Theme.of(context).textTheme.bodyMedium;
    return Consumer<SignupCharacterStatesProvider>(
        builder: (context, SignupCharacterStatesProvider signupCharacter, _) {
          return Container(
            color: Theme.of(context).scaffoldBackgroundColor,
            padding: const EdgeInsets.fromLTRB(10, 50, 10, 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    CustomTextField(
                      key: nameWidgetKey,
                      keyboardType: TextInputType.name,
                      label: "Name",
                      controller: nameController,
                      onTap: () {
                        onTapTextField(
                          signupCharacter,
                          nameController.text,
                          textStyle,
                          nameWidgetKey,
                        );
                      },
                      onTapOutside: () {
                        onTapOutsideTextField(signupCharacter);
                      },
                      textStyle: textStyle,
                      onChanged: (String? text) {
                        onTapTextField(
                          signupCharacter,
                          nameController.text,
                          textStyle,
                          nameWidgetKey,
                        );
                      },
                    ),
                    CustomTextField(
                      key: emailWidgetKey,
                      keyboardType: TextInputType.emailAddress,
                      label: "Email",
                      controller: emailController,
                      validator: Validator.isEmailValid,
                      onTap: () {
                        onTapTextField(
                          signupCharacter,
                          emailController.text,
                          textStyle,
                          emailWidgetKey,
                        );
                      },
                      onTapOutside: () {
                        onTapOutsideTextField(signupCharacter);
                      },
                      textStyle: textStyle,
                      onChanged: (String? text) {
                        onTapTextField(
                          signupCharacter,
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
                          signupCharacter,
                          passwordController.text,
                          textStyle,
                          passwordWidgetKey,
                          checkForPassword: true,
                        );
                      },
                      onTapOutside: () {
                        onTapOutsideTextField(signupCharacter);
                      },
                      textStyle: textStyle,
                      onChanged: (String? text) {
                        onTapTextField(
                          signupCharacter,
                          passwordController.text,
                          textStyle,
                          passwordWidgetKey,
                          checkForPassword: true,
                        );
                      },
                      onSecretChangeButtonPressed: (bool wasObscured) {
                        setState(() {
                          obscurePassword = !wasObscured;
                          signupCharacter.isHandsUp = obscurePassword;
                        });
                      },
                    ),
                    CustomElevatedButton(
                      onPressed: () {
                        signupCharacter.isChecking = false;
                        signupCharacter.isHandsUp = false;
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
                        onTapOutsideTextField(signupCharacter);
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
          );
        });
  }
}
