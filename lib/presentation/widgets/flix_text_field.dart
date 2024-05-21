import '../misc/constants.dart';
import 'package:flutter/material.dart';

class FlixTextField extends StatelessWidget {
  final String labelText;
  final TextEditingController controller;
  final bool obscureText;
  final bool enabled;
  const FlixTextField(
      {super.key,
      required this.labelText,
      required this.controller,
      this.obscureText = false,
      this.enabled = true});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      enabled: enabled,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: const TextStyle(color: ghostWhite),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: enabled ? Colors.grey.shade800 : Colors.grey)),
        focusedBorder:
            const OutlineInputBorder(borderSide: BorderSide(color: ghostWhite)),
      ),
    );
  }
}
