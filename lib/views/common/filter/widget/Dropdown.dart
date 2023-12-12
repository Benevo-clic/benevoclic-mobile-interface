import 'package:flutter/material.dart';

var hours = [
  '8:00',
  '8:30',
  '9:00',
  '9h30',
  '10:00',
  '10:30',
  '11h00',
  '11h30',
  '12:00',
  '12:30',
  '13:00',
  '13:30',
  '14h30',
  '15h00',
  '15:30',
  '16:00',
];

class DropDown extends StatelessWidget {
  final String dropDownValue;
  final dynamic fct;

  const DropDown({super.key, required this.dropDownValue, required this.fct});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: DropdownButton(
          value: dropDownValue,
          icon: Icon(Icons.keyboard_arrow_down),
          items: hours.map((hours) {
            return DropdownMenuItem(value: hours, child: Text(hours));
          }).toList(),
          onChanged: (String? newValue) {
            fct(newValue);
          }),
    );
  }
}
