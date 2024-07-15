import '../misc/constants.dart';
import 'package:flutter/material.dart';

class FlixTextField extends StatelessWidget {
  final String labelText;
  final TextEditingController controller;
  final bool obscureText;
  final bool enabled;
  final TextInputType? keyboardType;
  const FlixTextField(
      {super.key,
      required this.labelText,
      required this.controller,
      this.obscureText = false,
      this.enabled = true,
      this.keyboardType});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      enabled: enabled,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: const TextStyle(color: ghostWhite),
        disabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: enabled ? Colors.grey.shade800 : Colors.grey)),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: enabled ? Colors.grey.shade800 : Colors.grey)),
        focusedBorder:
            const OutlineInputBorder(borderSide: BorderSide(color: ghostWhite)),
      ),
    );
  }
}

class InputPassword extends StatefulWidget {
  const InputPassword(
      {super.key, this.controller, this.validator, required this.labelText});

  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final String labelText;

  @override
  State<InputPassword> createState() => _InputPasswordState();
}

class _InputPasswordState extends State<InputPassword> {
  bool passwordVisible = false;

  @override
  void initState() {
    super.initState();
    passwordVisible = true;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: widget.validator,
      obscureText: passwordVisible,
      controller: widget.controller,
      decoration: InputDecoration(
        labelText: widget.labelText,
        labelStyle: const TextStyle(color: ghostWhite),
        disabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade800)),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade800)),
        focusedBorder:
            const OutlineInputBorder(borderSide: BorderSide(color: ghostWhite)),
        hintText: "Password",
        suffixIcon: IconButton(
          icon: Icon(passwordVisible ? Icons.visibility : Icons.visibility_off),
          onPressed: () {
            setState(
              () {
                passwordVisible = !passwordVisible;
              },
            );
          },
        ),
        alignLabelWithHint: false,
      ),
      keyboardType: TextInputType.visiblePassword,
      textInputAction: TextInputAction.done,
    );
  }
}
