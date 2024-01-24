import 'package:flutter/material.dart';

class InputBox extends StatelessWidget {
  final String hint;
  final TextEditingController controller;
  final bool obscureText;
  final TextInputType? type;
  final bool suggestions;
  final bool autocorrect;


  const InputBox({super.key,
    required this.hint,
    required this.controller,
    required this.obscureText,
    required this.type,
    required this.suggestions,
    required this.autocorrect,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      cursorColor: Colors.cyanAccent,
      controller: controller,
      decoration: InputDecoration(
        hintText: hint,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10)
        )
      ),
      obscureText: obscureText,
      keyboardType: type,
      enableSuggestions: suggestions,
      autocorrect: autocorrect,
      maxLines: 1,
    );
  }
}
