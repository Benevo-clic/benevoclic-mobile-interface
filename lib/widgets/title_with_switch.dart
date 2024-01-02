import 'package:flutter/material.dart';

class TitleWithSwitch extends StatelessWidget {
  String text;
  dynamic content;

  TitleWithSwitch({required this.text, required this.content});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 15, 0, 5),
      child: Row(
        children: [
          Expanded(
              child: Text(
            text,
            style: TextStyle(fontSize: 20),
          )),
          content
        ],
      ),
    );
  }
}
