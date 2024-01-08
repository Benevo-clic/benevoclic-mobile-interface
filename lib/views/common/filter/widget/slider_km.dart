import 'package:flutter/material.dart';

import '../../../../util/color.dart';

class SliderKm extends StatefulWidget {
  final Function(double) onSliderChange;
  final double value;
  final double min;
  final double max;
  final String label;
  final String unit;

  SliderKm({
    required this.onSliderChange,
    required this.value,
    required this.min,
    required this.max,
    required this.label,
    required this.unit,
  });

  @override
  _SliderKmState createState() => _SliderKmState();
}

class _SliderKmState extends State<SliderKm> {
  double _currentValue = 0;

  @override
  void initState() {
    super.initState();
    _currentValue = widget.value;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Slider(
          thumbColor: AA4D4F,
          activeColor: AA4D4F,
          value: _currentValue,
          min: widget.min,
          max: widget.max,
          divisions: 10,
          label: "${_currentValue.round()} ${widget.unit}",
          onChanged: (value) {
            setState(() {
              _currentValue = value;
            });
            widget.onSliderChange(value);
          },
        ),
        Text(
          "${widget.label} : ${_currentValue.round()} ${widget.unit}",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
