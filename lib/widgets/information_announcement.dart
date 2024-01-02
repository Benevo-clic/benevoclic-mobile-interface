import 'package:flutter/material.dart';

class InformationAnnouncement extends StatelessWidget {
  final Icon icon;
  final String text;
  double? size;

  InformationAnnouncement(
      {super.key, required this.icon, required this.text, this.size});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        icon,
        Text(text,
            style: TextStyle(
              fontSize: size ?? 14,
            ))
      ],
    );
  }
}
