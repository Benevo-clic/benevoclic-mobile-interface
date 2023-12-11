import 'package:flutter/material.dart';
import 'package:namer_app/util/color.dart';
import 'package:namer_app/widgets/abstract_container.dart';

class PublishItem extends StatelessWidget {
  final String content;

  const PublishItem({super.key, required this.content});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AbstractContainer3(content: Center(child: Text(content))),
        AbstractContainer4(
          content: TextFormField(
            decoration: InputDecoration(
                enabledBorder:
                    UnderlineInputBorder(borderSide: BorderSide(color: orange)),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black))),
            style: TextStyle(decorationColor: orange),
            cursorColor: Colors.black,
            textAlign: TextAlign.center,
          ),
        )
      ],
    );
  }
}
