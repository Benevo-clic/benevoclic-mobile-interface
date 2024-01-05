import 'package:flutter/material.dart';
import 'package:namer_app/util/color.dart';

class SliderHoursState extends StatelessWidget {
  final dynamic fct;
  final double currentValue;

  SliderHoursState({super.key, required this.fct, required this.currentValue});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Slider(
          thumbColor: AA4D4F,
          activeColor: AA4D4F,
          value: currentValue,
          max: 24,
          divisions: 24,
          label: "${currentValue.round()}h",
          onChanged: (value) {
            fct(value);
          },
        ),
      ],
    );
  }
}
