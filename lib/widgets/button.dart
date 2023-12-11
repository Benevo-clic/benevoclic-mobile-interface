import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final String text;
  final Color backgroundColor;
  final Color color;
  final VoidCallback fct;

  Button(
      {super.key,
      required this.text,
      required this.color,
      required this.fct,
      required this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    return TextButton(
        style: ButtonStyle(
            backgroundColor: MaterialStatePropertyAll(backgroundColor)),
        onPressed: fct,
        child: Text(
          text,
          style: TextStyle(color: color),
        ));
  }
}
