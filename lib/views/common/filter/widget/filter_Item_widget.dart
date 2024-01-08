import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FilterItem extends StatelessWidget {
  final String title;
  final Widget content;

  const FilterItem({super.key, required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(2),
        color: Color.fromRGBO(200, 200, 200, 0.4),
      ),
      width: MediaQuery.sizeOf(context).width * 0.8,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              textAlign: TextAlign.start,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            content,
          ],
        ),
      ),
    );
  }
}
