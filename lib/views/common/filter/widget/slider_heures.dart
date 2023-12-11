import 'package:flutter/material.dart';

class SliderExample extends StatefulWidget {
  const SliderExample({super.key});

  @override
  State<SliderExample> createState() => _SliderExampleState();
}

class _SliderExampleState extends State<SliderExample> {
  double _currentSliderPrimaryValue = 0.2;
  double _currentSliderSecondaryValue = 0.5;

  @override
  Widget build(BuildContext context) {
    print(_currentSliderPrimaryValue);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Slider(
          value: _currentSliderPrimaryValue,
          secondaryTrackValue: _currentSliderSecondaryValue,
          label: _currentSliderPrimaryValue.round().toString(),
          onChanged: (double value) {
            setState(() {
              _currentSliderPrimaryValue = value;
            });
          },
        ),
        Slider(
          min: 0,
          max: 1,
          value: _currentSliderSecondaryValue,
          label: _currentSliderSecondaryValue.round().toString(),
          onChanged: (double value) {
            setState(() {
              _currentSliderSecondaryValue = value;
            });
          },
        )
      ],
    );
  }
}
