import 'package:flutter/material.dart';
import 'package:namer_app/util/color.dart';

class SliderHoursState extends StatelessWidget {
  final dynamic fct;
  final double currentValue;

  SliderHoursState({super.key, required this.fct, required this.currentValue});

  @override
  Widget build(BuildContext context) {
    print(currentValue);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Slider(
          thumbColor: marron,
          activeColor: marron,
          value: currentValue,
          max: 4,
          divisions: 4,
          label: currentValue.round().toString(),
          onChanged: (value) {
            fct(value);
          },
        ),
      ],
    );
  }
}
