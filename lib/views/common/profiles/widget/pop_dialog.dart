import 'package:flutter/material.dart';

class PopDialog extends StatelessWidget {
  final dynamic content;

  const PopDialog({super.key, this.content});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SimpleDialog(
          title: Padding(
              padding: const EdgeInsets.fromLTRB(0, 35, 0, 35),
              child: content)),
    );
  }
}