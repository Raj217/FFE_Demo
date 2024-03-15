import 'package:ffe_demo_app/config/config.dart';
import 'package:ffe_demo_app/states/rive_states/login_character_states_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rive/rive.dart';

class LoginCharacterAnimation extends StatelessWidget {
  const LoginCharacterAnimation({super.key});

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 300),
      child: RiveAnimation.asset(
        Assets.riveLoginCharacter,
        onInit:
            Provider.of<LoginCharacterStatesProvider>(context, listen: false)
                .onInit,
      ),
    );
  }
}
