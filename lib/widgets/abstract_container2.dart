import 'package:flutter/material.dart';
import 'package:namer_app/util/color.dart';

class AbstractContainer2 extends StatelessWidget {
  final Widget content;

  const AbstractContainer2({super.key, required this.content});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.sizeOf(context).width*0.85,
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: marron, width: 2)),
      child: content,
    );
  }
}
