import 'package:flutter/material.dart';

class TitleWithIcon extends StatelessWidget {
  final String title;
  final Icon icon;

  const TitleWithIcon({super.key, required this.title, required this.icon});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        icon,
        SizedBox(
          width: 18,
        ),
        Expanded(
            child: Text(
          title,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
        )),
      ],
    );
  }
}