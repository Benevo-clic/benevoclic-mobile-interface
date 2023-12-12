import 'package:flutter/material.dart';

class CheckBoxWidget extends StatelessWidget {
  final dynamic fct;
  List<Checked> valuesList;

  CheckBoxWidget({super.key, required this.fct, required this.valuesList});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: valuesList.map((valuesList) {
        return CheckboxListTile(
            title: Text(valuesList.name),
            value: valuesList.checked,
            onChanged: (value) {
              valuesList.checked = value!;
              fct(valuesList);
            });
      }).toList(),
    );
  }
}

class Checked {
  bool checked;
  final String name;

  Checked(this.name, {required this.checked});
}
