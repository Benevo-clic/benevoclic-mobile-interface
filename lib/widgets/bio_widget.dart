import 'package:flutter/material.dart';

class BioWidget extends StatelessWidget {
  final String description;
  final String title;
  final bool? sizeRaduis;

  BioWidget(
      {super.key,
      required this.description,
      required this.title,
      this.sizeRaduis});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 15, right: 15, top: 10),
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
          borderRadius: sizeRaduis == false || sizeRaduis == null
              ? BorderRadius.circular(20)
              : BorderRadius.circular(15),
          border: Border.all(color: Colors.red, width: 1)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
                fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black),
          ),
          SizedBox(height: 5),
          Text(
            description,
            style: TextStyle(fontSize: 10),
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }
}
