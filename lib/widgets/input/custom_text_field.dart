import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final EdgeInsets? contentPadding;
  final TextEditingController? controller;
  final bool enabled;
  final Function? validator;
  final IconData? prefixIcon;
  final TextInputType keyboardType;
  final String? label;
  final double? maxWidth;
  final void Function()? onTap;
  final void Function()? onTapOutside;
  final void Function(String? val)? onChanged;
  final bool? obscureText;
  final TextStyle? textStyle;

  /// For cases like where password are being toggled this method will be called
  final void Function(bool isVisible)? onSecretChangeButtonPressed;
  const CustomTextField({
    super.key,
    this.contentPadding,
    this.controller,
    this.enabled = true,
    this.validator,
    this.prefixIcon,
    this.maxWidth,
    this.onTap,
    this.onTapOutside,
    this.onChanged,
    this.textStyle,
    this.keyboardType = TextInputType.text,
    this.label,
    this.obscureText,
    this.onSecretChangeButtonPressed,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: widget.maxWidth ?? 300),
      child: TextFormField(
        onTapOutside: (PointerDownEvent event) {
          FocusManager.instance.primaryFocus?.unfocus();
          if (widget.onTapOutside != null) {
            widget.onTapOutside!();
          }
        },
        onTap: widget.onTap,
        keyboardType: widget.keyboardType,
        obscureText: widget.obscureText ?? false,
        controller: widget.controller,
        onChanged: widget.onChanged,
        style: widget.textStyle ?? Theme.of(context).textTheme.bodyMedium,
        decoration: InputDecoration(
          labelText: widget.label,
          focusColor: Theme.of(context).primaryColor,
          contentPadding: widget.contentPadding ??
              const EdgeInsets.symmetric(horizontal: 10),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          prefixIcon: widget.prefixIcon == null
              ? null
              : Icon(
                  widget.prefixIcon,
                  color: Theme.of(context).primaryColor,
                ),
          suffixIcon: widget.obscureText == null
              ? null
              : IconButton(
                  onPressed: () {
                    if (widget.onSecretChangeButtonPressed != null) {
                      widget.onSecretChangeButtonPressed!(widget.obscureText!);
                    }
                  },
                  icon: Icon(
                    widget.obscureText == true
                        ? Icons.remove_red_eye_outlined
                        : Icons.remove_red_eye_rounded,
                  ),
                ),
        ),
        validator: (value) => widget.validator!(value),
        enabled: widget.enabled,
      ),
    );
  }
}
