import 'package:flutter/material.dart';
import 'package:namer_app/util/color.dart';

class AbstractContainer extends StatelessWidget {
  final Widget content;

  const AbstractContainer({super.key, required this.content});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(10, 8, 10, 8),
      width: MediaQuery.sizeOf(context).width * 0.85,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: orange, width: 2)),
      child: content,
    );
  }
}

class AbstractContainer3 extends StatelessWidget {
  final Widget content;

  const AbstractContainer3({super.key, required this.content});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(10, 8, 10, 8),
      width: MediaQuery.sizeOf(context).width * 0.85,
      decoration: BoxDecoration(
          borderRadius:
              BorderRadiusDirectional.vertical(top: Radius.circular(15)),
          border: Border.all(color: orange, width: 2)),
      child: content,
    );
  }
}

class AbstractContainer4 extends StatelessWidget {
  final Widget content;

  const AbstractContainer4({super.key, required this.content});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(10, 8, 10, 8),
      width: MediaQuery.sizeOf(context).width * 0.85,
      decoration: BoxDecoration(
          borderRadius:
              BorderRadiusDirectional.vertical(bottom: Radius.circular(5)),
          border: Border.all(color: orange, width: 2)),
      child: content,
    );
  }
}
