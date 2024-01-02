import 'package:flutter/material.dart';

class SwitchButton extends StatelessWidget {
  bool value;
  dynamic fct;

  SwitchButton({required this.value, required this.fct});

  @override
  Widget build(BuildContext context) {
    return Switch(
      value: value,
      activeColor: Colors.red,
      onChanged: (bool value) {
        fct(value);
        print(value);
      },
    );
  }
}
