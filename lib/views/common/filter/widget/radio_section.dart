import 'package:flutter/material.dart';
import 'package:namer_app/util/color.dart';
import 'package:namer_app/views/common/filter/enum_tri.dart';

class RadioSection extends StatelessWidget {
  final Tri tri;
  final dynamic fct;

  RadioSection({super.key, required this.tri, required this.fct});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      RadioButton(fct: fct, tri: tri, name: "Récent", triValue: Tri.recent),
      RadioButton(fct: fct, tri: tri, name: "Ancient", triValue: Tri.ancient),
      RadioButton(
          fct: fct, tri: tri, name: "Proximite", triValue: Tri.proximite),
    ]);
  }
}

class RadioButton extends StatelessWidget {
  final Tri tri;
  final dynamic fct;
  final String name;
  final Tri triValue;

  RadioButton(
      {super.key,
      required this.tri,
      required this.fct,
      required this.name,
      required this.triValue});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(name),
      leading: Radio(
        activeColor: marron,
        value: triValue,
        groupValue: tri,
        onChanged: (value) {
          fct(value);
        },
      ),
    );
  }
}
