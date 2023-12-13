import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  final String image;
  final Widget widget;

  const Background({super.key, required this.widget, required this.image});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            image:
                DecorationImage(image: AssetImage(image), fit: BoxFit.cover)),
        child: widget);
  }
}
