import 'package:ffe_demo_app/config/config.dart';
import 'package:ffe_demo_app/models/models.dart';
import 'package:ffe_demo_app/states/states.dart';
import 'package:flutter/material.dart';
import 'package:ffe_demo_app/widgets/widgets.dart';
import 'package:ffe_demo_app/utils/utils.dart';
import 'package:provider/provider.dart';

import '../../pages.dart';

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
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final GlobalKey emailWidgetKey = GlobalKey();
  final GlobalKey passwordWidgetKey = GlobalKey();
  final GlobalKey nameWidgetKey = GlobalKey();
  final GlobalKey confirmPasswordWidgetKey = GlobalKey();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool obscurePassword = true;
  bool isSigningUp = false;

  void onTapTextField(
    AuthCharacterStatesProvider signupCharacter,
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
    AuthCharacterStatesProvider signupCharacter,
  ) {
    signupCharacter.isChecking = false;
    signupCharacter.isHandsUp = false;
  }

  Future<void> validateAndLogin(
      AuthCharacterStatesProvider authCharacter) async {
    if (!_formKey.currentState!.validate()) {
      authCharacter.fail();
      return;
    }
    setState(() {
      isSigningUp = true;
    });
    try {
      await Provider.of<AuthProvider>(context, listen: false).signup(
        user: UserModel(
          username: nameController.text,
          mail: emailController.text,
        ),
        password: passwordController.text,
      );
      await authCharacter.success();
      if (mounted) {
        Navigator.pushNamedAndRemoveUntil(
          context,
          Homepage.route,
          (route) => false,
        );
      }
    } catch (e) {
      setState(() {
        isSigningUp = false;
      });
      await authCharacter.fail();
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    final TextStyle? textStyle = Theme.of(context).textTheme.bodyMedium;
    return Consumer<AuthCharacterStatesProvider>(builder: (
      context,
      AuthCharacterStatesProvider authCharacter,
      _,
    ) {
      return SingleChildScrollView(
        child: Container(
          color: Theme.of(context).scaffoldBackgroundColor,
          padding: const EdgeInsets.fromLTRB(10, 50, 10, 0),
          child: Form(
            key: _formKey,
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
                          authCharacter,
                          nameController.text,
                          textStyle,
                          nameWidgetKey,
                        );
                      },
                      validator: Validator.isEmpty,
                      onTapOutside: () {
                        onTapOutsideTextField(authCharacter);
                      },
                      textStyle: textStyle,
                      onChanged: (String? text) {
                        onTapTextField(
                          authCharacter,
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
                          authCharacter,
                          emailController.text,
                          textStyle,
                          emailWidgetKey,
                        );
                      },
                      onTapOutside: () {
                        onTapOutsideTextField(authCharacter);
                      },
                      textStyle: textStyle,
                      onChanged: (String? text) {
                        onTapTextField(
                          authCharacter,
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
                          authCharacter,
                          passwordController.text,
                          textStyle,
                          passwordWidgetKey,
                          checkForPassword: true,
                        );
                      },
                      onTapOutside: () {
                        onTapOutsideTextField(authCharacter);
                      },
                      textStyle: textStyle,
                      onChanged: (String? text) {
                        onTapTextField(
                          authCharacter,
                          passwordController.text,
                          textStyle,
                          passwordWidgetKey,
                          checkForPassword: true,
                        );
                      },
                      onSecretChangeButtonPressed: (bool wasObscured) {
                        setState(() {
                          obscurePassword = !wasObscured;
                          authCharacter.isHandsUp = obscurePassword;
                        });
                      },
                    ),
                    CustomTextField(
                      key: confirmPasswordWidgetKey,
                      label: "Confirm Password",
                      controller: confirmPasswordController,
                      validator: (String? text) {
                        if (text != passwordController.text) {
                          return "Confirm Password must match.";
                        } else {
                          return null;
                        }
                      },
                      obscureText: obscurePassword,
                      onTap: () {
                        onTapTextField(
                          authCharacter,
                          confirmPasswordController.text,
                          textStyle,
                          confirmPasswordWidgetKey,
                          checkForPassword: true,
                        );
                      },
                      onTapOutside: () {
                        onTapOutsideTextField(authCharacter);
                      },
                      textStyle: textStyle,
                      onChanged: (String? text) {
                        onTapTextField(
                          authCharacter,
                          confirmPasswordController.text,
                          textStyle,
                          confirmPasswordWidgetKey,
                          checkForPassword: true,
                        );
                      },
                      onSecretChangeButtonPressed: (bool wasObscured) {
                        setState(() {
                          obscurePassword = !wasObscured;
                          authCharacter.isHandsUp = obscurePassword;
                        });
                      },
                    ),
                    CustomElevatedButton(
                      onPressed: () async {
                        authCharacter.isChecking = false;
                        authCharacter.isHandsUp = false;
                        await validateAndLogin(authCharacter);
                      },
                      child: isSigningUp
                          ? SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                color:
                                    Theme.of(context).scaffoldBackgroundColor,
                                strokeWidth: 3,
                              ),
                            )
                          : const Text("Signup"),
                    ),
                  ].separate(10),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an account? ",
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                    CustomTextButton(
                      onPressed: () {
                        onTapOutsideTextField(authCharacter);
                        widget.onTapSignUp();
                      },
                      child: Text(
                        "Login",
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
        ),
      );
    });
  }
}
