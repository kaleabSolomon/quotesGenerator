import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  Button({super.key, required this.text, required this.onPressed});

  VoidCallback onPressed;
  String text;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
        color: Colors.cyan,
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(color: Colors.white),
        ));
  }
}
