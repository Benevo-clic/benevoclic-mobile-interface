import 'package:flutter/material.dart';

class ContentWidget extends StatelessWidget {
  final Widget content;

  const ContentWidget({super.key, required this.content});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
      width: MediaQuery.of(context).size.width * 1,
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 0,
              blurRadius: 5,
              offset: Offset(0, 6),
            ),
          ],
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Colors.red, width: 1)),
      child: content,
    );
  }
}
