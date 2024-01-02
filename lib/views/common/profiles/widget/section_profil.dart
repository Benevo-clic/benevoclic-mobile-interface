import 'package:flutter/material.dart';
import 'package:namer_app/util/color.dart';

class Section extends StatelessWidget {
  final String text;
  final Icon icon;

  Section({super.key, required this.text, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration:
            BoxDecoration(border: Border(bottom: BorderSide(color: orange))),
        child: Row(
          children: [
            Expanded(flex: 0, child: icon),
            SizedBox(
              width: 5,
            ),
            Text(
              text,
            ),
          ],
        ));
  }
}