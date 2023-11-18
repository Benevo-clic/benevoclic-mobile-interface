import 'package:flutter/material.dart';

class Annonce extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 0, 0, 30),
      padding: EdgeInsets.all(20),
      //color: Color.fromRGBO(250, 250, 250, 0.2),
      height: MediaQuery.sizeOf(context).height * 0.2,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.blueAccent,
        ),
        color: Color.fromRGBO(250, 250, 250, 0.5),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Text("bonjour"),
            ],
          ),
        ],
      ),
    );
  }
}
