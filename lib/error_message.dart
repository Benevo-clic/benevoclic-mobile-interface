import 'package:flutter/material.dart';

class ErrorMessage extends StatelessWidget {
  final String type;
  final String message;

  const ErrorMessage({super.key, required this.type, required this.message});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(type),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(message))
      ],
    );
  }
}
