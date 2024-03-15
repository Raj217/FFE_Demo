import 'package:flutter/material.dart';

class CustomTextButton extends StatelessWidget {
  final void Function() onPressed;
  final Widget child;
  final bool expandWidth;
  const CustomTextButton({
    super.key,
    required this.onPressed,
    required this.child,
    this.expandWidth = true,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: child,
    );
  }
}
