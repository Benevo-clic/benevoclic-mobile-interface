import 'package:flutter/material.dart';
import 'package:namer_app/widgets/title_with_icon.dart';

class ParameterCard extends StatelessWidget {
  final String title;
  final Icon icon;
  final dynamic content;

  const ParameterCard(
      {super.key, required this.title, this.content, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TitleWithIcon(
          icon: icon,
          title: title,
        ),
        SizedBox(
          height: 20,
        ),
        content
      ],
    );
  }
}

class ParameterLine extends StatelessWidget {
  final dynamic fct;
  final String title;

  const ParameterLine({super.key, this.fct, required this.title});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (() async {
        await fct(context);
      }),
      child: Row(
        children: [
          Expanded(child: Text(title)),
          Expanded(flex: 0, child: Icon(Icons.arrow_forward_ios_rounded)),
        ],
      ),
    );
  }
}