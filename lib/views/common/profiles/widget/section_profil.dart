import 'package:flutter/material.dart';

class Section extends StatelessWidget {
  final String? text;
  final Icon icon;

  Section({super.key, required this.text, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Row(
        children: [
          Expanded(flex: 0, child: icon),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              text!,
              style: TextStyle(fontSize: 14),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}